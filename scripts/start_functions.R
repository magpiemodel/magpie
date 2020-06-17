# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

################################################################################
# Define internal functions
################################################################################
.update_sets <- function(cpr,map) {
  require(gms)

  reg1 <- unique(map$RegionCode)
  reg2 <- names(cpr)
  if(!all(union(reg1,reg2) %in% intersect(reg1,reg2))) {
    stop("Inconsistent region information!",
         "\n cpr info: ",paste(reg2,collapse=", "),
         "\n spatial header info: ", paste(reg1,collapse=", "))
  }


  j <- 0; cells <- NULL
  for(i in 1:length(cpr)) {
    cells <- c(cells,paste(names(cpr)[i],"_",j+1,"*",names(cpr)[i],"_",j+cpr[i],sep=""))
    j <- j+cpr[i]
  }

  .tmp <- function(x,prefix="", suffix1="", suffix2=" /", collapse=",", n=10) {
    content <- NULL
    tmp <- lapply(split(x, ceiling(seq_along(x)/n)),paste,collapse=collapse)
    end <- suffix1
    for(i in 1:length(tmp)) {
      if(i==length(tmp)) end <- suffix2
      content <- c(content,paste0('       ',prefix,tmp[[i]],end))
    }
    return(content)
  }

  subject <- 'SETS'
  modification_warning <- c(
    '*THIS CODE IS CREATED AUTOMATICALLY, DO NOT MODIFY THESE LINES DIRECTLY',
    '*ANY DIRECT MODIFICATION WILL BE LOST AFTER NEXT INPUT DOWNLOAD',
    '*CHANGES CAN BE DONE USING THE INPUT DOWNLOADER UNDER SCRIPTS/DOWNLOAD',
    '*THERE YOU CAN ALSO FIND ADDITIONAL INFORMATION')
  content <- c(modification_warning,'','sets','')

  content <- c(content,paste('   i all economic regions /',paste(names(cpr),collapse=','),'/',sep=''),'')

  # write iso set with nice formatting (10 countries per line)
  tmp <- lapply(split(map$CountryCode, ceiling(seq_along(map$CountryCode)/10)),paste,collapse=",")
  content <- c(content,'   iso list of iso countries /')
  content <- c(content, .tmp(map$CountryCode, suffix1=",", suffix2=" /"))

  content <- c(content,  '', paste('   j number of LPJ cells /\n       ',paste(cells,collapse=',\n       '),'/',sep=''),'',
               '   cell(i,j) number of LPJ cells per region i','      /')
  for(i in 1:length(cpr)) {
    content <- c(content,paste('       ',names(cpr)[i],' . ',cells[i],sep=''))
  }
  content <- c(content,'      /','')

  content <- c(content,'   i_to_iso(i,iso) mapping regions to iso countries','      /')
  map$RegionCode <- as.factor(map$RegionCode)
  for(i in levels(map$RegionCode)) {
    content <- c(content, .tmp(map$CountryCode[map$RegionCode==i], prefix=paste0(i," . ("), suffix1=")", suffix2=")"))

  }
  content <- c(content,'      /',';')
  gms::replace_in_file("core/sets.gms",content,subject)
}

