# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description:
# comparison script: FALSE
# ---------------------------------------------------------------


library(magclass)
library(lucode2)
library(lusweave)
library(magpie4)
library(luplot)
library(ggplot2)
library(remulator)
library(gms)

########################################################################################################
######################################## Define function ###############################################
########################################################################################################

collect_data_and_make_emulator <- function(outputdir,name_of_fit="linear") {
  require(gms)
  cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))

  #setwd("~/Documents/0_GIT/magpie")
  #cfg<-list(title="SSP2-26-1")

  # lock the model (other emulaotr scripts have to wait until this one finished)
  lock_id <- gms::model_lock(file=".lockemu")
  withr::defer(gms::model_unlock(lock_id,file=".lockemu"))

  results_path <- "output"

  emu_path <- file.path(results_path,"emulator")
  if(!dir.exists(emu_path)) dir.create(emu_path)

  #######################################################
  ############# C O L L E C T   D A T A #################
  #######################################################

  # extract scenario name by removing number at the end of run name: "CDL_base-base-9" -> "CDL_base-base"
  scenarios <- gsub("(.*)-[0-9]{1,2}$","\\1",cfg$title)
  # if user chose multiple runs from the same scenario remove duplicated scenarios
  scenarios <- unique(scenarios)

  # create empty object that will take all results
  x <- NULL

  # For all scenarios read data of all runs and compile into the single magpie object "x"
  for (scen in scenarios) {

    if(!dir.exists(file.path(emu_path,scen))) dir.create(file.path(emu_path,scen))

    outfile <- paste0(emu_path,"/",scen,"/data_raw_magpie_output_",scen,".Rdata")

    # If all 73 MAgPIE runs for this scenario are finished:
    # Read MAgPIE reports and modelstat for all runs of the list of scenarios,
    # combine into one object, and save to Rdata file
    raw_data_available <- FALSE

    cat("Checking if results have already been compiled and saved to",outfile,"\n")
    if(file.exists(outfile)) {
      # if results have already been collected and saved for this scenario load them
      cat("Results found. Loading them.\n")
      load(outfile) # expecting mag_res as the only object in this file
      raw_data_available <- TRUE
    } else {
      cat("No previously compiled results found.\nChecking if all runs for",scen,"have finished\n")
      # otherwise check if all runs are finished and if yes collect the results and save them to a Rdata file
      # list all subdirectories of results_path
      #single_scenario_paths <- base::list.dirs(results_path,recursive=FALSE,full.names=TRUE)

      # Find paths to all finished runs for this scenario. Use existence of fulldata.gdx as indicator.
      # Remove fulldata.gdx from paths
      # Pick only those that are like scenario followed by one ore two digits, i.e. "scenario_name-xx", with xx = 1...73
      single_scenario_paths <- Sys.glob(paste0(results_path,"/",scen,"-*/report.mif"))
      single_scenario_paths <- gsub("\\/report\\.mif","",single_scenario_paths)
      needle <- paste0(scen,"-([0-9]{1,2}$)")
      single_scenario_paths <- single_scenario_paths[grepl(needle,single_scenario_paths)]
      print(single_scenario_paths)
      if (emulator_runs_complete(single_scenario_paths,runnumbers = c(1:73))) { # c(6,7,59:60,64:73)
        cat("All 73 runs for",scen,"have finished.\n")
        mag_res <- read_and_combine(single_scenario_paths,outfile = outfile)
        raw_data_available <- TRUE
      } else {
        cat("NOT all 73 runs for",scen,"have finished yet. Nothing will be done.")
      }
    }

    # check if emulator has already been generated for this scenario
    fitted_data_available <- file.exists(paste0(emu_path,"/",scen,"/",name_of_fit,"/data_postfit_",scen,".Rdata"))
    if (fitted_data_available) {
      cat("Emulator has already been generated for",scen,"and will not be regenerated.\n")
    } else if (raw_data_available) {
      # compile data of mutiple scenarios in x
      x <- mbind(x,mag_res)
    }
  }

  # If for one of the scenarios raw data was available but no fit x is not NULL anymore and contains the
  # raw data of the missing scenario for which the fits will be generated below.
  if (!is.null(x)) {
    ################################################################
    ############# Prepare data for bioenergy emulator ##############
    ################################################################

    # Bring object to format that is required by emulator
    # add sample dimension by replacing -63 with .63
    getNames(x,dim=1) <- gsub("-([0-9]{1,2}$)",".\\1",getNames(x,dim=1))
    getSets(x) <- c("region","year","scenario","sample","model","variable")

    x <- x[,"y1995",,invert=TRUE]

    # Demand|Bioenergy|++|2nd generation (EJ/yr)
    # Prices|Bioenergy (US$05/GJ)

    # Clean data
    "Demand|Bioenergy|2nd generation|++|Bioenergy crops (EJ/yr)"
    "Prices|Bioenergy (US$05/GJ)"
    # 1. Exclude points with zero production (there are cases where production is zero but there is a price)
    x[,,"Demand|Bioenergy|2nd generation|++|Bioenergy crops (EJ/yr)"][x[,,"Demand|Bioenergy|2nd generation|++|Bioenergy crops (EJ/yr)"]==0] <- NA
    x[,,"Prices|Bioenergy (US$05/GJ)"][is.na(x[,,"Demand|Bioenergy|2nd generation|++|Bioenergy crops (EJ/yr)"])] <- NA

    # 2. Normally, where production (x) is zero resulting prices (y) are NA -> set production to NA where prices are NA
    x[,,"Demand|Bioenergy|2nd generation|++|Bioenergy crops (EJ/yr)"][is.na(x[,,"Prices|Bioenergy (US$05/GJ)"])] <- NA

    x[,,"Modelstatus (-)"] <- x["GLO",,"Modelstatus (-)"]

    # Convert units to REMIND units
    TWa_2_EJ <- 365.25*24*3600/1E6
    tmp1 <- x[,,"Demand|Bioenergy|2nd generation|++|Bioenergy crops (EJ/yr)"] / TWa_2_EJ      # EJ   -> TWa
    tmp2 <- x[,,"Prices|Bioenergy (US$05/GJ)"]                * TWa_2_EJ/1000 # $/GJ -> T$/TWa
    getNames(tmp1,dim=4) <- gsub("EJ/yr","TWa/yr",   getNames(tmp1,dim=4),fixed=TRUE)
    getNames(tmp2,dim=4) <- gsub("US$05/GJ","T$/TWa",getNames(tmp2,dim=4),fixed=TRUE)
    x <- mbind(x,tmp1,tmp2)
    
    # transfer regionscode from mag_res to x since it was erased above everywhere where x was 'mbind'ed
    regionscode <- attributes(mag_res)$regionscode
    attributes(x)$regionscode <- regionscode

    ###############################################################
    ############# C A L C U L A T E   E M U L A T O R #############
    ###############################################################

    # Calculate emulator
    fc <- emulator(data=x,
             name_x="Demand|Bioenergy|2nd generation|++|Bioenergy crops (TWa/yr)",
             name_y="Prices|Bioenergy (T$/TWa)",
             name_modelstat="Modelstatus (-)",
             userfun=function(param,x)return(param[[1]] + param[[2]] * x),
             treat_as_feasible = c(2,7),
             n_suff = 5,
             fill = TRUE,
             output_path = emu_path,
             fitname = name_of_fit,
             create_pdf=TRUE,
             initial_values = c(0,0),
             lower=c(0,0))
    print(fc)
    print(attributes(fc))

    # write fit coefficients to REMIND input file
    for (scen in getNames(fc,dim="scenario")) {
      write.magpie(fc,file_name = paste0("f30_bioen_price_",scen,"_",regionscode,".cs4r"), file_folder = file.path(emu_path,scen,name_of_fit))
    }
  }
}


########################################################################################################
######################################## Execute function ##############################################
########################################################################################################
 if(!exists("source_include")) {
   outputdir <- NULL
   lucode2::readArgs("outputdir")
 }

collect_data_and_make_emulator(outputdir,name_of_fit="linear")
