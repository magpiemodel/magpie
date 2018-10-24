# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de

start_run <- function(cfg,scenario=NULL,codeCheck=TRUE,
                      report=NULL,sceninreport=NULL,LU_pricing="y2010", lock_model=TRUE) {

  if (!requireNamespace("lucode", quietly = TRUE)) {
    stop("Package \"lucode\" needed for this function to work. Please install it.",
         call. = FALSE)
  }

  if (!requireNamespace("magclass", quietly = TRUE)) {
    stop("Package \"magclass\" needed for this function to work. Please install it.",
         call. = FALSE)
  }


  Sys.setlocale(locale="C")
  maindir <- getwd()
  on.exit(setwd(maindir))

  if(lock_model) {
    lock_id <- lucode::model_lock(timeout1=1)
    on.exit(lucode::model_unlock(lock_id), add=TRUE)
  }

  if(!is.null(scenario)) cfg <- lucode::setScenario(cfg,scenario)
  cfg <- lucode::check_config(cfg)

  rundate <- Sys.time()
  date <- format(rundate, "_%Y-%m-%d_%H.%M.%S")
  cfg$results_folder <- gsub(":date:", date, cfg$results_folder, fixed=TRUE)
  cfg$results_folder <- gsub(":title:", cfg$title, cfg$results_folder, fixed=TRUE)

  # Create output folder
  if (!file.exists(cfg$results_folder)) {
    dir.create(cfg$results_folder, recursive=TRUE, showWarnings=FALSE)
	} else {
    stop(paste0("Results folder ",cfg$results_folder,
                " could not be created because is already exists."))
  }
  # If report and scenname are available the data of this scenario in the report
  # will be converted to MAgPIE input, saved to the respective input folders
  # and used as input by the model
  if (!is.null(report) && !is.null(sceninreport)) {
    getReportData(report, sceninreport, LU_pricing)
    cfg <- lucode::setScenario(cfg,"coupling")
  }

  # update all parameters which contain the levels and marginals
  # of all variables and equations
  lucode::update_fulldataOutput()
  # Update module paths in GAMS code
  lucode::update_modules_embedding()

  apply_cfg <- function(cfg) {
    if(is.null(cfg$model)) cfg$model <- "main.gms"
    # configure main model gms file (cfg$model) based on settings of cfg file
    lucode::manipulateConfig(cfg$model, cfg$gms)

    # configure input.gms in all modules based on settings of cfg file
    l1 <- lucode::path("modules", list.dirs("modules/", full.names = FALSE,
                                            recursive = FALSE))
    for(l in l1) {
      l2 <- lucode::path(l, list.dirs(l, full.names = FALSE, recursive = FALSE))
      for(ll in l2) {
        if(file.exists(lucode::path(ll, "input.gms"))) {
          lucode::manipulateConfig(lucode::path(ll, "input.gms"), cfg$gms)
        }
      }
    }
  }
  apply_cfg(cfg)

  #check all setglobal settings for consistency
  lucode::settingsCheck()

  ############# PROCESSING INPUT DATA ##########################################
  # Check whether input data has to be processed or is already processed

  # Function to extract information from info.txt
  get_info <- function(file, grep_expression, sep, pattern="", replacement="") {
    if(!file.exists(file)) return("#MISSING#")
    file <- readLines(file, warn=FALSE)
    tmp <- grep(grep_expression, file, value=TRUE)
    tmp <- strsplit(tmp, sep)
    tmp <- sapply(tmp, "[[", 2)
    tmp <- gsub(pattern, replacement ,tmp)
    if(all(!is.na(as.logical(tmp)))) return(as.vector(sapply(tmp, as.logical)))
    if (all(!(regexpr("[a-zA-Z]",tmp) > 0))) {
      tmp <- as.numeric(tmp)
    }
    return(tmp)
  }

  input_old <- get_info("input/info.txt", "^Used data set:", ": ")


  if(!setequal(cfg$input, input_old) | cfg$force_download) {
    source("scripts/downloader/download.R")
    archive_download(files=cfg$input,
                     repositories=cfg$repositories,
                     modelfolder=".",
                     debug=cfg$debug)
  }

  if(cfg$recalc_npi_ndc=="ifneeded") {
    aff_pol     <- magclass::read.magpie("modules/32_forestry/input/npi_ndc_aff_pol.cs3")
    ad_aolc_pol <- magclass::read.magpie("modules/35_natveg/input/npi_ndc_ad_aolc_pol.cs3")
    ad_pol     <- ad_aolc_pol[,,"forest"]
    aolc_pol    <- ad_aolc_pol[,,"other"]
    if((all(aff_pol == 0)   & (cfg$gms$c32_aff_policy != "none")) |
       (all(ad_pol == 0)    & (cfg$gms$c35_ad_policy != "none"))  |
       (all(aolc_pol == 0) & (cfg$gms$c35_aolc_policy != "none")))
    {
      cfg$recalc_npi_ndc <- TRUE
    } else cfg$recalc_npi_ndc <- FALSE
  }



  #### Collect technical information for validation ############################

  # get git info
  git_info <- c("### GIT revision ###",
                try(system("git rev-parse HEAD", intern=TRUE), silent=TRUE),
                "", "### Modifications ###",
                try(system("git status", intern=TRUE), silent=TRUE))
  if(codeCheck) {
    codeCheck <- lucode::codeCheck(core_files=c("core/*.gms",cfg$model),
                                   test_switches=(cfg$model=="main.gms"),
                                   strict=!cfg$developer_mode)
  } else codeCheck <- NULL

  # Create the workspace for validation
  tmp <- strsplit(cfg$results_folder,"/")[[1]]
  cfg$val_workspace <- paste(cfg$results_folder,"/",tmp[length(tmp)],
                             ".RData",sep="")
  validation <- list(technical=list(time=list(),
                      model_setup = git_info,
                      modules = codeCheck,
                      input_data = list(),
                      yield_calib = list(),
                      setup_info = list(start_functions = lucode::setup_info()),
                      last.warning = attr(codeCheck,"last.warning")))
  save(validation, file= cfg$val_workspace, compress="xz")

  lucode::runstatistics(file = paste0(cfg$results_folder,"/runstatistics.rda"),
                        user = Sys.info()[["user"]],
                        date = rundate,
                        version_management = "git",
                        revision = try(system("git rev-parse HEAD", intern=TRUE), silent=TRUE),
                        revision_date = try(as.POSIXct(system("git show -s --format=%ci", intern=TRUE), silent=TRUE)),
                        status = try(system("git status", intern=TRUE), silent=TRUE))


  ##############################################################################

  # NPI/NDC policyes calculations
  if(cfg$recalc_npi_ndc){
    cat("Starting NPI/NDC recalculation!\n")
    source("scripts/npi_ndc/start_npi_ndc.R")
    setwd("scripts/npi_ndc")
    calc_NPI_NDC(policyregions=cfg$policyregions)
    setwd("../..")
    cat("NPI/NDC recalculation successful!\n")
  }

  # Yield calibration
  calib_file <- "modules/14_yields/input/f14_yld_calib.csv"
  if(!file.exists(calib_file)) stop("Yield calibration file missing!")
  if(cfg$recalibrate=="ifneeded") {
    # recalibrate if all calibration factors are 1, otherwise don't
    cfg$recalibrate <- all(magclass::read.magpie(calib_file)==1)
  }
  if(cfg$recalibrate){
    cat("Starting calibration factor calculation!\n")
    source("scripts/calibration/calc_calib.R")
    calibrate_magpie(n_maxcalib = cfg$calib_maxiter,
                     calib_accuracy = cfg$calib_accuracy,
                     calibrate_pasture = (cfg$gms$past!="static"),
                     calibrate_cropland = (cfg$calib_cropland),
                     damping_factor = cfg$damping_factor,
                     calib_file = calib_file,
                     data_workspace = cfg$val_workspace,
                     logoption = 3,
                     debug = cfg$debug)
    file.copy("calibration_results.pdf", cfg$results_folder, overwrite=TRUE)
    cat("Calibration factor calculated!\n")
  }

  # copy important files into output_folder (before MAgPIE execution)
  for(file in cfg$files2export$start) {
    try(file.copy(Sys.glob(file), cfg$results_folder, overwrite=TRUE))
  }

  # copy spam files to output folder
  cfg$files2export$spam <- list.files(path="input/cellular", pattern = "*.spam",
                                      full.names=TRUE)
  for(file in cfg$files2export$spam) {
    file.copy(file, cfg$results_folder, overwrite=TRUE)
  }

  cfg$magpie_folder <- getwd()

  save(cfg, file=lucode::path(cfg$results_folder, "config.Rdata"))

  lucode::singleGAMSfile(mainfile=cfg$model, output=lucode::path(cfg$results_folder, "full.gms"))
  if(lock_model) {
    lucode::model_unlock(lock_id)
    on.exit(setwd(maindir))
  }

  setwd(cfg$results_folder)

  #Is SLURM available?
  slurm <- suppressWarnings(ifelse(system2("srun",stdout=FALSE,stderr=FALSE) != 127, TRUE, FALSE))

  if(is.na(cfg$sequential)) cfg$sequential <- !slurm

  if(slurm & !cfg$sequential) {
    system("sbatch submit.sh")
  } else {
    system("Rscript submit.R", wait=cfg$sequential)
  }

  return(cfg$results_folder)
}

