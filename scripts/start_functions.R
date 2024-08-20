# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

################################################################################
# Define internal functions
################################################################################

.calcClusterCells <- function(x) {
  cells <- noCells <- NULL
  for (i in magclass::getItems(x, dim = 1.1)) {
    max   <- max(as.numeric(magclass::getItems(x[i, , ], dim = 1.2)))
    min   <- min(as.numeric(magclass::getItems(x[i, , ], dim = 1.2)))
    count <- length(magclass::getItems(x[i, , ], dim = 1.2))

    tmp     <- paste0(paste(i, min, sep = "_"), "*" , paste(i, max, sep = "_"))
    cells   <- c(cells, tmp)
    noCells <- c(noCells, count)
  }
  out <- data.frame(i = magclass::getItems(x, dim = 1.1),
                    j = cells,
                    n = noCells)
  return(out)
}

.update_sets_core <- function(x, map) {
  require(gms)

  if (!("region" %in% names(map)))      map$region <- map$RegionCode
  if (!("country" %in% names(map)))     map$country <- map$CountryCode
  if (!("superregion" %in% names(map))) map$superregion <- map$region

  reg1 <- unique(as.character(map$region))
  reg2 <- magclass::getItems(x, dim = 1.1)
  if (!all(union(reg1,reg2) %in% intersect(reg1, reg2))) {
    stop("Inconsistent region information!",
         "\n cpr info: ", paste(reg2, collapse = ", "),
         "\n spatial header info: ", paste(reg1, collapse = ", "))
  }

  ij <- .calcClusterCells(x = x)[c("i", "j")]

  hi <- unique(map[c("superregion", "region")])
  hi <- hi[order(hi$superregion),]

  sets <- list(list(name = "h",
                    desc = "all superregional economic regions",
                    items = sort(unique(as.character(map$superregion)))),
               list(name = "i",
                    desc = "all economic regions",
                    items = ij[["i"]]),
               list(name = "supreg(h,i)",
                    desc = "mapping of superregions to its regions",
                    items = hi),
               list(name = "iso",
                    desc = "list of iso countries",
                    items = as.character(map$country)),
               list(name = "j",
                    desc = "number of LPJ cells",
                    items = ij[["j"]]),
               list(name = "cell(i,j)",
                    desc = "number of LPJ cells per region i",
                    items = ij),
               list(name = "i_to_iso(i,iso)",
                    desc = "mapping regions to iso countries",
                    items = map[c("region","country")][order(map$region),]))

  gms::writeSets(sets, "core/sets.gms")
}

.update_sets_modules <- function() {
  require(gms)

  ### 56_ghg_policy
  ghgscen56 <- magclass::read.magpie("modules/56_ghg_policy/input/f56_pollutant_prices.cs3")
  ghgscen56 <- magclass::getNames(ghgscen56,dim=2)

  scen56 <- magclass::read.magpie("modules/56_ghg_policy/input/f56_emis_policy.csv",file_type = "cs3")
  scen56 <- magclass::getNames(scen56,dim=1)

  sets <- list(list(name = "ghgscen56",
                    desc = "ghg price scenarios",
                    items = ghgscen56),
               list(name = "scen56",
                   desc = "emission policy scenarios",
                   items = scen56))

  gms::writeSets(sets, "modules/56_ghg_policy/price_aug22/sets.gms")

  ### 60_bioenergy
  scen2nd60 <- magclass::read.magpie("modules/60_bioenergy/input/f60_bioenergy_dem.cs3")
  scen2nd60 <- magclass::getNames(scen2nd60,dim=1)

  sets <- list(list(name = "scen2nd60",
                    desc = "second generation bioenergy scenarios",
                    items = scen2nd60))

  gms::writeSets(sets , "modules/60_bioenergy/1stgen_priced_dec18/sets.gms")
  gms::writeSets(sets , "modules/60_bioenergy/1st2ndgen_priced_feb24/sets.gms")
}

