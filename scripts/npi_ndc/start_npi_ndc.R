## Functions for the policy targets calculations

get_info <- function(file, grep_expression, sep, pattern="", replacement=""){
  if(!file.exists(file)) return("#MISSING#")
  file <- readLines(file, warn=FALSE)
  tmp <- grep(grep_expression, file, value=TRUE)
  tmp <- strsplit(tmp, sep)
  tmp <- sapply(tmp, "[[", 2)
  tmp <- gsub(pattern, replacement ,tmp)
  if(all(!is.na(as.logical(tmp)))) return(as.vector(sapply(tmp, as.logical)))
  if (all(!(regexpr("[a-zA-Z]",tmp) > 0))){
    tmp <- as.numeric(tmp)
  }
  return(tmp)
}

## The main function that starts the npi-ndc preprocessing
start_npi_ndc_preprocessing <- function(cfg="config/default.cfg",base_run_dir="scripts/npi_ndc/base_run",maindir=".",renew_base=FALSE, policyregions="iso"){

  require(lucode)
  require(magclass)
  require(gdx)
  require(luscale)

  source(path(maindir,"scripts/start_functions.R"))

  if(is.character(cfg)) {
    source(path(maindir,cfg), local=TRUE)
  }

  # Renew the base run
  # (delete the existing baserun folder if it exists)
  if(renew_base){
    if(dir.exists(base_run_dir)) unlink(base_run_dir, recursive=TRUE)
  # Use the existing base run
  } else if(dir.exists(base_run_dir) & !renew_base){
    cat("Trying to use existing base_run_dir ",base_run_dir, " for NPI/NDC recalculation!\n", sep="")
    # check for the existing files necessary for the calculation
    if(!file.exists(path(base_run_dir,"fulldata.gdx"))) {
      cat(base_run_dir,"/fulldata.gdx does not exist. Deleting and renewing ",base_run_dir,"\n", sep="")
      unlink(base_run_dir,recursive = TRUE)
    } else if(!file.exists(path(base_run_dir,"info.txt"))){
      cat(base_run_dir,"/info.txt does not exist. Deleting and renewing ",base_run_dir,"\n", sep="")
      unlink(base_run_dir,recursive = TRUE)
    } else if(!file.exists(path(base_run_dir,"cell.land_0.5.mz"))){
      cat(base_run_dir,"/cell.land_0.5.mz does not exist. Deleting and renewing ",base_run_dir,"\n", sep="")
      unlink(base_run_dir,recursive = TRUE)
    } else cat("success\n")
  }

  if(!dir.exists(base_run_dir)){
    cfg$title <- "base_run"
		cfg$sequential <- TRUE
    cfg$results_folder <- base_run_dir
		cfg$output <- c("interpolation")
		cfg$gms$c_timesteps <- "recalc_npi_ndc"
    cfg$recalc_base_run <- FALSE
    cfg$recalc_npi_ndc <- FALSE
    cfg$force_download <- FALSE
    cfg$recalibrate <- FALSE
    cfg <- setScenario(cfg,"SSP2")
		cfg <- setScenario(cfg,"BASE")

		cat("Starting MAgPIE base_run for NPI/NDC recalculation\n")
		start_run(cfg, codeCheck=TRUE, lock_model=FALSE)
    cat("New base_run executed!\n")
  }

  # write files from the base_run to be stored in the archives
  if(file.exists(path(base_run_dir,"fulldata.gdx")) &
     file.exists(path(base_run_dir,"cell.land_0.5.mz"))){

    gdx <- path(base_run_dir,"fulldata.gdx")
    res <- get_info(path(base_run_dir,"info.txt"),"^\\* Output ?resolution:",": ")

    #make directory for storing baseline files
    bsl_dir <- path(maindir,"scripts/npi_ndc/policies/npi_ndc_base")
    dir.create(bsl_dir)

    #read in cellular land cover (stock) from BAU
    magpie_bau_land <- read.magpie(path(base_run_dir,"cell.land_0.5.mz"))[,-1,]
    write.magpie(magpie_bau_land, path(maindir,"scripts/npi_ndc/policies/magpie_bau_land.mz"))
    write.magpie(magpie_bau_land, path(bsl_dir,"magpie_bau_land.mz"))

    #calc forest carbon stocks
    magpie_bau_cstock <- dimSums(readGDX(gdx,"ov_carbon_stock",select=list(type="level"))[,,c("primforest","secdforest")],dim=3)
    magpie_bau_cstock <- speed_aggregate(magpie_bau_cstock,
                                         rel=paste0(base_run_dir,"/0.5-to-",res,"_area_weighted_mean.spam"))
    write.magpie(magpie_bau_cstock, path(maindir,"scripts/npi_ndc/policies/magpie_bau_cstock.mz"))
    write.magpie(magpie_bau_cstock, path(bsl_dir,"magpie_bau_cstock.mz"))

    # tar files
    tardir(bsl_dir,"scripts/npi_ndc/policies/npi_ndc_base.tgz")
    unlink(bsl_dir, recursive=TRUE, force=TRUE)
  }

  setwd("scripts/npi_ndc")
  cat("Running calc_NPI_NDC.R\n")
	cat("Policy regional definition is set to: ", policyregions, "\n")

  calc_NPI_NDC(policyregions=policyregions)
  setwd("../..")
}

