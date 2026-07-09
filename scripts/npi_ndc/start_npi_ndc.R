# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de
## Functions for the national policy targets calculations
## Structure of policy is defined in the policy_definitions.csv file
## Policy target value. Interpretation depends on policy/landpool:
##                  #  - ad   : % protection in targetyear (0..1)
##                  #  - aff  : afforestation in Mha
##                  #  - affexp: pipe-delimited "TARGET_POTENTIAL|EXPANSION_SPEED"
##                  #           share of available 2030 potential (%) and
##                  #           annual expansion speed (% of remaining/yr)
calc_NPI_NDC <- function(policyregions = "iso",
                         pol_def_file = "policies/policy_definitions.csv",
                         cellmapping  = "policies/country2cell.rds",
                         land_stock_file = "../../modules/10_land/input/avl_land_t_0.5.mz",
                         potential_forest_file = "../../modules/35_natveg/input/pot_forest_area_0.5.mz",
                         map_file    = Sys.glob("../../input/clustermap_rev*.rds"),
                         outfolder_ad_aolc   = c("policies/","../../modules/35_natveg/input/"),
                         outfolder_aff   = c("policies/","../../modules/32_forestry/input/"),
                         out_ad_file     = "npi_ndc_ad_aolc_pol.cs3",
                         out_aff_file    = "npi_ndc_aff_pol.cs3") {

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
    
  coords <- getCoords(land_stock)
  names(coords) <- c("lon", "lat")
  m <- merge(coords, pol_mapping, sort = FALSE)
  getItems(land_stock, dim = "iso") <- m$policyregions
  
  # select map_file if more than one has been found
  if (length(map_file) > 1) {
    map_file <- grep("67420", map_file, value = TRUE, invert = TRUE)
  }
  stopifnot(length(map_file) == 1)

  forest_stock <- dimSums(land_stock[, , c("primforest", "secdforest", "forestry")], dim = 3) 
  getNames(forest_stock) <- "forest"

  # Load potential forest area at cell level, align items with land_stock
  # convention, then aggregate to country level for the affexp calculation.
  # The cell-level copy (potential_forest_cell) is kept for the disaggregation 
  # weight further down.
  potential_forest_cell <- read.magpie(potential_forest_file)


  coords <- getCoords(potential_forest_cell)
  names(coords) <- c("lon", "lat")
  m <- merge(coords, pol_mapping, sort = FALSE)
  getItems(potential_forest_cell, dim = "iso") <- m$policyregions
  lon <- sub(".", "p", pol_mapping$lon, fixed = TRUE)
  lat <- sub(".", "p", pol_mapping$lat, fixed = TRUE)
  rel_pot <- data.frame(
    from = paste(lon, lat, pol_mapping$policyregions, sep = "."),
    to   = pol_mapping$policyregions,
    stringsAsFactors = FALSE
  )

  potential_forest <- madrat::toolAggregate(potential_forest_cell, rel_pot)
  getNames(potential_forest) <- "pot_forest"

  ##############################################################################
  ##########    Structure of policy .csv files                    ##############
  ##############################################################################
  # "landpool"       #Land pool policy type: forest, other, affore
  # "policy"         #Policy exists: npi, ndc, affexp
  # "targettype"     #Policy target type: 1 baseyear (e.g. 2005), 2 baseline
  # "baseyear"       #Baseyear (target type 1) / starting year (target type 2) for policy calculation
  # "targetyear"     #Year by which policy_target is achieved (e.g. 2020 or 2030)
  #                  # for "affexp" it is NA since no fixed target year is used
  # "target"         #Policy target value. Interpretation depends on policy/landpool:
  #                  #  - ad   : % protection in targetyear (0..1)
  #                  #  - aff  : afforestation in Mha
  #                  #  - affexp: pipe-delimited "TARGET_POTENTIAL|EXPANSION_SPEED"
  #                  #           share of available 2030 potential (%) and
  #                  #           annual expansion speed (% of remaining/yr)
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
  ndc_ad[,which(getYears(ndc_ad,as.integer=TRUE)<=2025),] <-
    npi_ad[,which(getYears(npi_ad,as.integer=TRUE)<=2025),]
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
  ndc_aolc[,which(getYears(ndc_aolc,as.integer=TRUE)<=2025),] <-
    npi_aolc[,which(getYears(npi_aolc,as.integer=TRUE)<=2025),]

  #write AD and AOLC policies together
  none_ad_aolc_pol <- mbind(npi_ad,npi_aolc)
  none_ad_aolc_pol[] <- 0
  getNames(none_ad_aolc_pol) <- c("none.forest","none.other")
  ad_aolc_pol <- mbind(none_ad_aolc_pol,npi_ad,npi_aolc,ndc_ad,ndc_aolc)

  adfiles <- paste0(outfolder_ad_aolc, out_ad_file)
  write.magpie(round(ad_aolc_pol, 6), adfiles[1])
  if (length(adfiles) > 1) {
    for (i in 2:length(adfiles)) file.copy(adfiles[1],adfiles[i], overwrite=TRUE)
  }
  cat(paste0(" (time elapsed: ", format(proc.time()["elapsed"]-ptm, width = 6, nsmall = 2, digits = 2), "s)\n"))

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
                         weight=dimSums(land_stock[,2005,c("crop","past")]) + 10^-10,
                         map_file=map_file)
  getNames(npi_aff) <- "npi"
  cat(paste0(" (time elapsed: ",format(proc.time()["elapsed"]-ptm,width=6,nsmall=2,digits=2),"s)\n"))

  cat("Compute NDC AFF policy")
  addline("")
  addline("###############")
  addline("### NDC AFF ###")
  addline("###############")
  ndc_aff <- droplevels(subset(pol_def, policy=="ndc" & landpool=="affore"))
  addtable(ndc_aff[,c(-2,-3)])
  ndc_aff <- calc_policy(ndc_aff, land_stock, pol_type="aff", pol_mapping=pol_mapping,
                         weight=dimSums(land_stock[,2005,c("crop","past")]) + 10^-10,
                         map_file=map_file)
  getNames(ndc_aff) <- "ndc"
  #set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
  ndc_aff[,which(getYears(ndc_aff,as.integer=TRUE)<=2025),] <-
    npi_aff[,which(getYears(npi_aff,as.integer=TRUE)<=2025),]

  none_aff_pol <- npi_aff
  none_aff_pol[] <- 0
  getNames(none_aff_pol) <- "none"
  cat(paste0(" (time elapsed: ", format(proc.time()["elapsed"] - ptm, width = 6, nsmall = 2, digits = 2), "s)\n"))

  addline("")
  addline("##----------------------------------------------------------------------------")
  addline("## Afforestation Expansion - AFFEXP (Mha)")
  addline("## Target % of 2030 potential and annual expansion speed")
  addline("## Format: TARGET_POTENTIAL|EXPANSION_SPEED")

  cat("Compute AFFEXP policy")
  addline("")
  addline("###################")
  addline("### AFFEXP ###")
  addline("###################")

  affexp_def <- droplevels(subset(pol_def, policy == "affexp"))
  affexp <- NULL

  if (nrow(affexp_def) > 0) {
    addtable(affexp_def[, c(-2, -3)])

    # Cell-level weight for disaggregation: available headroom toward 2030 potential.
    # Forest area per cell now (sum of prim/sec/forestry from land_stock) and
    # potential forest area per cell in 2030; weight is the positive difference.

    forest_now_cell <- dimSums(land_stock[,, c("primforest", "secdforest" ,"forestry")], dim = 3)
    affexp_weight   <- pmax(setYears(potential_forest_cell[, 2030, ], NULL)
                              - setYears(forest_now_cell[, tail(getYears(forest_now_cell), 1), ], NULL), 0) + 1e-10

    affexp <- calc_policy(affexp_def, forest_stock, pol_type = "affexp",
                          pol_mapping     = pol_mapping,
                          potential_stock = potential_forest,
                          weight          = affexp_weight,
                          map_file        = map_file)
    getNames(affexp) <- "affexp"

    # Build affexp on top of npi_aff baseline, mirroring how ndc_aff uses npi_aff:
    #   years <= 2025 : copy npi values directly
    #   years >  2025 : npi[2025] (frozen) + own expansion increment
    npi_for_affexp <- npi_aff
    getNames(npi_for_affexp) <- "affexp"
    affexp[, which(getYears(affexp, as.integer = TRUE) <= 2025), ] <-
      npi_for_affexp[, which(getYears(npi_for_affexp, as.integer = TRUE) <= 2025), ]
    npi_at_2025 <- setYears(npi_for_affexp[, "y2025", ], NULL)
    for (yr in getYears(affexp)[getYears(affexp, as.integer = TRUE) > 2025]) {
      affexp[, yr, ] <- npi_at_2025 + setYears(affexp[, yr, ], NULL)
    }

  } else {
    cat(" (no affexp rows in policy_definitions.csv, skipping)")
  }
  cat(paste0(" (time elapsed: ",format(proc.time()["elapsed"]-ptm,width=6,nsmall=2,digits=2),"s)\n"))

  # Write AFF policies: none / npi / ndc / affexp (affexp included only when defined)
  aff_pol <- if (!is.null(affexp)) mbind(none_aff_pol, npi_aff, ndc_aff, affexp) else mbind(none_aff_pol, npi_aff, ndc_aff)
  afffiles <- paste0(outfolder_aff, out_aff_file)
  write.magpie(round(aff_pol, 6), afffiles[1])
  if(length(afffiles) > 1) for (i in 2:length(afffiles)) file.copy(afffiles[1],afffiles[i], overwrite=TRUE)
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