# Function to extract information from info.txt
.get_info <- function(file, grep_expression, sep, pattern = "", replacement = "") {
  if(!file.exists(file)) return("#MISSING#")
  file <- readLines(file, warn=FALSE)
  tmp <- grep(grep_expression, file, value=TRUE)
  tmp <- strsplit(tmp, sep)
  tmp <- sapply(tmp, "[[", 2)
  tmp <- gsub(pattern, replacement, tmp)
  if(all(!is.na(as.logical(tmp)))) return(as.vector(sapply(tmp, as.logical)))
  if (all(!(regexpr("[a-zA-Z]", tmp) > 0))) {
    tmp <- as.numeric(tmp)
  }
  return(tmp)
}

# Define routine to update info file in input folder and info in main.gms
.update_info <- function(datasets, x, regionscode, reg_revision, warnings = NULL) {

  # extract cluster information from file:
  ijn <- .calcClusterCells(x = x)

  low_res  <- .get_info("input/info.txt", "^\\* Output ?resolution:", ": ")
  high_res <- .get_info("input/info.txt", "^\\* Input ?resolution:", ": ")

  info    <- readLines('input/info.txt')
  subject <- 'VERSION INFO'

  useddata <- NULL
  for(dataset in rownames(datasets)) {
    useddata <- c(useddata,
                  '',
                  paste('Used data set:', dataset),
                  paste('md5sum:', datasets[dataset, "md5"]),
                  paste('Repository:', datasets[dataset, "repo"]))
  }

  warnings <- attr(datasets,"warnings")
  if(!is.null(warnings)) {
    warnings <- capture.output(warnings)
  }

  content <- c(useddata,
               '',
               paste('Low resolution:', low_res),
               paste('High resolution:', high_res),
               '',
               paste('Total number of cells:', sum(ijn["n"])),
               '',
               'Number of cells per region:',
               paste(format(ijn[["i"]], width = 5, justify = "right"), collapse = ""),
               paste(format(ijn[["n"]], width = 5), collapse = ""),
               '',
               paste('Regionscode:', regionscode),
               '',
               paste('Regions data revision:', reg_revision),
               '',
               info,
               '',
               warnings,
               '',
               paste('Last modification (input data):',date()),
               '')
  writeLines(content,'input/info.txt')
  gms::replace_in_file("main.gms",paste('*',content),subject)
}

################################################################################
######################### MAIN FUNCTIONS #######################################
################################################################################

download_and_update <- function(cfg) {
  # Download data and update code

  # Delete previously downloaded files, download new files and distribute
  # them within the model.
  filemap <- gms::download_distribute(files        = cfg$input,
                                      repositories = cfg$repositories, # defined in your local .Rprofile or on the cluster /p/projects/rd3mod/R/.Rprofile
                                      modelfolder  = ".",
                                      additionalDelete="scripts/downloader/inputdelete.cfg",
                                      debug        = cfg$debug)

  # In the following the GAMS sourcecode files magpie.gms and core/sets.gms
  # are manipulated. Therefore some information about the number of cells per
  # region is required (CPR). This information is gained by extracting it from
  # the avl_land.cs3 input file (any other cellular file could be used as well).
  # This information is then transfered to .update_info, which is
  # updating the general information in magpie.gms and input/info.txt
  # and .update_sets, which is updating the resolution- and region-depending
  # sets in core/sets.gms
  tmp  <- magclass::read.magpie("modules/10_land/input/avl_land_t.cs3")
  tmp2 <- magclass::read.magpie("modules/10_land/input/avl_land_t_0.5.mz")
  cel  <- magclass::getItems(tmp2, dim = 1)
  # read spatial_header, map, reg_revision and regionscode
  load("input/spatial_header.rda")
  .update_info(filemap, x = tmp, regionscode, reg_revision, warnings)
  .update_sets_core(x = tmp, map = map)
  .update_sets_modules()
}