## calculates policy targets as input for MAgPIE NPI and NDC runs based on
## MAgPIE BAU pre-calculated files in the /policies/. folder
## the function runs in the scripts/policy/. directory
calc_NPI_NDC <- function(policyregions="iso" # column with regions for policy definition in country2cell.rda
                         ){

  require(lucode)
  require(magclass)
  require(magpie4)
  require(luscale)

  # load the cell mapping policy
  pol_mapping <- readRDS("policies/country2cell.rds")[,policyregions]

  ##############################################################################
  ##########          Information from the base_run files         ##############
  ##############################################################################

  #read in cellular land cover (stock) from the archived base_run data
  magpie_bau_land <- read.magpie("policies/magpie_bau_land.mz")
  getRegionList(magpie_bau_land) <-  pol_mapping

  #calc deforestation rate (flow)
  magpie_bau_forest <- dimSums(magpie_bau_land[,,c("primforest","secdforest")],dim=3)
  getNames(magpie_bau_forest) <- "forest"

  # read in forest carbon stocks from the archived base_run data
  magpie_bau_cstock <- read.magpie("policies/magpie_bau_cstock.mz")
  getRegionList(magpie_bau_cstock) <-  pol_mapping

  #get Years and time periods
  tp <- getYears(magpie_bau_land, as.integer=TRUE)
  t_periods <- c(1, sapply(seq_along(tp[-1]), function(i) tp[i+1] - tp[i]))
  tpp <- setYears(as.magpie(t_periods, temporal=TRUE), paste0("y", tp))
  tmp <- new.magpie(years=seq(2035,2150,5),fill=5)
  im_years <- mbind(tpp, tmp)

  ##############################################################################
  ##########    Structure of policy .csv files                    ##############
  ##############################################################################
  # "policy"         #Policy exists: 0 FALSE, 1 TRUE
  # "targettype"     #Policy target type: 1 baseyear (e.g. 2005), 2 baseline (i.e. MAgPIE BAU scenario)
  # "baseyear"       #Baseyear (target type 1) / starting year (target type 2) for policy calculation
  # "targetyear"     #Year by which policy_target is achieved (e.g. 2020 or 2030)
  # "target"         #Policy target value in % (e.g. allowed deforestation/emissions in % in targetyear; afforestation in Mha in case of affore=TRUE)
  ##############################################################################

  ## BEGIN reduce deforestation

  cat("NPI AD policy\n")
  npi_ad <- read.magpie(path("policies","npi_pol_deforest.csv"))
  npi_ad <- calc_policy(npi_ad,magpie_bau_forest,affore=FALSE,im_years=im_years,
                        pol_mapping=pol_mapping)
  getNames(npi_ad) <- "npi"


  cat("NDC AD policy\n")
  ndc_ad <- read.magpie(path("policies","ndc_pol_deforest.csv"))
  ndc_ad <- calc_policy(ndc_ad,magpie_bau_forest,affore=FALSE,im_years=im_years,
                        pol_mapping=pol_mapping)
  getNames(ndc_ad) <- "ndc"
  #Set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
  ndc_ad[,which(getYears(ndc_ad,as.integer=TRUE)<2015),] <- npi_ad[,which(getYears(npi_ad,as.integer=TRUE)<2015),]

  #write AD policies
  none_pol <- npi_ad; none_pol[] <- 0; getNames(none_pol) <- "none"
  ad_pol <- mbind(none_pol,npi_ad,ndc_ad)
  write.magpie(ad_pol, "policies/npi_ndc_ad_pol.cs3")

  ## END reduce deforestation

  ## BEGIN afforestation

  cat("NPI AFF policy\n")
  npi_aff <- read.magpie(path("policies","npi_pol_afforest.csv"))
  # fill out for additional target calculations
  npi_aff <- calc_target(npi_aff,iso="BDI",magpie_bau_land,goal=0.2) #long term goal (2025) to have 20% of its geographical area under forest cover
  npi_aff <- calc_target(npi_aff,iso="CHN",magpie_bau_land,goal=0.2304) #23.04% forest coverage by 2020 --> 50 Mha afforestation is neede
  npi_aff <- calc_policy(npi_aff,magpie_bau_land,affore=TRUE,im_years=im_years,
                        pol_mapping=pol_mapping)
  getNames(npi_aff) <- "npi"

  cat("NDC AFF policy\n")
  ndc_aff <- read.magpie(path("policies","ndc_pol_afforest.csv"))
  ndc_aff <- calc_target(ndc_aff,iso="ARM",magpie_bau_land,goal=0.201)
  ndc_aff <- calc_target(ndc_aff,iso="BLR",magpie_bau_land,goal=0.41)
  ndc_aff <- calc_target(ndc_aff,iso="BOL",magpie_bau_land)
  ndc_aff <- calc_target(ndc_aff,iso="BDI",magpie_bau_land,goal=0.2) #long term goal (2025) to have 20% of its geographical area under forest cover
  ndc_aff <- calc_target(ndc_aff,iso="CHN",magpie_bau_land,goal=0.2304)
  ndc_aff <- calc_target(ndc_aff,iso="IND",magpie_bau_land,goal=0.33)
  ndc_aff <- calc_target(ndc_aff,iso="KHM",magpie_bau_land,goal=0.6)
  ndc_aff <- calc_target(ndc_aff,iso="LAO",magpie_bau_land,goal=0.7)
  ndc_aff <- calc_target(ndc_aff,iso="THA",magpie_bau_land,goal=0.4)
  ndc_aff <- calc_target(ndc_aff,iso="VNM",magpie_bau_land,goal=0.45)
  ndc_aff <- calc_policy(ndc_aff,magpie_bau_land,affore=TRUE,im_years=im_years,
                         pol_mapping=pol_mapping)
  getNames(ndc_aff) <- "ndc"
  #set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
  ndc_aff[,which(getYears(ndc_aff,as.integer=TRUE)<2015),] <- npi_aff[,which(getYears(npi_aff,as.integer=TRUE)<2015),]

  #write AFF policies
  aff_pol <- mbind(none_pol,npi_aff,ndc_aff)
  write.magpie(aff_pol, "policies/npi_ndc_aff_pol.cs3")

  ## END afforestation

  ## BEGIN LUC CO2 emission reduction

  cat("NPI EMIS policy\n")
  npi_emis <- read.magpie(path("policies","npi_pol_emis.csv"))
  npi_emis <- calc_policy(npi_emis,magpie_bau_cstock,affore=FALSE,im_years=im_years,
                        pol_mapping=pol_mapping)
  getNames(npi_emis) <- "npi"

  cat("NDC EMIS policy\n")
  ndc_emis <- read.magpie(path("policies","ndc_pol_emis.csv"))
  ndc_emis <- calc_policy(ndc_emis,magpie_bau_cstock,affore=FALSE,im_years=im_years,
                         pol_mapping=pol_mapping)
  getNames(ndc_emis) <- "ndc"
  #set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
  ndc_emis[,which(getYears(ndc_emis,as.integer=TRUE)<2015),] <- npi_emis[,which(getYears(npi_emis,as.integer=TRUE)<2015),]

  #write EMIS policies
  emis_pol <- mbind(none_pol,npi_emis,ndc_emis)
  write.magpie(emis_pol, "policies/npi_ndc_emis_pol.cs3")

  ## END LUC CO2 emission reduction

  #copy files
  file.copy("policies/npi_ndc_ad_pol.cs3","../../modules/35_natveg/input/npi_ndc_ad_pol.cs3",overwrite = TRUE)
  file.copy("policies/npi_ndc_aff_pol.cs3","../../modules/32_forestry/input/npi_ndc_aff_pol.cs3",overwrite = TRUE)
  file.copy("policies/npi_ndc_emis_pol.cs3","../../modules/35_natveg/input/npi_ndc_emis_pol.cs3",overwrite = TRUE)
}

