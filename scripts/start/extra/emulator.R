# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: run simulations for calculation of MAgPIE emulators
# ---------------------------------------------------------------

#########################################################
#### Start MAgPIE runs to derive price emulator from ####
#########################################################

library(gms)
library(magpie4)
library(txtplot)
library(lucode2)

source("scripts/start_functions.R")
source("config/default.cfg")

###############################################################
##################### General settings ########################
###############################################################

cfg$qos <- "standby"
cfg$results_folder  <- "output/:title:"
cfg$output          <- c("rds_report","extra/emulator") #unique(c(cfg$output,"remind","bioenergy","coupling_report","david"))
cfg$gms$s60_2ndgen_bioenergy_dem_min <- 0

# Download bioenergy demand scenarios
filemap <- gms::download_unpack(input="emulator.tgz", targetdir="input", repositories=list("/p/projects/landuse/data/input/archive"=NULL), debug=FALSE)
d <- readRDS("input/emulator.Rdata")
demand <- time_interpolate(d,interpolated_year=seq(1995,2100,5),extrapolation_type="constant")
getSets(demand) <- getSets(d)
# add years after 2100
demand <- add_columns(demand,dim = 2.1,addnm = c("y2110","y2130","y2150"))
# keep demand constant after 2100
demand[,c("y2110","y2130","y2150"),] <- setYears(demand[,"y2100",])

scenarios <- read.csv2("config/scenario_config_emulator.csv",strip.white=TRUE,stringsAsFactors=FALSE)
scenarios <- subset(scenarios, subset=(start == "1"))

###############################################################
######################## Functions ############################
###############################################################

# Read GHG prices from REMIND or coupled mif file
write.ghgtax <- function(mifname, outfile) {

  fname <- paste0(mifname, ".mif")

  if(!file.exists(fname)) stop("Could not find ",fname)

  # If there is a REMIND report with the name, read the GHG prices from the file, otherwise calculate expo-linear tax
  cat("Loading GHG prices from",fname,"\n")
  tmp <- read.report(fname, as.list = FALSE)

  # Select variables from REMIND report
  ghg_price_names <- c("Price|Carbon (US$2005/t CO2)",
                       "Price|N2O (US$2005/t N2O)",
                       "Price|CH4 (US$2005/t CH4)")
  tmp <- collapseNames(tmp[,,ghg_price_names])
  # remove global dimension
  tmp <- tmp["GLO",,,invert=TRUE]

  # interpolate missing years (REMIND has less_TS only, emulator script need 5 year time steps)
  time <- seq(1995,2100,5)
  tmp <- time_interpolate(tmp,interpolated_year=time,extrapolation_type="constant")

  ghgtax <- new.magpie(cells_and_regions = getRegions(tmp),years = time,fill = NA,sets = c("regions","years","gas"),names = c("n2o_n_direct","n2o_n_indirect","ch4","co2_c"))

  # unit defined in modules/56_ghg_policy/input/f56_pollutant_prices.cs3: US$ 2005 per Mg N2O-N CH4 and CO2-C
  ghgtax[,,"co2_c"]          <- tmp[,,"Price|Carbon (US$2005/t CO2)"] * 44/12  # US$2005/tCO2 -> US$2005/tC
  ghgtax[,,"ch4"]            <- tmp[,,"Price|CH4 (US$2005/t CH4)"]
  ghgtax[,,"n2o_n_direct"]   <- tmp[,,"Price|N2O (US$2005/t N2O)"] * 44/28     # US$2005/tN2O -> US$2005/tN
  ghgtax[,,"n2o_n_indirect"] <- tmp[,,"Price|N2O (US$2005/t N2O)"] * 44/28     # US$2005/tN2O -> US$2005/tN

  # set ghg prices before and in 2020 to zero
  ghgtax[,getYears(ghgtax)<="y2020",] <- 0
  # add years after 2100
  ghgtax <- add_columns(ghgtax,dim = 2.1,addnm = c("y2110","y2130","y2150"))
  # keep ghgtax constant after 2100
  ghgtax[,c("y2110","y2130","y2150"),] <- setYears(ghgtax[,"y2100",])

  # create textplot
  cat("CO2 price in 2025:",ghgtax[,2025,"co2_c"],"\n")
  for_plot <- ghgtax[1,,"co2_c"] * 12/44 # convert unit back just for plotting
  #for_plot <- for_plot[,c("y1995","y2110","y2130","y2150"),,invert=TRUE]
  txtplot(as.numeric(gsub("y","",getYears(for_plot))),for_plot,ylab="US$2005/tCO2")

  cat("Writing GHG tax scenario",scenarios[scen,"ghgtax_name"],"\n\n")
  write.magpie(ghgtax, file_name = outfile)

  #library(ggplot2)
  #library(luplot)
  #ggplot(gginput(as.magpie(co2tax)), aes(x=year, y=.value)) + geom_line()
}