start_run <- function(cfg, scenario = NULL, codeCheck = TRUE, lock_model = TRUE) {

  timePrepareStart <- Sys.time()

  checkNamespace <- function(...) {
    for(package in c(...)) {
      if (!requireNamespace(package, quietly = TRUE)) {
        stop("Package \"",package,"\" needed for this function to work. Please install it.",
             call. = FALSE)
      }
    }
  }

  checkNamespace("gms", "lucode2", "magclass")

  Sys.setlocale(locale = "C")
  maindir <- getwd()
  withr::defer(setwd(maindir))

  if(lock_model) {
    lock_id <- gms::model_lock(timeout1 = 1)
    withr::defer(gms::model_unlock(lock_id))
  }

  # Apply scenario settings ans check configuration file for consistency
  if(!is.null(scenario)) cfg <- gms::setScenario(cfg,scenario)
  cfg <- gms::check_config(cfg, extras = c("info", "repositories", "gms$c_input_gdx_path"), saveCheck = TRUE)

  # save model version
  cfg$info$version <- citation::read_cff("CITATION.cff")$version

  # Make 'title' a setglobal in gams to include it in the gdx
  cfg$gms$c_title <- sub(".", "p", cfg$title, fixed = TRUE)

  rundate <- Sys.time()
  date <- format(rundate, "_%Y-%m-%d_%H.%M.%S")
  cfg$results_folder <- gsub(":date:", date, cfg$results_folder, fixed=TRUE)
  cfg$results_folder <- gsub(":title:", cfg$title, cfg$results_folder, fixed=TRUE)

  # Create output folder
  if (file.exists(cfg$results_folder)) {
    if (cfg$force_replace) {
      message("Deleting results folder because it already exists:", cfg$results_folder)
      unlink(cfg$results_folder, recursive = TRUE)
    } else {
      stop(paste0("Results folder ", cfg$results_folder,
                  " could not be created because it already exists."))
    }
  }
  dir.create(cfg$results_folder, recursive = TRUE)

  if (is.null(renv::project())) {
    message("No active renv project found, not using renv.")
  } else {
    if (!is.null(cfg$renv_lock)) {
      message("Copying cfg$renv_lock (= '", normalizePath(cfg$renv_lock, mustWork = TRUE), "') into '",
              cfg$results_folder, "'")
      file.copy(cfg$renv_lock, file.path(cfg$results_folder, "_renv.lock"))
    } else if (normalizePath(renv::project()) == normalizePath(".")) {
      # the main renv is loaded
      message("Generating lockfile in '", cfg$results_folder, "'... ", appendLF = FALSE)
      # suppress output of renv::snapshot
      errorMessage1 <- utils::capture.output({
        errorMessage2 <- utils::capture.output({
          snapshotSuccess <- tryCatch({
            # snapshot current main renv into run folder
            renv::snapshot(lockfile = file.path(cfg$results_folder, "_renv.lock"), prompt = FALSE)
            TRUE
          }, error = function(error) FALSE)
        }, type = "message")
      })
      if (!snapshotSuccess) {
        stop(paste(errorMessage1, collapse = "\n"), paste(errorMessage2, collapse = "\n"))
      }
      message("done.")
    } else {
      # a run renv is loaded
      message("Copying lockfile into '", cfg$results_folder, "'")
      file.copy(renv::paths$lockfile(), file.path(cfg$results_folder, "_renv.lock"))
    }

    createResultsfolderRenv <- function() {
      renv::init() # will overwrite renv.lock if existing...
      file.rename("_renv.lock", "renv.lock") # so we need this rename
      renv::restore(prompt = FALSE)
      message("renv creation done.")
    }

    renvLogPath <- file.path(cfg$results_folder, "log_renv.txt")
    message("Initializing run renv, see '", renvLogPath, "'...", appendLF = FALSE)
    # init renv in a separate session so the libPaths of the current session remain unchanged
    callr::r(createResultsfolderRenv,
             wd = cfg$results_folder,
             env = c(RENV_PATHS_LIBRARY = "renv/library"),
             stdout = renvLogPath, stderr = "2>&1")
    message("done.")
  }

  # If available (i.e. paths are set) extract bioenergy and/or GHG prices 
  # from REMIND report and save them to the respective input folders
  # Please note: For them to be used by the model, either the 'coupling' scenario
  # must be selected or the corresponding switches must be set individually.
  getReportData(cfg$path_to_report_bioenergy, cfg$path_to_report_ghgprices)

  # update all parameters which contain the levels and marginals
  # of all variables and equations
  gms::update_fulldataOutput()
  # Update module paths in GAMS code
  gms::update_modules_embedding()

  apply_cfg <- function(cfg) {
    if(is.null(cfg$model)) cfg$model <- "main.gms"
    # configure main model gms file (cfg$model) based on settings of cfg file
    lucode2::manipulateConfig(cfg$model, cfg$gms)

    # configure input.gms in all modules based on settings of cfg file
    l1 <- file.path("modules", list.dirs("modules/", full.names = FALSE,
                                            recursive = FALSE))
    for(l in l1) {
      l2 <- file.path(l, list.dirs(l, full.names = FALSE, recursive = FALSE))
      for(ll in l2) {
        if(file.exists(file.path(ll, "input.gms"))) {
          lucode2::manipulateConfig(file.path(ll, "input.gms"), cfg$gms)
        }
      }
    }
  }
  apply_cfg(cfg)

  #check all setglobal settings for consistency
  gms::settingsCheck()

  ################################################################################
  ############# PROCESSING INPUT DATA ###################### START ###############
  ################################################################################

  ################################################################################
  ########## DOWNLOAD INPUT FILES and MANIPULATE GAMS FILES ######################
  ################################################################################

  input_old <- .get_info("input/info.txt", "^Used data set:", ": ")

  if(!setequal(cfg$input, input_old) | cfg$force_download) {
    # download data and update code
    download_and_update(cfg)
  }

  ###########################################################################################################
  ############# PROCESSING INPUT DATA ###################### END ############################################
  ###########################################################################################################

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
    codeCheck <- gms::codeCheck(core_files=c("core/*.gms",cfg$model),
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
                      setup_info = list(start_functions = lucode2::setup_info()),
                      last.warning = attr(codeCheck,"last.warning")))
  save(validation, file= cfg$val_workspace, compress="xz")

  lucode2::runstatistics(file = paste0(cfg$results_folder,"/runstatistics.rda"),
                         user = Sys.info()[["user"]],
                         date = rundate,
                         version_management = "git",
                         revision = try(system("git rev-parse HEAD", intern = TRUE), silent=TRUE),
                         revision_date = try(as.POSIXct(system("git show -s --format=%ci", intern = TRUE), silent = TRUE)),
                         status = try(system("git status", intern = TRUE), silent = TRUE))


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

  # check for inconsistent settings
  if((cfg$recalibrate == TRUE || cfg$recalibrate == "ifneeded")
      && cfg$gms$s14_use_yield_calib == 0) {
    stop("The combination of the switch configurations `cfg$recalibrate <- TRUE/ifneeded`
          and `cfg$gms$s14_use_yield_calib <- 0` is inconsistent.
          Please check the config and set `cfg$gms$s14_use_yield_calib <- 1` 
          if yield calibration is desired, or `cfg$recalibrate <- FALSE` if not.
          Note that the current default is to not use yield calibration.")
  }

  # decide if calibration is needed if "ifneeded" is specified
  calib_file <- "modules/14_yields/input/f14_yld_calib.csv"
  if(cfg$recalibrate=="ifneeded") {
    if(!file.exists(calib_file)) {
      # recalibrate if file does not exist
      cfg$recalibrate <- TRUE
    } else {
      # recalibrate if all calibration factors are 1, otherwise don't
      cfg$recalibrate <- all(magclass::read.magpie(calib_file)==1)
    }
  }

  if(cfg$recalibrate){
    cat("Starting yield calibration factor calculation!\n")
    source("scripts/calibration/calc_calib.R")
    calibrate_magpie(n_maxcalib = cfg$calib_maxiter,
                     calib_accuracy = cfg$calib_accuracy,
                     calibrate_pasture = (cfg$gms$past!="static" & cfg$gms$past!="grasslands_apr22"),
                     calibrate_cropland = (cfg$calib_cropland),
                     damping_factor = cfg$damping_factor,
                     crop_max = cfg$crop_calib_max,
                     calib_file = calib_file,
                     data_workspace = cfg$val_workspace,
                     logoption = 3,
                     debug = cfg$debug,
                     best_calib = cfg$best_calib)
    file.copy("calibration_results.pdf", cfg$results_folder, overwrite=TRUE)
    cat("Yield calibration factor calculated!\n")
  }

  land_calib_file <- "modules/39_landconversion/input/f39_calib.csv"
  if(cfg$recalibrate_landconversion_cost=="ifneeded") {
    # recalibrate if file does not exist
    if(!file.exists(land_calib_file)) cfg$recalibrate_landconversion_cost <- TRUE else cfg$recalibrate_landconversion_cost <- FALSE
  }
  if(cfg$recalibrate_landconversion_cost){
    #if(cfg$gms$landconversion!="devstate") stop("Land conversion cost calibration works only with realization devstate")
    cat("Starting land conversion cost calibration factor calculation!\n")
    source("scripts/calibration/landconversion_cost.R")
    calibrate_magpie(n_maxcalib = cfg$calib_maxiter_landconversion_cost,
                     restart = cfg$restart_landconversion_cost,
                     calib_accuracy = cfg$calib_accuracy_landconversion_cost,
                     lowpass_filter = cfg$lowpass_filter_landconversion_cost,
                     cost_max = cfg$cost_calib_max_landconversion_cost,
                     cost_min = cfg$cost_calib_min_landconversion_cost,
                     calib_file = land_calib_file,
                     data_workspace = cfg$val_workspace,
                     logoption = 3,
                     debug = cfg$debug,
                     best_calib = cfg$best_calib_landconversion_cost)
    cat("Land conversion cost calibration factor calculated!\n")
  }

  # copy important files into output_folder (before MAgPIE execution)
  for(file in cfg$files2export$start) {
    try(file.copy(Sys.glob(file), cfg$results_folder, overwrite = TRUE))
  }

  cfg$magpie_folder <- getwd()
  # only store repository paths, not their credentials
  cfg$repositories <- sapply(names(cfg$repositories), function(x) NULL)
  # store config in human and machine readable form
  gms::saveConfig(cfg, file.path(cfg$results_folder, "config.yml"))

  gms::singleGAMSfile(mainfile=cfg$model, output=file.path(cfg$results_folder, "full.gms"))
  if(lock_model) {
    gms::model_unlock(lock_id)
    withr::defer(setwd(maindir))
  }

  setwd(cfg$results_folder)

  # Save run statistics to local file
  cat("Saving timePrepareStart and timePrepareEnd to runstatistics.rda\n")
  timePrepareEnd <- Sys.time()
  lucode2::runstatistics(file             = "runstatistics.rda",
                         timePrepareStart = timePrepareStart,
                         timePrepareEnd   = timePrepareEnd)

  #Is SLURM available?
  slurm <- lucode2::SystemCommandAvailable("srun")

  if(is.na(cfg$sequential)) cfg$sequential <- !slurm

  if(slurm && !cfg$sequential) {
    if(is.null(cfg$qos)) {
      # try to select best QOS based on available resources
      # and available information
      load <- lucode2::getClusterLoad()
      if(is.null(load)) {
        cfg$qos <- "standby"
      } else if(all(load > 80)) {
        cfg$qos <- "priority"
      } else if(all(c("priority", "standard") %in% names(load)) && load["priority"] < load["standard"]) {
        cfg$qos <- "standby"
      } else {
        cfg$qos <- "short"
      }
    }
    submitfile <- paste0("submit_",cfg$qos,".sh")
    if(!file.exists(submitfile)) stop("Submit script ",submitfile," not found!")
    system(paste("sbatch",submitfile))
    cat("Run submitted with ",submitfile,"!\n",sep="")
  } else {
    system("Rscript submit.R", wait=cfg$sequential)
  }

  return(cfg$results_folder)
}