# Function to extract information from info.txt
.get_info <- function(file, grep_expression, sep, pattern="", replacement="") {
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

#Define routine to update info file in input folder and info in main.gms
.update_info <- function(datasets, cpr, regionscode, reg_revision, warnings=NULL) {

  low_res  <- .get_info("input/info.txt","^\\* Output ?resolution:",": ")
  high_res <- .get_info("input/info.txt","^\\* Input ?resolution:",": ")

  info <- readLines('input/info.txt')
  subject <- 'VERSION INFO'

  useddata <- NULL
  for(dataset in rownames(datasets)) {
    useddata <- c(useddata,
                  '',
                  paste('Used data set:',dataset),
                  paste('md5sum:',datasets[dataset,"md5"]),
                  paste('Repository:',datasets[dataset,"repo"]))
  }

  warnings <- attr(datasets,"warnings")
  if(!is.null(warnings)) {
    warnings <- capture.output(warnings)
  }

  content <- c(useddata,
               '',
               paste('Low resolution:',low_res),
               paste('High resolution:',high_res),
               '',
               paste('Total number of cells:',sum(cpr)),
               '',
               'Number of cells per region:',
               paste(format(names(cpr),width=5,justify="right"),collapse=""),
               paste(format(cpr,width=5),collapse=""),
               '',
               paste('Regionscode:',regionscode),
               '',
               paste('Regions data revision:',reg_revision),
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
  tmp <- magclass::read.magpie("modules/10_land/input/avl_land_t.cs3")
  cpr <- magclass::getCPR(tmp)
  # read spatial_header, map, reg_revision and regionscode
  load("input/spatial_header.rda")
  .update_info(filemap,cpr,regionscode,reg_revision, warnings)
  .update_sets(cpr,map)
}


start_run <- function(cfg,scenario=NULL,codeCheck=TRUE,
                      path_to_report=NULL,LU_pricing="y2010", lock_model=TRUE) {

  timePrepareStart <- Sys.time()

  if (!requireNamespace("gms", quietly = TRUE)) {
    stop("Package \"gms\" needed for this function to work. Please install it.",
         call. = FALSE)
  }

  if (!requireNamespace("lucode2", quietly = TRUE)) {
    stop("Package \"lucode2\" needed for this function to work. Please install it.",
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
    lock_id <- gms::model_lock(timeout1=1)
    on.exit(gms::model_unlock(lock_id), add=TRUE)
  }

  if(!is.null(scenario)) cfg <- gms::setScenario(cfg,scenario)
  cfg <- gms::check_config(cfg)

  # Make 'title' a setglobal in gams to include it in the gdx
  cfg$gms$c_title <- cfg$title

  rundate <- Sys.time()
  date <- format(rundate, "_%Y-%m-%d_%H.%M.%S")
  cfg$results_folder <- gsub(":date:", date, cfg$results_folder, fixed=TRUE)
  cfg$results_folder <- gsub(":title:", cfg$title, cfg$results_folder, fixed=TRUE)

  # Create output folder
  if (!file.exists(cfg$results_folder)) {
    dir.create(cfg$results_folder, recursive=TRUE, showWarnings=FALSE)
	} else if (cfg$force_replace) {
    cat("Deleting results folder because it alreay exists:",cfg$results_folder,"\n")
    unlink(cfg$results_folder, recursive = TRUE)
    dir.create(cfg$results_folder, recursive = TRUE, showWarnings = FALSE)
  } else {
    stop(paste0("Results folder ",cfg$results_folder,
                " could not be created because is already exists."))
  }
  # If report and scenname are available the data of this scenario in the report
  # will be converted to MAgPIE input, saved to the respective input folders
  # and used as input by the model
  if (!is.null(path_to_report)) {
    getReportData(path_to_report, LU_pricing)
    cfg <- gms::setScenario(cfg,"coupling")
  }

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
    l1 <- lucode2::path("modules", list.dirs("modules/", full.names = FALSE,
                                            recursive = FALSE))
    for(l in l1) {
      l2 <- lucode2::path(l, list.dirs(l, full.names = FALSE, recursive = FALSE))
      for(ll in l2) {
        if(file.exists(lucode2::path(ll, "input.gms"))) {
          lucode2::manipulateConfig(lucode2::path(ll, "input.gms"), cfg$gms)
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

  save(cfg, file=lucode2::path(cfg$results_folder, "config.Rdata"))

  gms::singleGAMSfile(mainfile=cfg$model, output=lucode2::path(cfg$results_folder, "full.gms"))
  if(lock_model) {
    gms::model_unlock(lock_id)
    on.exit(setwd(maindir))
  }

  setwd(cfg$results_folder)

  # Save run statistics to local file
  cat("Saving timePrepareStart and timePrepareEnd to runstatistics.rda\n")
  timePrepareEnd <- Sys.time()
  lucode2::runstatistics(file             = paste0("runstatistics.rda"),
                         timePrepareStart = timePrepareStart,
                         timePrepareEnd   = timePrepareEnd)

  #Is SLURM available?
  slurm <- lucode2::SystemCommandAvailable("srun")

  if(is.na(cfg$sequential)) cfg$sequential <- !slurm

  if(slurm & !cfg$sequential) {
    if(is.null(cfg$qos)) {
      # try to select best QOS based on available resources
      # and available information
      load <- lucode2::getClusterLoad()
      if(is.null(load)) {
        cfg$qos <- "standby"
      } else if(all(load > 80)) {
        cfg$qos <- "priority"
      } else if(load["priority"] < load["standard"]) {
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

getReportData <- function(path_to_report,LU_pricing="y2010") {

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

  # read REMIND report
  rep <- read.report(path_to_report, as.list = FALSE)
  if (length(getNames(rep,dim="scenario"))!=1) stop("getReportData: REMIND report contains more or less than 1 scenario.")
  rep <- collapseNames(rep) # get rid of scenrio and model dimension if they exist
  mag <- deletePlus(rep) #delete "+" and "++" from variable names

  if(!("y1995" %in% getYears(mag))){
  	empty95<-mag[,1,];empty95[,,]<-0;dimnames(empty95)[[2]] <- "y1995"
  	mag <- mbind(empty95,mag)
  }
  years <- 1990+5*(1:32)
  mag <- time_interpolate(mag,years)

  # delete old input files before updating them
  files <- c("./modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3","./modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv")
  for(f in files) suppressWarnings(unlink(f))

  .bioenergy_demand(mag)
  .emission_prices(mag)
}


start_reportrun <- function (cfg, path_report, inmodel=NULL, sceninreport=NULL, codeCheck=FALSE){
  if (!requireNamespace("magclass", quietly = TRUE)) {
    stop("Package \"magclass\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  if (!requireNamespace("gms", quietly = TRUE)) {
    stop("Package \"gms\" needed for this function to work. Please install it.",
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
	cfg       <- gms::setScenario(cfg,substring(scen,first=1,last=4))
	start_run(cfg, report=rep, sceninreport=scen, codeCheck=codeCheck)
  }
}