### calculates targets
calc_target <- function(pol=npi_aff,iso="BDI",magpie_bau_stock=magpie_bau_land,goal=1){
  baseyear <- as.numeric(pol[iso,,"baseyear"])
  targetyear <- as.numeric(pol[iso,,"targetyear"])
  if(iso=="BOL"){
    tmp <- 4.5 - dimSums(magpie_bau_stock[iso,baseyear,c("primforest","secdforest","forestry")],dim=c(1,3))
  } else if(iso=="PAN"){
    tmp <- dimSums(magpie_bau_stock[iso,,c("primforest","secdforest","forestry")],dim=c(1,3))*1.1
  } else{
    tmp <- dimSums(magpie_bau_stock[iso,baseyear,],dim=c(1,3))*goal -
      dimSums(magpie_bau_stock[iso,baseyear,c("primforest","secdforest","forestry")],dim=c(1,3))
  }
  tmp[tmp<0] <- 0
  pol[iso,,"target"] <- round(tmp,2)
  # write.magpie(pol,"policies/test.csv")

  return(pol)
}

### calc flow function
calc_flows <- function(stock,im_years) {
  flow <- stock
  flow[,,] <- 0
  for (y in 2:nyears(stock)) {
    flow[,y,] <- (setYears(stock[,y-1,],NULL) - stock[,y,])/im_years[y]
  }
  return(flow)
}