###############################################################
################# Individual scenarios ########################
###############################################################

for (scen in rownames(scenarios)) {

  cat("\n################ Scenario",scen,"################\n")
  # Configure MAgPIE
  # Set scenario
  cfg<-setScenario(cfg,scenario = c(trimws(unlist(strsplit(scenarios[scen,"mag_scen"],split="\\|")))))
  # emulator has to be set AFTER SSP because SSP would set bioenergy demand to predefined scenario and not to input from this script
  cfg<-setScenario(cfg,scenario="emulator")

  # Choose GHG tax scenario
  if (scenarios[scen,"mifname"] == "built-in") {
    # see magpie/config/default.cfg for available scenarios
    cfg$gms$c56_pollutant_prices <- scenarios[scen,"ghgtax_name"]
  } else {
    # If no built-in GHG price scenario was chosen, take GHG prices from REMIND report
    cfg$gms$c56_pollutant_prices <- "emulator"
    cfg$gms$c56_mute_ghgprices_until <- scenarios[scen, "no_ghgprices_land_until"]
    write.ghgtax(mifname = scenarios[scen, "mifname"], outfile = "./modules/56_ghg_policy/input/f56_pollutant_prices_emulator.cs3")
  }

  # Compose string with scenario name
  expname <- paste0(gsub("\\|","-",scenarios[scen,"mag_scen"]),"-",scenarios[scen,"ghgtax_name"])

  # run numbers sorted descending by runtime (determined with script sort_runtimes.R from dklein)
  runtime_order <- c('32','68','5','46','22','58','41','53','65','11','10','12','47','70','17','34','56','18','54','29',
  '62','57','2','26','48','51','20','8','15','52','21','44','16','30','71','38','13','50','67','35','45','1','37','6','31',
  '49','40','24','60','69','14','4','9','33','66','61','64','25','42','55','28','23','19','7','43','59','63','39','3','72','73','36','27')
  # the intersect command in the for-loop below keeps the order of the vector given first

  # Copy bioenergy demand files and start runs
  for(r in intersect(runtime_order,getNames(demand))) {
  #for(r in as.character(c(1))) {
    cfg$title <- paste(expname,r,sep="-")
    cat(cfg$title,"Writing bioenergy demand scenario",r,"\n")
    # create text plot
    dem <- dimSums(demand[,,r],dim=1)
    for_plot <- dem/1000
    #for_plot <- for_plot[,c("y1995","y2110","y2130","y2150"),,invert=TRUE]
    txtplot(as.numeric(gsub("y","",getYears(for_plot))),for_plot,ylab="EJ/yr")
    write.magpie(setNames(dem,NULL), file_name = "./modules/60_bioenergy/input/glo.2ndgen_bioenergy_demand.csv")
    manipulateConfig(paste0("scripts/run_submit/submit_", cfg$qos, ".sh"), "--job-name" = cfg$title, line_endings = "NOTwin")
    start_run(cfg,codeCheck=FALSE)
  }
}

cat("Finished starting of emulator runs!\n")