### calc policies: npi, ndc and affexp
calc_policy <- function(policy, stock, pol_type="aff", pol_mapping=pol_mapping,
                        weight=NULL, potential_stock=NULL, 
                        map_file = Sys.glob("../../input/clustermap_rev*.rds")) {

  ## For affexp: potential_stock must be provided (country-level potential forest)                          
  if (pol_type == "affexp" && is.null(potential_stock)) {
    stop("calc_policy(pol_type='affexp') requires potential_stock to be provided.")
  }

  #extent stock beyond last observed value with constant values from the last year
  ly <- tail(getYears(stock, as.integer = TRUE), 1)
  ly <- ly - ly %% 5
  year_extension  <- seq(ly + 5, 2150, 5)
  stock           <- stock[, c(seq(1995, ly, 5), rep(ly, length(year_extension))),]
  getYears(stock) <- c(seq(1995, ly, 5), year_extension)

  #full years
  tp <- getYears(stock, as.integer = TRUE)

  #select and filter countries that exist in the chosen policy mapping
  policy_countries <- intersect(policy$dummy, unique(pol_mapping$policyregions))
  policy <- policy[policy$dummy %in% policy_countries, ]

  #create key to distinguish different cases of baseyear, targetyear combinations
  policy$key <- paste(policy$baseyear, policy$targetyear)

  #set stock to zero or Inf for countries without policies
  # (representing no constraint for min and max constraints)
  if (pol_type == "ad") {
    stock[!(getItems(stock, "iso", full = TRUE) %in% policy_countries),,] <- 0
    #calculate flows
    flow <- calc_flows(stock)
    #account only for positive flows, i.e. deforestation
    flow[flow < 0] <- 0
  }

  # affexp pre-computation: aggregate cell-level forest stock to country level
  # and extend potential_stock to cover the full extended time horizon (tp).
  stock_country <- NULL
  tperiods      <- NULL
  if (pol_type == "affexp") {
    lon <- sub(".", "p", pol_mapping$lon, fixed = TRUE)
    lat <- sub(".", "p", pol_mapping$lat, fixed = TRUE)
    rel_stock <- data.frame(
      from = paste(lon, lat, pol_mapping$policyregions, sep = "."),
      to   = pol_mapping$policyregions,
      stringsAsFactors = FALSE)
    stock_country <- madrat::toolAggregate(stock, rel_stock)
 
    # Extend potential_stock with constant fill if its time axis is shorter than tp.
    pot_years <- getYears(potential_stock, as.integer = TRUE)
    last_py   <- tail(pot_years, 1)
    missing_y <- tp[tp > last_py]
    if (length(missing_y) > 0) {
      ext <- potential_stock[, rep(last_py, length(missing_y)), ]
      getYears(ext) <- missing_y
      potential_stock <- mbind(potential_stock, ext)
    }
 
    tperiods <- calc_tperiods(c(tp[1], tp))
  }

  #Initialize magpie_policy with 0 (country level)
  #This is a return object of this function and contains policy targets at
  #cluster level
  magpie_policy <- new.magpie(unique(pol_mapping$policyregions), tp, NULL, 0)
  keys <- unique(policy$key)
  for (i in keys) {
    countries <- policy$dummy[policy$key == i]

    if (pol_type == "affexp") {
      # Only baseyear is meaningful for affexp; targetyear is NA in the CSV.
      baseyear <- as.integer(sub(" .*$", "", i))

      for (country in countries) {
        target_str <- as.character(policy[policy$dummy == country & policy$key == i, "target"])
        parts <- strsplit(target_str, "\\|")[[1]]
        if (length(parts) != 2 || any(is.na(suppressWarnings(as.numeric(parts))))) {
          stop("affexp target must be 'TARGET_POTENTIAL|EXPANSION_SPEED', got: ",
            target_str, " (country: ", country, ")")
        }

        target_share <- as.numeric(parts[1]) / 100
        annual_speed <- as.numeric(parts[2]) / 100

        forest_base    <- as.numeric(stock_country[country, 2030, ])
        available_2030 <- max(0, as.numeric(potential_stock[country, 2030, ]) - forest_base)
        cap            <- target_share * available_2030  # ultimate additional Mha target

        added <- 0
        for (year in tp) {
          if (year < baseyear) {
            magpie_policy[country, year, ] <- 0
          } else {
            dt            <- as.numeric(tperiods[, paste0("y", year), ])
            inc           <- min(cap * annual_speed * dt, max(0, cap - added))
            added         <- added + inc
            magpie_policy[country, year, ] <- added
          }
        }
      }

    } else {
      # Standard policies (aff, ad): linear interpolation between target years
      tmp        <- suppressWarnings(as.integer(strsplit(i, " ")[[1]]))
      baseyear   <- tmp[1]
      targetyear <- tmp[2]
      y_full     <- tp[tp >= baseyear]

      magpie_policy[countries, targetyear, ] <-
        as.numeric(policy[policy$key == i, "target"])
      #interpolate between baseyear and targetyear
      #set same target for all years after targetyear
      if (targetyear == baseyear) {
        magpie_policy[countries, y_full, ] <-
          setYears(magpie_policy[countries, baseyear, ], NULL)
      } else {
        magpie_policy[countries, y_full, ] <- time_interpolate(
          magpie_policy[countries, c(baseyear, targetyear), ], y_full,
          extrapolation_type = "constant")
      }

    #set reference flow based on target type
    if (pol_type == "ad") {
      c_index <- (sub("\\..*$", "", getCells(stock)) %in% countries)
      stock[c_index, tp > targetyear, ] <- setYears(stock[c_index, targetyear, ], NULL)
      targettypes <- unique(policy[policy$key == i, "targettype"])
      if (!all(targettypes %in% 1:2)) stop("unknow targettype; needs to be 1 or 2")
      if (any(targettypes == 1)) {
        t1countries <- policy$dummy[policy$key == i & policy$targettype == 1]
        t1c_index <- (sub("\\..*$", "", getCells(flow)) %in% t1countries)
        flow[t1c_index, , ] <- setYears(flow[t1c_index, baseyear, ], NULL)
      }
    }
  }
}

  #calculate the reduction target in absolute numbers / dissagregate to cells
  
  lon <- sub(".", "p", pol_mapping$lon, fixed = TRUE)
  lat <- sub(".", "p", pol_mapping$lat, fixed = TRUE)
  rel <- data.frame(
    from = pol_mapping$policyregions,
    to = paste(lon, lat, pol_mapping$policyregions, sep = "."),
    stringsAsFactors = FALSE)
  countryCell <- paste(lon, lat, pol_mapping$iso, sep = ".")
  
  if (pol_type == "aff" || pol_type == "affexp") {
    magpie_policy <- madrat::toolAggregate(x = magpie_policy, rel = rel, weight = weight)
  } else if (pol_type == "ad") {
    magpie_policy <- madrat::toolAggregate(x = magpie_policy, rel = rel)
    t_periods <- calc_tperiods(c(tp[1], tp))
    magpie_policy <- magpie_policy * flow * t_periods + stock
  }

  map <- readRDS(map_file)
  getItems(magpie_policy, dim = 1, raw = TRUE) <- map$cell
  magpie_policy <- madrat::toolAggregate(magpie_policy, map)

  return(magpie_policy)
}
