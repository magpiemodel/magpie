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

## calculates policy targets as input for MAgPIE NPI and NDC runs based on
## dataset with observed values
## the function runs in the scripts/npi_ndc/. directory
calc_NPI_NDC <- function(policyregions="iso" # column with regions for policy definition in country2cell.rda
                         ){

  require(lucode)
  require(magclass)
  require(magpie4)
  require(luscale)
  require(moinput)
  require(mrvalidation)

  # load the cell mapping policy
  pol_mapping <- readRDS("policies/country2cell.rds")[,policyregions]

  ##############################################################################
  ##########          Information from the reference files        ##############
  ##############################################################################

  #read in observed co2 emissions from moinput
  setConfig(forcecache=TRUE)
  emis_flow <- calcOutput(type="ValidEmissions", datasource="PRIMAPhist", aggregate=FALSE, try=TRUE)
  emis_flow <- emis_flow[,,"historical.PRIMAPhist.Emissions|CO2|Land|Land-use Change (Mt CO2/yr)"]

  #read in cellular carbon stocks from lpj for decarbonizatoin policy constraints calculation
  avl_land <- read.magpie("../../modules/10_land/input/avl_land_0.5.mz")
  lpj_carbon_density <- setYears(read.magpie("../../modules/52_carbon/input/lpj_carbon_stocks_0.5.mz")[,1,],NULL)
  getCells(lpj_carbon_density) <- getCells(avl_land)
  carbon_stock <- avl_land*lpj_carbon_density
  carbon_stock <- dimSums(carbon_stock,dim=3)
  getYears(carbon_stock) <- "1995"
  getRegionList(carbon_stock) <-  pol_mapping

  #read in cellular land cover (stock) from moinput
  land_stock <- calcOutput("LanduseInitialisation", land="new", aggregate = FALSE, selectyears=seq(1995,2015,5), cellular=TRUE)
  getRegionList(land_stock) <-  pol_mapping
  forest_stock <- dimSums(land_stock[,,c("primforest","secdforest","forestry")], dim=3)
  getNames(forest_stock) <- "forest"

  ##############################################################################
  ##########    Structure of policy .csv files                    ##############
  ##############################################################################
  # "policy"         #Policy exists: 0 FALSE, 1 TRUE
  # "targettype"     #Policy target type: 1 baseyear (e.g. 2005), 2 baseline
  # "baseyear"       #Baseyear (target type 1) / starting year (target type 2) for policy calculation
  # "targetyear"     #Year by which policy_target is achieved (e.g. 2020 or 2030)
  # "target"         #Policy target value in % (e.g. allowed deforestation/emissions in % in targetyear; afforestation in Mha in case of affore=TRUE)
  ##############################################################################

  ## BEGIN reduce deforestation

  cat("NPI AD policy\n")
  npi_ad <- read.magpie(path("policies","npi_pol_deforest.csv"))
  npi_ad <- calc_policy(npi_ad,forest_stock,pol_type="ad",pol_mapping=pol_mapping)
  getNames(npi_ad) <- "npi"


  cat("NDC AD policy\n")
  ndc_ad <- read.magpie(path("policies","ndc_pol_deforest.csv"))
  ndc_ad <- calc_policy(ndc_ad,forest_stock,pol_type="ad",pol_mapping=pol_mapping)
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
  npi_aff <- calc_policy(npi_aff,land_stock,pol_type="aff",pol_mapping=pol_mapping,
                         weight=dimSums(land_stock[,2005,c("crop","past")]))
  getNames(npi_aff) <- "npi"

  cat("NDC AFF policy\n")
  ndc_aff <- read.magpie(path("policies","ndc_pol_afforest.csv"))
  ndc_aff <- calc_target(ndc_aff,iso="ARM",land_stock,goal=0.201)
  ndc_aff <- calc_target(ndc_aff,iso="BLR",land_stock,goal=0.41)
  ndc_aff <- calc_target(ndc_aff,iso="BOL",land_stock)
  ndc_aff <- calc_target(ndc_aff,iso="BDI",land_stock,goal=0.2) #long term goal (2025) to have 20% of its geographical area under forest cover
  ndc_aff <- calc_target(ndc_aff,iso="CHN",land_stock,goal=0.2304)
  ndc_aff <- calc_target(ndc_aff,iso="IND",land_stock,goal=0.33)
  ndc_aff <- calc_target(ndc_aff,iso="KHM",land_stock,goal=0.6)
  ndc_aff <- calc_target(ndc_aff,iso="LAO",land_stock,goal=0.7)
  ndc_aff <- calc_target(ndc_aff,iso="THA",land_stock,goal=0.4)
  ndc_aff <- calc_target(ndc_aff,iso="VNM",land_stock,goal=0.45)
  ndc_aff <- calc_policy(ndc_aff,land_stock,pol_type="aff",pol_mapping=pol_mapping,
                         weight=dimSums(land_stock[,2005,c("crop","past")]))
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
  npi_emis <- calc_policy(npi_emis,emis_flow,pol_type="emis",pol_mapping=pol_mapping,
                          weight=carbon_stock)
  getNames(npi_emis) <- "npi"

  cat("NDC EMIS policy\n")
  ndc_emis <- read.magpie(path("policies","ndc_pol_emis.csv"))
  ndc_emis <- calc_policy(ndc_emis,emis_flow,pol_type="emis",pol_mapping=pol_mapping,
                          weight=carbon_stock)
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
calc_target <- function(pol=npi_aff,iso="BDI",stock=land_stock,goal=1){
  baseyear <- as.numeric(pol[iso,,"baseyear"])
  targetyear <- as.numeric(pol[iso,,"targetyear"])
  if(iso=="BOL"){
    tmp <- 4.5 - dimSums(stock[iso,baseyear,c("primforest","secdforest","forestry")],dim=c(1,3))
  } else if(iso=="PAN"){
    tmp <- dimSums(stock[iso,,c("primforest","secdforest","forestry")],dim=c(1,3))*1.1
  } else{
    tmp <- dimSums(stock[iso,baseyear,],dim=c(1,3))*goal -
      dimSums(stock[iso,baseyear,c("primforest","secdforest","forestry")],dim=c(1,3))
  }
  tmp[tmp<0] <- 0
  pol[iso,,"target"] <- round(tmp,2)

  return(pol)
}

### calc flow function
calc_flows <- function(stock,t_periods) {
  flow <- stock
  flow[,,] <- 0
  for (y in 2:nyears(stock)) {
    flow[,y,] <- (setYears(stock[,y-1,],NULL) - stock[,y,])/t_periods[y]
  }
  return(flow)
}

### calc npi & ndc policy
calc_policy <- function(policy,stock,pol_type="aff",pol_mapping, weight=NULL) {
  ## pol_type = {"aff","ad","emis"}

  #extent stock beyond last observed value with constant values from the last year
  ly <- tail(getYears(stock,as.integer=TRUE),1)
  ly <- ly - ly%%5
  stock <- stock[,seq(1995,ly,5),]
  stock_extent <- new.magpie(getCells(stock), seq(ly+5,2150,5),
                                 getNames(stock), stock[,ly,])
  stock <- mbind(stock, stock_extent)
  rm(stock_extent)

  #the the years and periods
  tp <- getYears(stock, as.integer=TRUE)
  t_periods <- c(1, sapply(seq_along(tp[-1]), function(i) tp[i+1] - tp[i]))

  #select policy countires
  #only countries with a policy need constraint
  policy_countries <- getRegions(policy)[policy[,,"policy"]==1]
  #filter countries that exist in the chosen policy mapping
  policy_countries <- intersect(policy_countries,unique(pol_mapping))

  #set stock to zero or Inf for countries without policies
  # (representing no constraint for min and max constraints)
  if(pol_type=="ad"){
    stock[setdiff(getRegions(stock),policy_countries),,] <- 0
    #calculate flows
    flow <- calc_flows(stock,t_periods)
    #account only for positive flows
    flow[flow < 0] <- 0
  } else if(pol_type=="emis"){
    stock[stock<0] <- 0
  }

  #Initialize magpie_policy with 0 (country level)
  #This is a return object of this function and contains policy targets at
  #cluster level
  magpie_policy <- new.magpie(unique(pol_mapping),tp,NULL,0)
  for (i in policy_countries) {
    cat(i,round(which(policy_countries==i)/length(policy_countries)*100),"%\n")
    #get baseyear and targetyear
    baseyear <- c(policy[i,,"baseyear"]) #default 2005
    targetyear <- c(policy[i,,"targetyear"])
    y_pol <- tp[tp>= baseyear & tp<=targetyear]
    y_pol_forever <- tp[tp>= targetyear]

    #set target in targetyear
    #percentage: 0 = no reduction, 1 = full reduction of deforestation/emissions;
    #Mha if pol_type=="aff"
    magpie_policy[i,targetyear,] <- policy[i,,"target"]
    #interpolate between baseyear and targetyear
    magpie_policy[i,y_pol,] <- time_interpolate(magpie_policy[i,c(baseyear,targetyear),],y_pol)
    #set same target for all years after targetyear
    magpie_policy[i,y_pol_forever,] <- setYears(magpie_policy[i,targetyear,],NULL)
    #get target type
    targettype <- c(policy[i,,"targettype"]) #1 baseyear target #2 baseline target

    #set reference flow based on target type
    if(pol_type=="ad") {
      stock[i,tp<baseyear,] <- 0
      stock[i,tp>targetyear,] <- setYears(stock[i,targetyear,],NULL)
      ref_flow <- new.magpie(getCells(stock),getYears(stock),NULL,0)
      if (targettype == 1) {
        ref_flow[i,,] <- setYears(flow[i,baseyear,],NULL)
      } else if (targettype == 2) {
        ref_flow[i,,] <- flow[i,,]
      } else stop("unknow targettype; needs to be 1 or 2")
    } else if(pol_type=="emis"){
      # stock[i,tp<=baseyear,] <- NA
      stock[i,tp<=baseyear,] <- 0
      magpie_policy[i,,] <- stock[i,,]*(1-magpie_policy[i])
      # magpie_policy[i,,][is.na(magpie_policy[i])] <- Inf
    }
  }

  #calculate the reduction target in absolute numbers
  rel <- data.frame(from=pol_mapping,to=paste(pol_mapping,1:length(pol_mapping),sep="."))
  if(pol_type=="aff") {
    magpie_policy <- speed_aggregate(x=magpie_policy, rel=rel, weight=weight)
  } else if(pol_type=="ad") {
    magpie_policy <- speed_aggregate(x=magpie_policy, rel=rel)
    magpie_policy <- magpie_policy * ref_flow * t_periods + stock
  } else if(pol_type=="emis"){
    # magpie_policy[setdiff(getRegions(magpie_policy),policy_countries),,] <- Inf
    magpie_policy <- speed_aggregate(x=magpie_policy, rel=rel, weight=weight)
    # magpie_policy[is.nan(magpie_policy)] <- Inf
    # magpie_policy[setdiff(getRegions(magpie_policy),policy_countries),,] <- Inf
    # magpie_policy[is.na(magpie_policy)] <- Inf
  }

  load("../../input/spatial_header.rda")
  getCells(magpie_policy) <- spatial_header

  res_out <- get_info("../../input/info.txt","^\\* Output ?resolution:",": ")
  res_high <- get_info("../../input/info.txt","^\\* Input ?resolution:",": ")
  spam_file <- path("../../input",paste0(res_high,"-to-",res_out,"_sum.spam"))
  magpie_policy <- speed_aggregate(magpie_policy,spam_file)

  return(magpie_policy)
}
