#########################################################
#### Start MAgPIE runs to derive price emulator from ####
#########################################################

library(lucode)
library(magpie4)

source("scripts/start_functions.R")
source("config/default.cfg")

###############################################################
##################### General settings ########################
###############################################################

cfg$results_folder  <- "output/:title:"
cfg$output          <- c("report","emu20_single_remulator") #unique(c(cfg$output,"remind","bioenergy","coupling_report","david"))

# use "old" regions: c30c1c580039c2b300d86cc46ff4036a
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-noco2_rev28_h200_c30c1c580039c2b300d86cc46ff4036a.tgz", 
               "rev3.13_c30c1c580039c2b300d86cc46ff4036a_magpie.tgz",
               "rev3.13_c30c1c580039c2b300d86cc46ff4036a_validation.tgz",
               "additional_data_rev3.24.tgz",
               "npi_ndc_base_fixed.tgz")

# Download bioenergy demand scenarios
filemap <- lucode::download_unpack(input="emulator.tgz", targetdir="input", repositories=list("/p/projects/landuse/data/input/archive"=NULL), debug=FALSE)
d <- readRDS("input/emulator.Rdata")
demand <- time_interpolate(d,interpolated_year=seq(1995,2100,5),extrapolation_type="constant")
getSets(demand) <- getSets(d)
# add years after 2100
demand <- add_columns(demand,dim = 2.1,addnm = c("y2110","y2130","y2150"))
# keep demand constant after 2100
demand[,c("y2110","y2130","y2150"),] <- setYears(demand[,"y2100",])

#reg <- read.csv2(cfg$regionmapping) # read regional resolution, used for ghg tax
reg <- list(RegionCode = getRegions(demand))

scenarios <- read.csv2("config/scenario_config_emulator.csv",strip.white=TRUE)
scenarios <- subset(scenarios, subset=(start == "1"))

###############################################################
######################## Functions ############################
###############################################################

# calculate expoLinear tax with transition in 2060
write.ghgtax <- function(co2tax_2025=NULL,regions=NULL,out="./modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3") {
  
  # First year with global uniform CO2 price is 2025
  # Values taken from reporting in /p/projects/remind/runs/r7034/
  # SSP1-26-load_2017-02-03_19.27.43: 48.1662949 US$2005/tCO2
  # SSP2-26-load_2017-02-03_21.28.48: 61.6774368 US$2005/tCO2

  if(is.null(co2tax_2025)) stop("No initial value for ghg tax supplied.")
  if(is.null(regions))     stop("Please supply regions for ghg tax.")

  # construct combination of exponential tax (5% increase) until 2060 and linear continuation thereafter (using the slope of 2055-2060)
  time <- seq(1995,2100,5)
  co2tax <- as.numeric(co2tax_2025) * 1.05 ^(time-2025)
  names(co2tax)<-time
  slope <- (co2tax["2060"] - co2tax["2055"]) / (2060 - 2055)
  co2tax[names(co2tax)>"2060"] <- co2tax["2060"] + slope * (time[time>2060] - 2060)

  ghgtax <- new.magpie(cells_and_regions = regions,years = time,fill = NA,sets = c("regions","years","gas"),names = c("n2o_n_direct","n2o_n_indirect","ch4","co2_c"))
  
  ghgtax[,,"co2_c"]          <- as.magpie(co2tax) * 0.967 * 44/12       # US$2005/tCO2 -> US$2004/tC
  ghgtax[,,"ch4"]            <- as.magpie(co2tax) * 0.967 * 25          # US$2005/tCO2 -> US$2004/tCH4
  ghgtax[,,"n2o_n_direct"]   <- as.magpie(co2tax) * 0.967 * 44/28 * 300 # US$2005/tCO2 -> US$2004/tN
  ghgtax[,,"n2o_n_indirect"] <- as.magpie(co2tax) * 0.967 * 44/28 * 300 # US$2005/tCO2 -> US$2004/tN
  
  # set ghg prices before 2020 to zero
  ghgtax[,getYears(ghgtax)<"y2020",] <- 0
  # add years after 2100
  ghgtax <- add_columns(ghgtax,dim = 2.1,addnm = c("y2110","y2130","y2150"))
  # keep ghgtax constant after 2100
  ghgtax[,c("y2110","y2130","y2150"),] <- setYears(ghgtax[,"y2100",])
  
  write.magpie(ghgtax,file_name = out)

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
  cfg<-setScenario(cfg,scenario=as.character(scenarios[scen,"SSP"]))
  # emulator has to be set AFTER SSP because SSP would set bioenergy demand to predefined scenario and not to input from this script
  cfg<-setScenario(cfg,scenario="emulator")

  # Choose GHG tax scenario
  if (scenarios[scen,"co2tax_2025"] == "built-in") {
    cfg$gms$c56_pollutant_prices <- scenarios[scen,"co2tax_name"]
    # *   options:  SSP1-Ref-SPA0, SSP2-Ref-SPA0, SSP5-Ref-SPA0,
    # *             SSP1-26-SPA0,  SSP1-37-SPA0,  SSP1-45-SPA0,
    # *             SSP2-26-SPA0,  SSP2-37-SPA0,  SSP2-45-SPA0, SSP2-60-SPA0,
    # *             SSP5-26-SPA0,  SSP5-37-SPA0,  SSP5-45-SPA0, SSP5-60-SPA0,
    # *             SSP1-26-SPA1,  SSP1-37-SPA1,  SSP1-45-SPA1,
    # *             SSP2-26-SPA2,  SSP2-37-SPA2,  SSP2-45-SPA2, SSP2-60-SPA2,
    # *             SSP5-26-SPA5,  SSP5-37-SPA5,  SSP5-45-SPA5, SSP5-60-SPA5,
    # *             coupling
  } else {
    # If none of the built-in GHG price scenarios was chosen, provide GHG prices
    cfg$gms$c56_pollutant_prices <- "coupling"
    cat("Writing GHG tax scenario",scenarios[scen,"co2tax_name"],"\n\n")
    write.ghgtax(co2tax_2025=scenarios[scen,"co2tax_2025"],regions=unique(reg$RegionCode))
  }

  # Compose string with scenario name
  expname <- paste0(scenarios[scen,"SSP"],"-",scenarios[scen,"co2tax_name"])

  # Copy bioenergy demand files and start runs
  for(r in getNames(demand)) { # as.character(c(1:9,73))
    cfg$title <- paste(expname,r,sep="-")
    cat(cfg$title,"Writing bioenergy demand scenario",r,"\n")
    write.magpie(setNames(demand[,,r],NULL), file_name = "./modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv")
    manipulateConfig("scripts/run_submit/submit.sh","--job-name"=cfg$title,line_endings = "NOTwin")
    start_run(cfg,codeCheck=FALSE)
  }
}

cat("Finished!\n")