getReportData <- function(path_to_report_bioenergy, path_to_report_ghgprices = NA) {

  if (!requireNamespace("magclass", quietly = TRUE)) {
    stop("Package \"magclass\" needed for this function to work. Please install it.",
         call. = FALSE)
  }

  .bioenergyDemand <- function(mag){
    notGLO <- getRegions(mag)[!(getRegions(mag)=="GLO")]
    out <- mag[,,"Primary Energy Production|Biomass|Energy Crops (EJ/yr)"]*10^3
    dimnames(out)[[3]] <- NULL
    # delete old input file before updating it
    f <- "./modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv"
    suppressWarnings(unlink(f))
    write.magpie(out[notGLO,,],f)
  }

  .emissionPrices <- function(mag){
    out_c <- mag[,,"Price|Carbon (US$2005/t CO2)"]*44/12 # US$2005/tCO2 -> US$2005/tC
    dimnames(out_c)[[3]] <- "co2_c"

    out_n2o_direct <- mag[,,"Price|N2O (US$2005/t N2O)"]*44/28 # US$2005/tN2O -> US$2005/tN
    dimnames(out_n2o_direct)[[3]] <- "n2o_n_direct"

    out_n2o_indirect <- mag[,,"Price|N2O (US$2005/t N2O)"]*44/28 # US$2005/tN2O -> US$2005/tN
    dimnames(out_n2o_indirect)[[3]] <- "n2o_n_indirect"

    out_ch4 <- mag[,,"Price|CH4 (US$2005/t CH4)"]
    dimnames(out_ch4)[[3]] <- "ch4"

    out <- mbind(out_n2o_direct,out_n2o_indirect,out_ch4,out_c)

    # Remove GLO region
    notGLO <- getRegions(mag)[!(getRegions(mag)=="GLO")]
    # delete old input file before updating it
    f <- "./modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3"
    suppressWarnings(unlink(f))
    write.magpie(out[notGLO,,],f)
  }

  .readAndPrepare <- function(mifPath) {
    require(magclass)
    rep <- read.report(mifPath, as.list = FALSE)
    if (length(getNames(rep, dim = "scenario")) != 1) stop("getReportData: report contains more or less than 1 scenario.")
    mag <- collapseNames(rep) # get rid of scenario and model dimension if they exist

    if(!("y1995" %in% getYears(mag))){
      empty95 <- mag[, 1,]
      empty95[,,] <- 0
      dimnames(empty95)[[2]] <- "y1995"
      mag <- mbind(empty95, mag)
    }
    years <- 1990 + 5 * seq_len(32)
    mag <- time_interpolate(mag, years)
    return(mag)
  }

  # if paths are provided, read bioenergy demand and ghg prices from REMIND reports 
  if (!is.na(path_to_report_bioenergy)) {
    message("Reading bioenergy_demand from ", path_to_report_bioenergy)
    mag <- .readAndPrepare(path_to_report_bioenergy)
    .bioenergyDemand(mag)
  
    if (path_to_report_ghgprices %in% path_to_report_bioenergy) {
      message("Reading ghg prices from the same file (", path_to_report_bioenergy, ")")
      .emissionPrices(mag)
    }
  }
  
  # read ghg prices from another REMIND report because path_to_report_bioenergy
  # is different from path_to_report_ghgprices (including NA)
  if (!is.na(path_to_report_ghgprices) && ! path_to_report_ghgprices %in% path_to_report_bioenergy) {
    message("Reading ghg prices from ", path_to_report_ghgprices)
    ghgmag <- .readAndPrepare(path_to_report_ghgprices)
    .emissionPrices(ghgmag)
  }
}

