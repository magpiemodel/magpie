# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de
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

## calculates policy for protecting different land pools from land use change
calc_NPI_NDC <- function(policyregions="iso"){

  require(magclass)
  require(luscale)
  require(lucode)

  # load the cell mapping policy
  pol_mapping <- readRDS("policies/country2cell.rds")[,policyregions]

  ##############################################################################
  ##########          Information from the reference observed data   ###########
  ##############################################################################

  #read in cellular land cover (stock) from landuse initialization
  land_stock <- read.magpie("../../modules/10_land/input/avl_land_t_0.5.mz")
  getRegions(land_stock) <- paste(pol_mapping,1:59199,sep=".")

  forest_stock <- dimSums(land_stock[,,c("primforest","secdforest","forestry")], dim=3)
  getNames(forest_stock) <- "forest"

  ##############################################################################
  ##########    Structure of policy .csv files                    ##############
  ##############################################################################
  # "landpool"       #Land pool policy type: forest, other, affore
  # "policy"         #Policy exists: npi, ndc
  # "targettype"     #Policy target type: 1 baseyear (e.g. 2005), 2 baseline
  # "baseyear"       #Baseyear (target type 1) / starting year (target type 2) for policy calculation
  # "targetyear"     #Year by which policy_target is achieved (e.g. 2020 or 2030)
  # "target"         #Policy target value in % (e.g. allowed deforestation in % in targetyear; afforestation in Mha in case of affore=TRUE)
  ##############################################################################


  # output file for formated writing of the npi/ndc policies
  fname <- "npi_ndc_overview.txt"
  if(file.exists(fname)) unlink(fname, force=TRUE)
  file.create(fname)
  # quick way of writing in the file line by line
  addline <- function(x){
    cat(paste(x,"\n"), file=fname, append=TRUE)
  }
  addtable <- function(x){
    capture.output(print(x, print.gap=3, row.names=FALSE), file=fname, append=TRUE)
  }

  pol_def <- read.csv("policies/policy_definitions.csv")

  addline("NPI/NDC policies")
  addline("MAgPIE")
  addline(date())

  addline("")
  addline("##----------------------------------------------------------------------------")
  addline("## Avoiding Deforestation - AD (%)")
  addline("## percentage protection: 0 = no protection, 1 = full protection")
  addline("## Ref: BaseYear (1), Baseline (2)")

  cat("NPI AD policy\n")
  addline("")
  addline("##############")
  addline("### NPI AD ###")
  addline("##############")
  npi_ad <- droplevels(subset(pol_def, policy=="npi" & landpool=="forest"))
  addtable(npi_ad[,c(-2,-3)])
  npi_ad <- calc_policy(npi_ad,forest_stock,pol_type="ad",pol_mapping=pol_mapping)
  getNames(npi_ad) <- "npi.forest"

  cat("NDC AD policy\n")
  addline("")
  addline("##############")
  addline("### NDC AD ###")
  addline("##############")
  ndc_ad <- droplevels(subset(pol_def, policy=="ndc" & landpool=="forest"))
  addtable(ndc_ad[,c(-2,-3)])
  ndc_ad <- calc_policy(ndc_ad,forest_stock,pol_type="ad",pol_mapping=pol_mapping)
  getNames(ndc_ad) <- "ndc.forest"
  #Set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
  ndc_ad[,which(getYears(ndc_ad,as.integer=TRUE)<=2020),] <-
    npi_ad[,which(getYears(npi_ad,as.integer=TRUE)<=2020),]


  addline("")
  addline("##----------------------------------------------------------------------------")
  addline("## Avoiding Other Land Conversion - AOLC (%)")
  addline("## percentage protection: 0 = no protection, 1 = full protection")
  addline("## Ref: BaseYear (1), Baseline (2)")

  cat("NPI AOLC policy\n")
  addline("")
  addline("################")
  addline("### NPI AOLC ###")
  addline("################")
  npi_aolc <- droplevels(subset(pol_def, policy=="npi" & landpool=="other"))
  addtable(npi_aolc[,c(-2,-3)])
  npi_aolc <- calc_policy(npi_aolc,land_stock[,,"other"],pol_type="ad",pol_mapping=pol_mapping)
  getNames(npi_aolc) <- "npi.other"

  cat("NDC AOLC policy\n")
  addline("")
  addline("################")
  addline("### NDC AOLC ###")
  addline("################")
  ndc_aolc <- droplevels(subset(pol_def, policy=="ndc" & landpool=="other"))
  addtable(ndc_aolc[,c(-2,-3)])
  ndc_aolc <- calc_policy(ndc_aolc,land_stock[,,"other"],pol_type="ad",pol_mapping=pol_mapping)
  getNames(ndc_aolc) <- "ndc.other"
  #Set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
  ndc_aolc[,which(getYears(ndc_aolc,as.integer=TRUE)<=2020),] <-
    npi_aolc[,which(getYears(npi_aolc,as.integer=TRUE)<=2020),]

  #write AD and AOLC policies together
  none_ad_aolc_pol <- mbind(npi_ad,npi_aolc)
  none_ad_aolc_pol[] <- 0
  getNames(none_ad_aolc_pol) <- c("none.forest","none.other")
  ad_aolc_pol <- mbind(none_ad_aolc_pol,npi_ad,npi_aolc,ndc_ad,ndc_aolc)
  write.magpie(ad_aolc_pol, "policies/npi_ndc_ad_aolc_pol.cs3")

  addline("")
  addline("##----------------------------------------------------------------------------")
  addline("## Afforestation - AFF (Mha)")
  addline("## Ref: BaseYear (1), Baseline (2)")

  cat("NPI AFF policy\n")
  addline("")
  addline("###############")
  addline("### NPI AFF ###")
  addline("###############")
  npi_aff <- droplevels(subset(pol_def, policy=="npi" & landpool=="affore"))
  addtable(npi_aff[,c(-2,-3)])
  npi_aff <- calc_policy(npi_aff,land_stock,pol_type="aff",pol_mapping=pol_mapping,
                         weight=dimSums(land_stock[,2005,c("crop","past")]))
  getNames(npi_aff) <- "npi"

  cat("NDC AFF policy\n")
  addline("")
  addline("###############")
  addline("### NDC AFF ###")
  addline("###############")
  ndc_aff <- droplevels(subset(pol_def, policy=="ndc" & landpool=="affore"))
  addtable(ndc_aff[,c(-2,-3)])
  ndc_aff <- calc_policy(ndc_aff,land_stock,pol_type="aff",pol_mapping=pol_mapping,
                         weight=dimSums(land_stock[,2005,c("crop","past")]))
  getNames(ndc_aff) <- "ndc"
  #set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
  ndc_aff[,which(getYears(ndc_aff,as.integer=TRUE)<=2020),] <-
    npi_aff[,which(getYears(npi_aff,as.integer=TRUE)<=2020),]

  #write AFF policies
  none_aff_pol <- npi_aff
  none_aff_pol[] <- 0
  getNames(none_aff_pol) <- "none"
  aff_pol <- mbind(none_aff_pol,npi_aff,ndc_aff)
  write.magpie(aff_pol, "policies/npi_ndc_aff_pol.cs3")

  #copy files
  file.copy("policies/npi_ndc_ad_aolc_pol.cs3",
            "../../modules/35_natveg/input/npi_ndc_ad_aolc_pol.cs3",overwrite = TRUE)
  file.copy("policies/npi_ndc_aff_pol.cs3",
            "../../modules/32_forestry/input/npi_ndc_aff_pol.cs3",overwrite = TRUE)
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
  ## pol_type = {"aff","ad"}

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

  #select and filter countries that exist in the chosen policy mapping
  policy_countries <- intersect(policy$dummy,unique(pol_mapping))

  #set stock to zero or Inf for countries without policies
  # (representing no constraint for min and max constraints)
  if(pol_type=="ad"){
    stock[setdiff(getRegions(stock),policy_countries),,] <- 0
    #calculate flows
    flow <- calc_flows(stock,t_periods)
    #account only for positive flows
    flow[flow < 0] <- 0
  }

  #Initialize magpie_policy with 0 (country level)
  #This is a return object of this function and contains policy targets at
  #cluster level
  magpie_policy <- new.magpie(unique(pol_mapping),tp,NULL,0)
  for (i in policy_countries) {
    cat(i,round(which(policy_countries==i)/length(policy_countries)*100),"%\n")
    #get baseyear and targetyear
    baseyear <- policy[which(policy$dummy==i),"baseyear"]
    targetyear <- policy[which(policy$dummy==i),"targetyear"]
    y_pol <- tp[tp>= baseyear & tp<=targetyear]
    y_pol_forever <- tp[tp>= targetyear]

    #set target in targetyear
    #percentage: 0 = no reduction, 1 = full reduction of deforestation
    #Mha if pol_type=="aff"
    magpie_policy[i,targetyear,] <- policy[which(policy$dummy==i),"target"]
    #interpolate between baseyear and targetyear
    magpie_policy[i,y_pol,] <- time_interpolate(magpie_policy[i,c(baseyear,targetyear),],y_pol)
    #set same target for all years after targetyear
    magpie_policy[i,y_pol_forever,] <- setYears(magpie_policy[i,targetyear,],NULL)
    #get target type
    targettype <- policy[which(policy$dummy==i),"targettype"] #1 baseyear target #2 baseline target

    #set reference flow based on target type
    if(pol_type=="ad") {
      stock[i,tp>targetyear,] <- setYears(stock[i,targetyear,],NULL)
      ref_flow <- new.magpie(getCells(stock),getYears(stock),NULL,0)
      if (targettype == 1) {
        ref_flow[i,,] <- setYears(flow[i,baseyear,],NULL)
      } else if (targettype == 2) {
        ref_flow[i,,] <- flow[i,,]
      } else stop("unknow targettype; needs to be 1 or 2")
    }
  }

  #calculate the reduction target in absolute numbers
  rel <- data.frame(from=pol_mapping,to=paste(pol_mapping,1:length(pol_mapping),sep="."))
  if(pol_type=="aff") {
    magpie_policy <- speed_aggregate(x=magpie_policy, rel=rel, weight=weight)
  } else if(pol_type=="ad") {
    magpie_policy <- speed_aggregate(x=magpie_policy, rel=rel)
    magpie_policy <- magpie_policy * ref_flow * t_periods + stock
  }

  load("../../input/spatial_header.rda")
  getCells(magpie_policy) <- spatial_header

  res_out <- get_info("../../input/info.txt","^\\* Output ?resolution:",": ")
  res_high <- get_info("../../input/info.txt","^\\* Input ?resolution:",": ")
  spam_file <- path("../../input",paste0(res_high,"-to-",res_out,"_sum.spam"))
  magpie_policy <- speed_aggregate(magpie_policy,spam_file)

  return(magpie_policy)
}
