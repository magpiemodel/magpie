# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de
## Functions for the policy targets calculations

## calculates policy for protecting different land pools from land use change
calc_NPI_NDC <- function(policyregions = "iso",
                         pol_def_file = "policies/policy_definitions.csv",
                         cellmapping  = "policies/country2cell.rds",
                         land_stock_file = "../../modules/10_land/input/avl_land_t_0.5.mz",
                         map_file    = Sys.glob("../../input/clustermap_rev*.rds"),
                         outfolder_ad_aolc   = c("policies/","../../modules/35_natveg/input/"),
                         outfolder_aff   = c("policies/","../../modules/32_forestry/input/"),
                         out_ad_file  = "npi_ndc_ad_aolc_pol.cs3",
                         out_aff_file = "npi_ndc_aff_pol.cs3"){

  require(magclass)
  require(madrat)

  # load the cell mapping policy
  pol_mapping <- readRDS(cellmapping)
  if(!(policyregions %in% names(pol_mapping))) stop("No cell mapping available for policyregions = ",policyregions)
  pol_mapping$policyregions <- pol_mapping[[policyregions]]

  ##############################################################################
  ##########          Information from the reference observed data   ###########
  ##############################################################################

  #read in cellular land cover (stock) from landuse initialization
  land_stock <- read.magpie(land_stock_file)
  
  # use pol_mapping to update spatial mapping of cells to regions
  # so that not only countries can be used for policies but also smaller
  # units such as provinces 
  if(dim(land_stock)[1] == 59199) { # 59199 cells
    if(dim(pol_mapping)[1] > 59199) {
      pol_mapping <- pol_mapping[order(pol_mapping$cell),]
      pol_mapping <- pol_mapping[!is.na(pol_mapping$cell),]
    }
    getItems(land_stock, dim = 1, raw = TRUE) <- paste(pol_mapping$policyregions,1:59199,sep=".")
  } else {
   coords <- getCoords(land_stock)
   names(coords) <- c("lon","lat")
   m <- merge(coords, pol_mapping, sort =FALSE)
   getItems(land_stock, dim = "iso") <- m$policyregions
  }
  
  # select map_file if more than one has been found
  if(length(map_file) > 1) {
    if(dim(land_stock)[1] == 67420) {
      map_file <- grep("67420", map_file, value = TRUE)
    } else {
      map_file <- grep("67420", map_file, value = TRUE, invert = TRUE)
    }
  }
  stopifnot(length(map_file) == 1)

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

  pol_def <- read.csv(pol_def_file)

  addline("NPI/NDC policies")
  addline("MAgPIE")
  addline(date())

  addline("")
  addline("##----------------------------------------------------------------------------")
  addline("## Avoiding Deforestation - AD (%)")
  addline("## percentage protection: 0 = no protection, 1 = full protection")
  addline("## Ref: BaseYear (1), Baseline (2)")

  ptm <- proc.time()["elapsed"]
  cat("Compute NPI   AD policy")
  addline("")
  addline("##############")
  addline("### NPI AD ###")
  addline("##############")
  npi_ad <- droplevels(subset(pol_def, policy=="npi" & landpool=="forest"))
  addtable(npi_ad[,c(-2,-3)])
  npi_ad <- calc_policy(npi_ad, forest_stock, pol_type="ad", pol_mapping=pol_mapping,
                        map_file=map_file)
  getNames(npi_ad) <- "npi.forest"
  cat(paste0(" (time elapsed: ",format(proc.time()["elapsed"]-ptm,width=6,nsmall=2,digits=2),"s)\n"))

  cat("Compute NDC   AD policy")
  addline("")
  addline("##############")
  addline("### NDC AD ###")
  addline("##############")
  ndc_ad <- droplevels(subset(pol_def, policy=="ndc" & landpool=="forest"))
  addtable(ndc_ad[,c(-2,-3)])
  ndc_ad <- calc_policy(ndc_ad, forest_stock, pol_type="ad", pol_mapping=pol_mapping,
                        map_file=map_file)
  getNames(ndc_ad) <- "ndc.forest"
  #Set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
  ndc_ad[,which(getYears(ndc_ad,as.integer=TRUE)<=2020),] <-
    npi_ad[,which(getYears(npi_ad,as.integer=TRUE)<=2020),]
  cat(paste0(" (time elapsed: ",format(proc.time()["elapsed"]-ptm,width=6,nsmall=2,digits=2),"s)\n"))


  addline("")
  addline("##----------------------------------------------------------------------------")
  addline("## Avoiding Other Land Conversion - AOLC (%)")
  addline("## percentage protection: 0 = no protection, 1 = full protection")
  addline("## Ref: BaseYear (1), Baseline (2)")

  cat("Compute NPI AOLC policy")
  addline("")
  addline("################")
  addline("### NPI AOLC ###")
  addline("################")
  npi_aolc <- droplevels(subset(pol_def, policy=="npi" & landpool=="other"))
  addtable(npi_aolc[,c(-2,-3)])
  npi_aolc <- calc_policy(npi_aolc, land_stock[,,"other"], pol_type="ad",
                          pol_mapping=pol_mapping, map_file=map_file)
  getNames(npi_aolc) <- "npi.other"
  cat(paste0(" (time elapsed: ",format(proc.time()["elapsed"]-ptm,width=6,nsmall=2,digits=2),"s)\n"))

  cat("Compute NDC AOLC policy")
  addline("")
  addline("################")
  addline("### NDC AOLC ###")
  addline("################")
  ndc_aolc <- droplevels(subset(pol_def, policy=="ndc" & landpool=="other"))
  addtable(ndc_aolc[,c(-2,-3)])
  ndc_aolc <- calc_policy(ndc_aolc, land_stock[,,"other"], pol_type="ad",
                          pol_mapping=pol_mapping, map_file=map_file)
  getNames(ndc_aolc) <- "ndc.other"
  #Set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
  ndc_aolc[,which(getYears(ndc_aolc,as.integer=TRUE)<=2020),] <-
    npi_aolc[,which(getYears(npi_aolc,as.integer=TRUE)<=2020),]

  #write AD and AOLC policies together
  none_ad_aolc_pol <- mbind(npi_ad,npi_aolc)
  none_ad_aolc_pol[] <- 0
  getNames(none_ad_aolc_pol) <- c("none.forest","none.other")
  ad_aolc_pol <- mbind(none_ad_aolc_pol,npi_ad,npi_aolc,ndc_ad,ndc_aolc)

  adfiles <- paste0(outfolder_ad_aolc, out_ad_file)
  write.magpie(floor(ad_aolc_pol*1e6)/1e6, adfiles[1])
  if(length(adfiles >1)) for(i in 2:length(adfiles)) file.copy(adfiles[1],adfiles[i], overwrite=TRUE)
  cat(paste0(" (time elapsed: ",format(proc.time()["elapsed"]-ptm,width=6,nsmall=2,digits=2),"s)\n"))

  addline("")
  addline("##----------------------------------------------------------------------------")
  addline("## Afforestation - AFF (Mha)")
  addline("## Ref: BaseYear (1), Baseline (2)")

  cat("Compute NPI  AFF policy")
  addline("")
  addline("###############")
  addline("### NPI AFF ###")
  addline("###############")
  npi_aff <- droplevels(subset(pol_def, policy=="npi" & landpool=="affore"))
  addtable(npi_aff[,c(-2,-3)])
  npi_aff <- calc_policy(npi_aff, land_stock, pol_type="aff", pol_mapping=pol_mapping,
                         weight=dimSums(land_stock[,2005,c("crop","past")]),
                         map_file=map_file)
  getNames(npi_aff) <- "npi"
  cat(paste0(" (time elapsed: ",format(proc.time()["elapsed"]-ptm,width=6,nsmall=2,digits=2),"s)\n"))

  cat("Compute NDC  AFF policy")
  addline("")
  addline("###############")
  addline("### NDC AFF ###")
  addline("###############")
  ndc_aff <- droplevels(subset(pol_def, policy=="ndc" & landpool=="affore"))
  addtable(ndc_aff[,c(-2,-3)])
  ndc_aff <- calc_policy(ndc_aff, land_stock, pol_type="aff", pol_mapping=pol_mapping,
                         weight=dimSums(land_stock[,2005,c("crop","past")]),
                         map_file=map_file)
  getNames(ndc_aff) <- "ndc"
  #set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
  ndc_aff[,which(getYears(ndc_aff,as.integer=TRUE)<=2020),] <-
    npi_aff[,which(getYears(npi_aff,as.integer=TRUE)<=2020),]

  #write AFF policies
  none_aff_pol <- npi_aff
  none_aff_pol[] <- 0
  getNames(none_aff_pol) <- "none"
  aff_pol <- mbind(none_aff_pol,npi_aff,ndc_aff)
  afffiles <- paste0(outfolder_aff, out_aff_file)
  write.magpie(floor(aff_pol*1e6)/1e6, afffiles[1])
  if(length(afffiles >1)) for(i in 2:length(afffiles)) file.copy(afffiles[1],afffiles[i], overwrite=TRUE)

  cat(paste0(" (time elapsed: ",format(proc.time()["elapsed"]-ptm,width=6,nsmall=2,digits=2),"s)\n"))
}