getReportData <- function(rep,scen,LU_pricing="y2010") {

  if (!requireNamespace("magclass", quietly = TRUE)) {
    stop("Package \"magclass\" needed for this function to work. Please install it.",
         call. = FALSE)
  }

  .bioenergy_demand <- function(mag){
    notGLO <- getRegions(mag)[!(getRegions(mag)=="GLO")]
    out <- mag[,,"Primary Energy Production|Biomass|Energy Crops (EJ/yr)"]*10^3
    dimnames(out)[[3]] <- NULL
    write.magpie(out[notGLO,,],"./modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv")
  }
  .emission_prices <- function(mag){
    out_c <- mag[,,"Price|Carbon (US$2005/t CO2)"]*44/12 # US$2005/tCO2 -> US$2005/tC
    dimnames(out_c)[[3]] <- "co2_c"

    out_n2o_direct <- mag[,,"Price|N2O (US$2005/t N2O)"]*44/28 # US$2005/tN2O -> US$2005/tN
    dimnames(out_n2o_direct)[[3]] <- "n2o_n_direct"

    out_n2o_indirect <- mag[,,"Price|N2O (US$2005/t N2O)"]*44/28 # US$2005/tN2O -> US$2005/tN
    dimnames(out_n2o_indirect)[[3]] <- "n2o_n_indirect"

    out_ch4 <- mag[,,"Price|CH4 (US$2005/t CH4)"]
    dimnames(out_ch4)[[3]] <- "ch4"

    out <- mbind(out_n2o_direct,out_n2o_indirect,out_ch4,out_c)

    # Set prices to zero before and in the year given in LU_pricing
    y_zeroprices <- getYears(mag)<=LU_pricing
    out[,y_zeroprices,]<-0

    # Remove GLO region
    notGLO <- getRegions(mag)[!(getRegions(mag)=="GLO")]
    write.magpie(out[notGLO,,],"./modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3")
  }

  if (length(scen)!=1) stop("getReportData: 'scen' does not contain exactly one scenario.")
  if (length(intersect(scen,names(rep)))!=1) stop("getReportData: 'scen not contained in 'rep'.")

  files <- c("./modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3","./modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv")
  years <- 1990+5*(1:32)
  for(f in files) suppressWarnings(unlink(f))
  mag <- rep[[scen]][["MAgPIE"]]
  if(!("y1995" %in% getYears(mag))){
  	empty95<-mag[,1,];empty95[,,]<-0;dimnames(empty95)[[2]] <- "y1995"
  	mag <- mbind(empty95,mag)
  }
  mag <- time_interpolate(mag,years)
  .bioenergy_demand(mag)
  .emission_prices(mag)
}


start_reportrun <- function (cfg, path_report, inmodel=NULL, sceninreport=NULL, codeCheck=FALSE){
  if (!requireNamespace("magclass", quietly = TRUE)) {
    stop("Package \"magclass\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  if (!requireNamespace("lucode", quietly = TRUE)) {
    stop("Package \"lucode\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  rep <- magclass::convert.report(path_report,inmodel=inmodel,outmodel="MAgPIE")
  magclass::write.report(rep,"report.mif")
  if (!is.null(sceninreport))
      sceninreport <- intersect(sceninreport,names(rep))
  else
      sceninreport <- names(rep)

  for(scen in sceninreport) {
	cfg$title <- scen
  # extract scenario from scenarioname and apply it
	cfg       <- lucode::setScenario(cfg,substring(scen,first=1,last=4))
	start_run(cfg, report=rep, sceninreport=scen, codeCheck=codeCheck)
  }
}