### calc npi & ndc policy
calc_policy <- function(policy,magpie_bau_stock,affore=FALSE,im_years,pol_mapping) {

  #extent magpie_bau_stock beyond 2030
  magpie_bau_stock_extent <- new.magpie(getCells(magpie_bau_stock),
                                        seq(2035,2150,5),
                                        getNames(magpie_bau_stock),
                                        0)
  magpie_bau_stock <- mbind(magpie_bau_stock, magpie_bau_stock_extent)
  rm(magpie_bau_stock_extent)

  #Initialize magpie_policy with 0 (country level)
  #This is a return object of this function and contains policy targets at cluster level
  magpie_policy <- new.magpie(unique(pol_mapping),getYears(im_years),NULL,0)

  #only countries with a policy need constraint
  policy_countries <- getRegions(policy)[policy[,,"policy"]==1]
  #filter countries that exist in the chosen policy mapping
  policy_countries <- intersect(policy_countries,unique(pol_mapping))

  #set magpie_bau_stock to zero for countries without policies (representing no constraint)
  if(!affore) magpie_bau_stock[setdiff(getRegions(magpie_bau_stock),policy_countries),,] <- 0

  #create magpie_ref_flow object
  magpie_ref_flow <- new.magpie(getCells(magpie_bau_stock),getYears(magpie_bau_stock),NULL,0)

  #flows are only needed if affore=FALSE
  if(!affore) {
    #calculate flows
    magpie_bau_flow <- calc_flows(magpie_bau_stock,im_years)
    #account only for positive flows
    magpie_bau_flow[magpie_bau_flow < 0] <- 0
  }

  #calculate transition over time (as share)
  for (i in policy_countries) {
    cat(i,round(which(policy_countries==i)/length(policy_countries)*100),"%\n")
    #get baseyear and targetyear
    baseyear <- c(policy[i,,"baseyear"]) #default 2005
    targetyear <- c(policy[i,,"targetyear"])
    y <- getYears(im_years, as.integer=TRUE)
    y_pol <- y[y>= baseyear & y<=targetyear]
    y_pol_forever <- y[y>= targetyear]

    #set bau stock before baseyear to zero - reflecting no policy
    if(!affore) magpie_bau_stock[i,getYears(magpie_bau_stock,as.integer=TRUE)<baseyear,] <- 0

    #set target in targetyear
    #percentage: 0 = no reduction, 1 = full reduction of deforestation/emissions;
    #Mha if affore=TRUE
    magpie_policy[i,targetyear,] <- policy[i,,"target"]
    #interpolate between baseyear and targetyear
    magpie_policy[i,y_pol,] <- time_interpolate(magpie_policy[i,c(baseyear,targetyear),],y_pol)
    #set same target for all years after targetyear
    magpie_policy[i,y_pol_forever,] <- setYears(magpie_policy[i,targetyear,],NULL)
    #get target type
    targettype <- c(policy[i,,"targettype"]) #1 baseyear target #2 baseline target

    #set reference flow based on target type
    if(!affore) {
      if (targettype == 1) {
        magpie_ref_flow[i,,] <- setYears(magpie_bau_flow[i,baseyear,],NULL)
      } else if (targettype == 2) {
        magpie_ref_flow[i,,] <- magpie_bau_flow[i,,]
      } else stop("unknow targettype; needs to be 1 or 2")
    }
  }

  #calculate the reduction target in absolute numbers
  rel <- data.frame(from=pol_mapping,to=paste(pol_mapping,1:length(pol_mapping),sep="."))
  if (affore) {
    magpie_policy <- speed_aggregate(x=magpie_policy,rel=rel, weight=dimSums(magpie_bau_stock[,2005,c("crop","past")]))
  } else {
    magpie_policy <- speed_aggregate(x=magpie_policy, rel=rel)
    magpie_policy <- magpie_policy * magpie_ref_flow * im_years + magpie_bau_stock
  }

  load("../../input/spatial_header.rda")
  getCells(magpie_policy) <- spatial_header

  res_out <- get_info("../../input/info.txt","^\\* Output ?resolution:",": ")
  res_high <- get_info("../../input/info.txt","^\\* Input ?resolution:",": ")
  spam_file <- path("../../input",paste0(res_high,"-to-",res_out,"_sum.spam"))
  magpie_policy <- speed_aggregate(magpie_policy,spam_file)

  return(magpie_policy)
}