calc_tperiods <- function(y) {
  t_periods <- c(1,y[3:length(y)]-y[2:(length(y)-1)])
  names(t_periods) <- paste0("y",y[2:length(y)])
  return(as.magpie(t_periods))
}

### calc annual flow function
calc_flows <- function(stock) {
  stock <- stock[,c(1,1:nyears(stock)),]
  y <- getYears(stock,as.integer = TRUE)
  t_periods <- calc_tperiods(y)
  out <- (setYears(stock[,1:(nyears(stock)-1),],getYears(stock)[2:nyears(stock)])
          - stock[,2:nyears(stock),])/t_periods
  return(out)
}

### calc npi & ndc policy
calc_policy <- function(policy, stock, pol_type="aff", pol_mapping=pol_mapping,
                        weight=NULL, map_file = Sys.glob("../../input/clustermap_rev*.rds")) {
  ## pol_type = {"aff","ad"}

  require(madrat)

  #extent stock beyond last observed value with constant values from the last year
  ly <- tail(getYears(stock,as.integer=TRUE),1)
  ly <- ly - ly%%5
  year_extension  <- seq(ly+5,2150,5)
  stock           <- stock[,c(seq(1995,ly,5),rep(ly,length(year_extension))),]
  getYears(stock) <- c(seq(1995,ly,5), year_extension)

  #full years
  tp <- getYears(stock, as.integer=TRUE)

  #select and filter countries that exist in the chosen policy mapping
  policy_countries <- intersect(policy$dummy,unique(pol_mapping$policyregions))
  policy <- policy[policy$dummy %in% policy_countries,]

  #create key to distinguish different cases of baseyear, targetyear combinations
  policy$key <- paste(policy$baseyear,policy$targetyear)


  #set stock to zero or Inf for countries without policies
  # (representing no constraint for min and max constraints)
  if(pol_type=="ad"){
    if(dim(stock)[1] == 59199) {
      stock[!(sub("\\..*$","",getCells(stock)) %in% policy_countries),,] <- 0
    } else {
      stock[!(getItems(stock, "iso", full = TRUE) %in% policy_countries),,] <- 0
    }
    #calculate flows
    flow <- calc_flows(stock)
    #account only for positive flows, i.e. deforestation
    flow[flow < 0] <- 0
  }

  #Initialize magpie_policy with 0 (country level)
  #This is a return object of this function and contains policy targets at
  #cluster level
  magpie_policy <- new.magpie(unique(pol_mapping$policyregions),tp,NULL,0)
  keys <- unique(policy$key)
  for (i in keys) {
    #get baseyear and targetyear
    tmp <- as.integer(strsplit(i," ")[[1]])
    baseyear   <- tmp[1]
    targetyear <- tmp[2]
    countries  <- policy$dummy[policy$key==i]
    y_full <- tp[tp >= baseyear]

    #set target in targetyear
    #percentage: 0 = no reduction, 1 = full reduction of deforestation
    #Mha if pol_type=="aff"
    magpie_policy[countries,targetyear,] <- policy[policy$key==i,"target"]
    #interpolate between baseyear and targetyear
    #set same target for all years after targetyear
    if(targetyear==baseyear) {
      magpie_policy[countries,y_full,] <- setYears(magpie_policy[countries,baseyear,],NULL)
    } else {
      magpie_policy[countries,y_full,] <- time_interpolate(magpie_policy[countries,c(baseyear,targetyear),],y_full,
                                                         extrapolation_type = "constant")
    }
    #set reference flow based on target type
    if(pol_type=="ad") {
      c_index <- (sub("\\..*$","",getCells(stock)) %in% countries)
      stock[c_index,tp>targetyear,] <- setYears(stock[c_index,targetyear,],NULL)
      targettypes <- unique(policy[policy$key==i,"targettype"])
      if(!all(targettypes %in% 1:2)) stop("unknow targettype; needs to be 1 or 2")
      if (any(targettypes == 1)) {
        t1countries <- policy$dummy[policy$key==i & policy$targettype==1]
        t1c_index <- (sub("\\..*$","",getCells(flow)) %in% t1countries)
        flow[t1c_index,,] <- setYears(flow[t1c_index,baseyear,],NULL)
      }
    }
  }

  #calculate the reduction target in absolute numbers
  if(dim(pol_mapping)[1] == 59199) {
    rel <- data.frame(from=pol_mapping$policyregions,to=paste(pol_mapping$policyregions,1:59199,sep="."), stringsAsFactors = FALSE)
    countryCell <- paste(pol_mapping$iso,1:59199,sep=".")
  } else {
    lon <- sub(".", "p", pol_mapping$lon, fixed = TRUE)
    lat <- sub(".", "p", pol_mapping$lat, fixed = TRUE)
    rel <- data.frame(from=pol_mapping$policyregions,to=paste(lon, lat, pol_mapping$policyregions,sep="."), stringsAsFactors = FALSE)
    countryCell <- paste(lon, lat, pol_mapping$iso,sep=".")
  }
  if(pol_type=="aff") {
    magpie_policy <- madrat::toolAggregate(x=magpie_policy, rel=rel, weight=weight)
  } else if(pol_type=="ad") {
    magpie_policy <- madrat::toolAggregate(x=magpie_policy, rel=rel)
    t_periods <- calc_tperiods(c(tp[1],tp))
    magpie_policy <- magpie_policy * flow * t_periods + stock
  }

  map <- readRDS(map_file)
  getItems(magpie_policy, dim = 1, raw = TRUE) <- map$cell
  magpie_policy <- madrat::toolAggregate(magpie_policy,map)

  return(magpie_policy)
}
