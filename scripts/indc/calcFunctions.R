#spatial_header
load(paste0(base_run,"/spatial_header.rda"))

mapping<-toolMappingFile(type="cell",name="CountryToCellMapping.csv",readcsv=TRUE)  
countries<-unique(mapping$iso)

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

### create indc_pol file
create_indc <- function() {

  indc_pol <- new.magpie(countries,NULL,c("indc",           #INDC exists: 0 FALSE, 1 TRUE
                                          "targettype",     #INDC target type: 1 baseyear (e.g. 2005), 2 baseline (i.e. MAgPIE BAU scenario)
                                          "baseyear",       #Baseyear (target type 1) / starting year (target type 2) for INDC calculation
                                          "targetyear",     #Year by which indc_target is achieved (e.g. 2020 or 2030)
                                          "target"),        #INDC target value in % (e.g. allowed deforestation/emissions in % in targetyear; afforestation in Mha in case of affore=TRUE)
                         0)
  return(indc_pol)
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

### calc indc policy
calc_indc <- function(indc_pol,magpie_bau_stock,affore=FALSE,im_years) {
  
  #get Years
  y <- getYears(magpie_bau_stock,as.integer = TRUE)
  tmp <- seq(y[length(y)]+5,2150,by=5)
  y <- c(y, tmp)
  im_years <- mbind(im_years, new.magpie("GLO",tmp,NULL,5))
  
  #include country information in cells
  getCells(magpie_bau_stock) <- mapping$celliso
  
  #extent magpie_bau_stock beyond 2030
  magpie_bau_stock_extent <- new.magpie(getCells(magpie_bau_stock), tmp, getNames(magpie_bau_stock), 0) 
  magpie_bau_stock_extent[,,] <- setYears(magpie_bau_stock[,2030,],NULL)
  magpie_bau_stock <- mbind(magpie_bau_stock, magpie_bau_stock_extent)
  
  #Initialize magpie_indc with 0
  magpie_indc <- new.magpie(getRegions(indc_pol),y,NULL,0)
  
  #only countries with indc policy need constraint
  indc_true <- getRegions(indc_pol)[indc_pol[,,"indc"] == 1]
  
  #set magpie_bau_stock to zero for countries without policies (representing no constraint)
  if(!affore) magpie_bau_stock[setdiff(countries,indc_true),,] <- 0
  
  #create magpie_ref_flow object
  magpie_ref_flow <- new.magpie(mapping$celliso,getYears(magpie_bau_stock),NULL,0)
  
  #flows are only needed if affore=FALSE
  if(!affore) {
    #calculate flows
    magpie_bau_flow <- calc_flows(magpie_bau_stock,im_years)
    #account only for positive flows
    magpie_bau_flow[magpie_bau_flow < 0] <- 0
    getCells(magpie_bau_flow) <- mapping$celliso
  }
  
  #calculate transition over time (as share)
  for (i in indc_true) {
    print(paste0(round(which(indc_true == i)/length(indc_true)*100),"%"))
    #get baseyear and targetyear
    baseyear <- c(indc_pol[i,,"baseyear"]) #default 2005
    targetyear <- c(indc_pol[i,,"targetyear"])
    y_pol <- y[y>= baseyear & y<=targetyear]
    y_pol_forever <- y[y>= targetyear]
    
    #set bau stock before baseyear to zero - reflecting no policy 
    if(!affore) magpie_bau_stock[i,getYears(magpie_bau_stock,as.integer=TRUE)<baseyear,] <- 0
    
    #set target in targetyear
    #percentage: 0 = no reduction, 1 = full reduction of deforestation/emissions; 
    #Mha if affore=TRUE
    magpie_indc[i,targetyear,] <- indc_pol[i,,"target"]
    #interpolate between baseyear and targetyear
    magpie_indc[i,y_pol,] <- time_interpolate(magpie_indc[i,c(baseyear,targetyear),],y_pol)
    #set same target for all years after targetyear
    magpie_indc[i,y_pol_forever,] <- setYears(magpie_indc[i,targetyear,],NULL)
    #get target type
    targettype <- c(indc_pol[i,,"targettype"]) #1 baseyear target #2 baseline target
    
    #set reference flow based on target type
    if(!affore) {
      if (targettype == 1) {
        magpie_ref_flow[i,,] <- setYears(magpie_bau_flow[i,baseyear,],NULL)
      } else if (targettype == 2) {
        magpie_ref_flow[i,,] <- magpie_bau_flow[i,,]
      } else stop("unknow targettype; needs to be 1 or 2")
    }
  }
  
  #reset cellular mapping to MAgPIE format
  if(!affore) getCells(magpie_ref_flow) <- mapping$cell
  if(!affore) getCells(magpie_bau_flow) <- mapping$cell
  getCells(magpie_bau_stock) <- mapping$cell

  #calculate the reduction target in absolute numbers
  if (affore) {
      magpie_indc <- speed_aggregate(x = magpie_indc,rel = mapping, to = "cell", from = "iso",weight = dimSums(magpie_bau_stock[,2005,c("crop","past")]))
#      magpie_indc <- magpie_indc + collapseNames(magpie_bau_stock[,,"forestry"])
  } else {
    magpie_indc <- speed_aggregate(x=magpie_indc, rel=mapping, to="cell", from="iso")
    magpie_indc <- magpie_indc * magpie_ref_flow * im_years + magpie_bau_stock
  }
  
  getCells(magpie_indc) <- spatial_header
  
  # #check
  # print("MAgPIE BAU")
  # print(round(dimSums(magpie_bau_stock,dim=1),2))
  # print("MAgPIE INDC")
  # print(round(dimSums(magpie_indc,dim=1),2))
  
  return(magpie_indc)
}