# Will not actually solve the model: after compilation, this just copies the results
# of a previous run, useful for testing compilation and input/output handling.
# Used in scripts/start/extra/empty_model.R and tests for REMIND-MAgPIE coupling.
configureEmptyModel <- function(cfg, inputGdxPath) {
    message("Configuring to use empty MAgPIE model, reproduces prior run ", inputGdxPath)
    originalModel <- withr::local_connection(file(cfg$model, "r"))
    emptyModelFile <- "standalone/empty_test_model.gms"
    emptyModel <- withr::local_connection(file(emptyModelFile, "w"))
    while (TRUE) {
      originalLine <- readLines(originalModel, n = 1)
      if (length(originalLine) == 0) {
        break
      }
      writeLines(originalLine, emptyModel)
      if (grepl("*END MODULE SETUP*", originalLine)) {
        # add code for short-circuiting the model
        writeLines(c(
          "***********************TEST USING EMPTY MODEL***********************************",
          "*** empty model just uses input gdx as the result",
          "*** rest of the model is compiled, but not executed",
          "$setglobal c_input_gdx_path  path",
          "execute \"cp %c_input_gdx_path% fulldata.gdx\";",
          "abort.noerror \"cp %c_input_gdx_path% fulldata.gdx\";",
          "********************************************************************************"),
          emptyModel)
      }
    }
    cfg$model <- emptyModelFile
    cfg$gms$c_input_gdx_path <- inputGdxPath
    return(cfg)
}
