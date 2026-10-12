# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------------------------------------------
# description: Creates .mz files with disaggregated forest and other land age classes
# comparison script: FALSE
# -------------------------------------------------------------------------------------------------

# MAgPIE resolves age classes at cluster level only, while scripts/output/extra/disaggregation.R
# disaggregates the land pools to 0.5 degree. This script tracks the age class cohorts of
# secondary forest, forestry and other land at 0.5 degree with the cohort bookkeeping of the
# model (disturbance, recovery, ageing, maturation, harvest, establishment, reduction). The size
# of each flow is read from the gdx at cluster level, and the script only distributes it over
# the 0.5 degree cells of the cluster. In each time step the result is balanced against the
# cluster level age composition and the 0.5 degree pool areas by iterative proportional fitting.
#
# The young age classes are driven by gross flows that do not show in the net area change of a
# cell. Secondary forest ac0 comes from harvest regrowth, harvested primary forest and
# restoration, and secondary forest area gains enter by maturation of other land at the age
# the cohort already has. Forestry ac0 comes from new plantations and replanting after harvest.
#
# Output: cell.ageclass_<pool>_0.5_share.mz for the pools secdforest, forestry and other, with
# the share of the pool area in each age class.

library(lucode2)
library(gdx2)
library(magclass)

# =================================================================================================
# Basic configuration
# =================================================================================================

if (!exists("source_include")) {
  outputdir <- NULL
  # Define arguments that can be read from command line
  readArgs("outputdir")
}

# IPF convergence target as absolute deviation per cluster and age class (Mha)
ipfTol <- 1e-4
# maximum number of IPF iterations per pool and time step
ipfMaxIter <- 400
# IPF seed added to every cell and age class, as a fraction of a proportional disaggregation
seedShare <- 1e-6

withr::local_options(list(magclass_sizeLimit = 1e+12))

mapFile <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
gdx <- file.path(outputdir, "fulldata.gdx")
landHrFile <- file.path(outputdir, "cell.land_0.5.mz")

if (length(mapFile) == 0) stop("Could not find map file!")
if (length(mapFile) > 1) {
  warning("More than one map file found. First occurrence will be used.")
  mapFile <- mapFile[1]
}

# =================================================================================================
# Helper functions
# =================================================================================================

# ---- Output -------------------------------------------------------------------------------------

# as.magpie() leaves generic set names; set the "x.y.iso" cell convention of cell.land_0.5.mz
# and name the age class dimension
.fixCoords <- function(x) {
  getSets(x)[1:3] <- c("x.y.iso", "year", "ac")
  return(x)
}

# ---- Age class shift ----------------------------------------------------------------------------

# shift age classes forward by nShift, as in modules/35_natveg/pot_forest_may24/presolve.gms;
# the last column (acx) accumulates the area shifted beyond it
.ageShift <- function(areas, nShift) {
  nAgeClasses <- ncol(areas)
  if (nShift < 1) {
    return(areas)
  }
  shifted <- matrix(0, nrow = nrow(areas), ncol = nAgeClasses, dimnames = dimnames(areas))
  if (nShift >= nAgeClasses) {
    shifted[, nAgeClasses] <- rowSums(areas)
    return(shifted)
  }
  shifted[, (nShift + 1):nAgeClasses] <- areas[, 1:(nAgeClasses - nShift), drop = FALSE]
  shifted[, nAgeClasses] <- shifted[, nAgeClasses] +
    rowSums(areas[, (nAgeClasses - nShift + 1):nAgeClasses, drop = FALSE])
  return(shifted)
}

# ---- Distribution of cluster level flows to 0.5 degree ------------------------------------------

# spread a cluster level flow per age class over cells in proportion to `weight` in the same age
# class, so that a flow out of an age class only comes from cells that hold it
.spreadByAc <- function(clusterFlow, weight, clusterIdx) {
  clusterWeight <- rowsum(weight, clusterIdx)
  scale <- clusterFlow / clusterWeight
  scale[!is.finite(scale)] <- 0
  return(weight * scale[clusterIdx, , drop = FALSE])
}

# spread a cluster level total over cells in proportion to `weight`; clusters without weight
# use `fallback` instead
.spreadByCell <- function(clusterTotal, weight, fallback, clusterIdx) {
  weight[!is.finite(weight) | weight < 0] <- 0
  clusterWeight <- as.vector(rowsum(weight, clusterIdx))
  empty <- clusterWeight <= 0
  if (any(empty)) {
    useFallback <- empty[clusterIdx]
    weight[useFallback] <- pmax(fallback[useFallback], 0)
    clusterWeight <- as.vector(rowsum(weight, clusterIdx))
  }
  scale <- clusterTotal / clusterWeight
  scale[!is.finite(scale)] <- 0
  return(weight * scale[clusterIdx])
}

# remove a cluster level flow from a pool, capped by the area of each cell and age class; the
# part that exceeds the cap is distributed once more over the remaining area of the cluster
.takeFromPool <- function(pool, clusterFlow, clusterIdx) {
  taken <- pmin(.spreadByAc(clusterFlow, pool, clusterIdx), pool)
  shortfall <- clusterFlow - rowsum(taken, clusterIdx)
  shortfall[shortfall < 0] <- 0
  if (any(shortfall > 1e-12)) {
    headroom <- pool - taken
    extra <- pmin(.spreadByAc(shortfall, headroom, clusterIdx), headroom)
    taken <- taken + extra
  }
  return(list(taken = taken, pool = pool - taken))
}

# disaggregate a cluster level age class stock to cells with the age composition of the cluster
.seedProportional <- function(clusterStock, areaHrNow, clusterIdx) {
  share <- clusterStock / rowSums(clusterStock)
  share[!is.finite(share)] <- 0
  return(share[clusterIdx, , drop = FALSE] * areaHrNow)
}

# remove area from a pool where its cell total exceeds areaHrNow, in proportion to outWeight and
# then to the remaining area; cells below areaHrNow are filled by .runIpf()
.closeToCellTotals <- function(pool, areaHrNow, outWeight) {
  excess <- pmax(rowSums(pool) - areaHrNow, 0)
  weight <- outWeight
  weight[weight < 0] <- 0
  scale <- excess / rowSums(weight)
  scale[!is.finite(scale)] <- 0
  taken <- pmin(weight * scale, pool)
  # area that outWeight cannot cover is removed in proportion to the remaining area
  residual <- pmax(excess - rowSums(taken), 0)
  if (any(residual > 1e-15)) {
    headroom <- pool - taken
    headroomScale <- residual / rowSums(headroom)
    headroomScale[!is.finite(headroomScale)] <- 0
    taken <- taken + pmin(headroom * headroomScale, headroom)
  }
  return(pool - taken)
}

# ---- Other land pools ---------------------------------------------------------------------------

# Other land is tracked as othernat and youngsecdf, since maturation only takes area from
# youngsecdf. These two helpers combine and split them by area share.

# share of othernat in the combined other land area
.natShare <- function(otherNat, youngSecd) {
  share <- otherNat / (otherNat + youngSecd)
  share[!is.finite(share)] <- 1
  return(share)
}

# split a combined other land area into othernat and youngsecdf
.splitOther <- function(total, natShare) {
  otherNat <- total * natShare
  return(list(otherNat = otherNat, youngSecd = total - otherNat))
}

# ---- Balancing ----------------------------------------------------------------------------------

# Balance an age class field against the cluster age composition (columns) and the 0.5 degree
# cell totals (rows) by iterative proportional fitting. Convergence is checked after the row fit,
# so cell totals are exact on return. The seed keeps every age class reachable by the column fit.
.runIpf <- function(ageAreas, clusterTarget, clusterTargetShare, areaHrNow, clusterIdx) {
  ageAreas <- ageAreas + seedShare * (clusterTargetShare[clusterIdx, , drop = FALSE] * areaHrNow)
  for (iter in seq_len(ipfMaxIter)) {
    clusterSum <- rowsum(ageAreas, clusterIdx)
    colScale <- clusterTarget / clusterSum
    colScale[!is.finite(colScale)] <- 0
    ageAreas <- ageAreas * colScale[clusterIdx, , drop = FALSE]
    rowScale <- areaHrNow / rowSums(ageAreas)
    rowScale[!is.finite(rowScale)] <- 0
    ageAreas <- ageAreas * rowScale
    err <- max(abs(rowsum(ageAreas, clusterIdx) - clusterTarget))
    if (err < ipfTol) break
  }
  return(list(ageAreas = ageAreas, iter = iter, err = err))
}

# ---- Diagnostics --------------------------------------------------------------------------------

# Gross area gain of cell.land_0.5.mz per cluster in excess of the gross inflow of the model,
# summed over clusters (Mha). Where it is positive, no age class allocation can give every
# gaining cell enough newly established area.
.grossExcess <- function(areaNow, areaPrev, modelInflow, clusterIdx) {
  hrGain <- as.vector(rowsum(pmax(areaNow - areaPrev, 0), clusterIdx))
  return(sum(pmax(hrGain - modelInflow, 0)))
}

# =================================================================================================
# Read input data
# =================================================================================================

# Suffix Lr marks cluster level data, Hr marks 0.5 degree data.

# ---- Cluster level age classes and gross flows --------------------------------------------------

message("Reading cluster level age classes and gross flows from ", gdx)

# level of a gdx variable
.lvl <- function(symbol, ...) readGDX(gdx, symbol, select = list(type = "level"), ...)

# stocks
secdfLr <- .lvl("ov35_secdforest")
forestryLr <- dimSums(.lvl("ov32_land", react = "silent"), dim = "type32")
otherLr <- .lvl("ov_land_other", format = "first_found")

# presolve flows
disturbSecdfLr <- readGDX(gdx, "p35_disturbance_loss_secdf", react = "silent")
disturbPrimfLr <- readGDX(gdx, "p35_disturbance_loss_primf", react = "silent")
recoveryLr <- readGDX(gdx, "p35_forest_recovery_area", react = "silent")
matureLr <- readGDX(gdx, "p35_maturesecdf", react = "silent")

# solve flows
secdfExpLr <- .lvl("ov35_secdforest_expansion")
secdfRedLr <- .lvl("ov35_secdforest_reduction")
hvSecdfLr <- .lvl("ov35_hvarea_secdforest")
hvPrimfLr <- .lvl("ov35_hvarea_primforest")
otherExpLr <- .lvl("ov35_other_expansion")
otherRedLr <- .lvl("ov35_other_reduction")
hvOtherLr <- .lvl("ov35_hvarea_other")
forestryExpLr <- dimSums(.lvl("ov32_land_expansion"), dim = "type32")
forestryRedLr <- dimSums(.lvl("ov32_land_reduction"), dim = "type32")
hvForestryLr <- .lvl("ov32_hvarea_forestry")
replantLr <- .lvl("ov32_land_replant")

# restoration enters secondary forest ac_est; p35_land_restoration has no time dimension, so the
# copy that presolve.gms writes back to pm_land_conservation in each time step is read
# (modules/35_natveg/pot_forest_may24/presolve.gms)
consvLr <- readGDX(gdx, "pm_land_conservation", react = "silent")

acNames <- getItems(secdfLr, dim = 3)
nAc <- length(acNames)
modelYears <- getYears(secdfLr)

# ---- 0.5 degree land pools ----------------------------------------------------------------------

message("Reading disaggregated land pools from ", landHrFile)
landHr <- read.magpie(landHrFile)[, modelYears, ]
cellNames <- getItems(landHr, dim = 1)
nCell <- length(cellNames)

# ---- Cluster mapping ----------------------------------------------------------------------------

map <- readRDS(mapFile)
clusterNames <- getItems(secdfLr, dim = 1)
clusterOfCell <- as.character(map$cluster)[match(cellNames, as.character(map$cell))]
if (anyNA(clusterOfCell)) stop("Not all 0.5 degree cells could be matched to a cluster!")
if (!all(clusterNames %in% clusterOfCell)) stop("Cluster names of map file and gdx do not match!")
# index of each cell into the cluster level arrays; rowsum(x, clusterIdx) returns clusterNames order
clusterIdx <- match(clusterOfCell, clusterNames)

# ---- Time steps ---------------------------------------------------------------------------------

yearNum <- as.numeric(sub("y", "", modelYears))

# age classes shifted per time step (time step length / 5), equal to the number of
# establishment age classes (ac_est in modules/28_ageclass/oct24/presolve.gms)
shiftPerStep <- c(NA, diff(yearNum) / 5)
if (any(shiftPerStep[-1] != round(shiftPerStep[-1]))) {
  stop("Time steps are not multiples of the age class width!")
}
message(
  "Age classes shifted per time step: ",
  paste(paste0(modelYears[-1], "=", shiftPerStep[-1]), collapse = ", ")
)

# =================================================================================================
# Prepare the time loop
# =================================================================================================

# ---- Cluster level arrays -----------------------------------------------------------------------

# cluster x year x age class array
.clusterAc <- function(x) as.array(x)[clusterNames, , acNames, drop = FALSE]
# cluster x year matrix
.clusterVec <- function(x) {
  arr <- as.array(x)[clusterNames, , , drop = FALSE]
  return(matrix(arr, nrow = length(clusterNames), ncol = dim(arr)[2]))
}

secdfAc <- .clusterAc(secdfLr)
forestryAc <- .clusterAc(forestryLr)
otherNatAc <- .clusterAc(collapseNames(otherLr[, , "othernat"]))
youngSecdAc <- .clusterAc(collapseNames(otherLr[, , "youngsecdf"]))

disturbSecdf <- .clusterAc(disturbSecdfLr)
recovery <- .clusterAc(recoveryLr)
mature <- .clusterAc(matureLr)
secdfRed <- .clusterAc(secdfRedLr)
hvSecdf <- .clusterAc(hvSecdfLr)
forestryRed <- .clusterAc(forestryRedLr)
hvForestry <- .clusterAc(hvForestryLr)
otherNatRed <- .clusterAc(collapseNames(otherRedLr[, , "othernat"]))
youngSecdRed <- .clusterAc(collapseNames(otherRedLr[, , "youngsecdf"]))
hvOther <- .clusterAc(dimSums(hvOtherLr, dim = "othertype35"))

disturbPrimf <- .clusterVec(disturbPrimfLr)
secdfExp <- .clusterVec(secdfExpLr)
hvPrimf <- .clusterVec(hvPrimfLr)
forestryExp <- .clusterVec(forestryExpLr)
replant <- .clusterVec(replantLr)
otherNatExp <- .clusterVec(collapseNames(otherExpLr[, , "othernat"]))
restoreSecdf <- .clusterVec(collapseNames(consvLr[, , "secdforest.restore"]))

# ---- 0.5 degree land pools ----------------------------------------------------------------------

landArr <- as.array(landHr)
# 0.5 degree area of a land pool (cell x year)
.poolArea <- function(pool) landArr[, , pool]

# ---- Output and diagnostics ---------------------------------------------------------------------

poolLongName <- c(
  secdforest = "secondary forest",
  forestry = "planted forest (forestry)",
  other = "other land"
)

# One share array per pool, written to one file per pool: the memory use of write.magpie() grows
# with the width of the data dimension, so three files with 62 age classes each need less memory
# than one file with 186.
mzShareArr <- list()
diagnostics <- list()
for (pool in names(poolLongName)) {
  mzShareArr[[pool]] <- array(NA_real_,
    dim = c(nCell, length(modelYears), nAc),
    dimnames = list(cellNames, modelYears, acNames)
  )
  diagnostics[[pool]] <- data.frame(
    year = yearNum, cellDev = NA_real_, clusterDevMax = NA_real_, clusterDevRms = NA_real_,
    ipfIter = NA_real_, hrGrossExcess = NA_real_, zeroStockFallback = NA_real_
  )
}

# =================================================================================================
# Track age class cohorts
# =================================================================================================

for (ti in seq_along(modelYears)) {
  shift <- shiftPerStep[ti]
  nEst <- if (ti == 1) 1 else shift
  estCols <- seq_len(nEst)

  secdfAreaNow <- .poolArea("secdforest")[, ti]
  forestryAreaNow <- .poolArea("forestry")[, ti]
  otherAreaNow <- .poolArea("other")[, ti]
  primfAreaNow <- .poolArea("primforest")[, ti]

  if (ti == 1) {
    # first time step: proportional disaggregation of the cluster age composition
    secdf <- .seedProportional(secdfAc[, ti, ], secdfAreaNow, clusterIdx)
    forestry <- .seedProportional(forestryAc[, ti, ], forestryAreaNow, clusterIdx)
    otherClusterAc <- otherNatAc[, ti, ] + youngSecdAc[, ti, ]
    natShareCluster <- .natShare(otherNatAc[, ti, ], youngSecdAc[, ti, ])
    otherParts <- .splitOther(
      .seedProportional(otherClusterAc, otherAreaNow, clusterIdx),
      natShareCluster[clusterIdx, , drop = FALSE]
    )
    otherNat <- otherParts$otherNat
    youngSecd <- otherParts$youngSecd
    hrGrossExcess <- c(secdforest = NA_real_, forestry = NA_real_, other = NA_real_)
  } else {
    # --- presolve: disturbance, recovery, ageing, maturation -------

    # disturbance moves secondary and primary forest loss into ac_est before the shift
    disturbed <- .takeFromPool(secdf, disturbSecdf[, ti, ], clusterIdx)
    secdf <- disturbed$pool
    disturbedTotal <- rowSums(disturbed$taken) +
      .spreadByCell(disturbPrimf[, ti], primfAreaNow, primfAreaNow + 1e-12, clusterIdx)
    secdf[, estCols] <- secdf[, estCols] + disturbedTotal / nEst

    # recovery of abandoned land towards forest moves othernat to youngsecdf
    recovered <- .takeFromPool(otherNat, recovery[, ti, ], clusterIdx)
    otherNat <- recovered$pool
    youngSecd <- youngSecd + recovered$taken

    # ageing
    secdf <- .ageShift(secdf, shift)
    forestry <- .ageShift(forestry, shift)
    otherNat <- .ageShift(otherNat, shift)
    youngSecd <- .ageShift(youngSecd, shift)

    # maturation: youngsecdf becomes secondary forest at the age it has
    matured <- .takeFromPool(youngSecd, mature[, ti, ], clusterIdx)
    youngSecd <- matured$pool
    secdf <- secdf + matured$taken

    # --- solve: harvest, establishment, reduction -------

    # Harvested area leaves its age class and enters ac_est in the same cell, so harvest does not
    # change the pool area. Only the remainder of ac_est is new area
    # (q35_secdforest_regeneration in modules/35_natveg/pot_forest_may24/equations.gms,
    # q32_land_replant in modules/32_forestry/dynamic_may24/equations.gms).

    # secondary forest: harvested area regrows in place
    harvestedSecdf <- .takeFromPool(secdf, hvSecdf[, ti, ], clusterIdx)
    secdf <- harvestedSecdf$pool
    hvSecdfCell <- rowSums(harvestedSecdf$taken)
    secdf[, estCols] <- secdf[, estCols] + hvSecdfCell / nEst
    # the remainder of ac_est is harvested primary forest, reclassified as secondary forest, in
    # cells that lose primary forest, and restoration in cells that gain secondary forest
    extraEstSecdf <- pmax(secdfExp[, ti] - as.vector(rowsum(hvSecdfCell, clusterIdx)), 0)
    primfLoss <- pmax(.poolArea("primforest")[, ti - 1] - primfAreaNow, 0)
    secdfGain <- pmax(secdfAreaNow - .poolArea("secdforest")[, ti - 1], 0)
    weightEstSecdf <-
      .spreadByCell(hvPrimf[, ti], primfLoss, primfAreaNow + 1e-12, clusterIdx) +
      .spreadByCell(restoreSecdf[, ti], secdfGain, secdfAreaNow + 1e-12, clusterIdx)
    secdfEst <- .spreadByCell(extraEstSecdf, weightEstSecdf, secdfAreaNow + 1e-12, clusterIdx)
    secdf[, estCols] <- secdf[, estCols] + secdfEst / nEst
    # deforestation is the part of the reduction that is not harvest
    deforSecdf <- pmax(secdfRed[, ti, ] - hvSecdf[, ti, ], 0)

    # forestry: harvested area is replanted in place up to the replanted area of the model, the
    # rest of the harvested area leaves the pool
    harvestedForestry <- .takeFromPool(forestry, hvForestry[, ti, ], clusterIdx)
    forestry <- harvestedForestry$pool
    hvForestryCell <- rowSums(harvestedForestry$taken)
    replantCell <- pmin(
      .spreadByCell(replant[, ti], hvForestryCell, forestryAreaNow + 1e-12, clusterIdx),
      hvForestryCell
    )
    forestry[, estCols] <- forestry[, estCols] + replantCell / nEst
    # the remainder of ac_est is new plantation area
    extraEstForestry <- pmax(forestryExp[, ti] - as.vector(rowsum(replantCell, clusterIdx)), 0)
    forestryGain <- pmax(forestryAreaNow - .poolArea("forestry")[, ti - 1], 0)
    forestryEst <- .spreadByCell(extraEstForestry, forestryGain, forestryAreaNow + 1e-12, clusterIdx)
    forestry[, estCols] <- forestry[, estCols] + forestryEst / nEst
    deforForestry <- pmax(forestryRed[, ti, ] - hvForestry[, ti, ], 0)

    # other land: harvested area regrows in place, in othernat ac_est
    otherAll <- otherNat + youngSecd
    natShare <- .natShare(otherNat, youngSecd)
    harvestedOther <- .takeFromPool(otherAll, hvOther[, ti, ], clusterIdx)
    otherParts <- .splitOther(harvestedOther$pool, natShare)
    otherNat <- otherParts$otherNat
    youngSecd <- otherParts$youngSecd
    hvOtherCell <- rowSums(harvestedOther$taken)
    otherNat[, estCols] <- otherNat[, estCols] + hvOtherCell / nEst
    # the remainder of ac_est is abandoned managed land
    extraEstOther <- pmax(otherNatExp[, ti] - as.vector(rowsum(hvOtherCell, clusterIdx)), 0)
    otherGain <- pmax(otherAreaNow - .poolArea("other")[, ti - 1], 0)
    otherEst <- .spreadByCell(extraEstOther, otherGain, otherAreaNow + 1e-12, clusterIdx)
    otherNat[, estCols] <- otherNat[, estCols] + otherEst / nEst
    deforOther <- pmax(otherNatRed[, ti, ] + youngSecdRed[, ti, ] - hvOther[, ti, ], 0)

    # --- reduce the pools to the 0.5 degree cell totals -------

    secdf <- .closeToCellTotals(
      secdf, secdfAreaNow,
      .spreadByAc(deforSecdf, secdf, clusterIdx) + 1e-30
    )

    forestry <- .closeToCellTotals(
      forestry, forestryAreaNow,
      .spreadByAc(deforForestry, forestry, clusterIdx) + 1e-30
    )

    otherAll <- otherNat + youngSecd
    natShare <- .natShare(otherNat, youngSecd)
    otherAllClosed <- .closeToCellTotals(
      otherAll, otherAreaNow,
      .spreadByAc(deforOther, otherAll, clusterIdx) + 1e-30
    )
    otherParts <- .splitOther(otherAllClosed, natShare)
    otherNat <- otherParts$otherNat
    youngSecd <- otherParts$youngSecd

    # gross area gain of cell.land_0.5.mz in excess of the gross inflow of the model
    hrGrossExcess <- c(
      secdforest = .grossExcess(
        secdfAreaNow, .poolArea("secdforest")[, ti - 1],
        secdfExp[, ti] + rowSums(mature[, ti, ]), clusterIdx
      ),
      forestry = .grossExcess(
        forestryAreaNow, .poolArea("forestry")[, ti - 1], forestryExp[, ti], clusterIdx
      ),
      other = .grossExcess(
        otherAreaNow, .poolArea("other")[, ti - 1], otherNatExp[, ti], clusterIdx
      )
    )
  }

  # --- balance, diagnose and store -------

  for (pool in names(poolLongName)) {
    ageAreas <- switch(pool,
      secdforest = secdf,
      forestry = forestry,
      other = otherNat + youngSecd
    )
    areaHrNow <- switch(pool,
      secdforest = secdfAreaNow,
      forestry = forestryAreaNow,
      other = otherAreaNow
    )
    clusterAcNow <- switch(pool,
      secdforest = secdfAc[, ti, ],
      forestry = forestryAc[, ti, ],
      other = otherNatAc[, ti, ] + youngSecdAc[, ti, ]
    )

    # A cluster can report no stock of a pool while cell.land_0.5.mz has area of that pool in its
    # cells. These clusters get a uniform age composition, so that the cell area can be placed.
    clusterStockTotal <- rowSums(clusterAcNow)
    clusterAcShare <- clusterAcNow / clusterStockTotal
    clusterAcShare[!is.finite(clusterAcShare)] <- 0
    zeroStockCluster <- clusterStockTotal <= 0
    if (any(zeroStockCluster)) clusterAcShare[zeroStockCluster, ] <- 1 / nAc
    clusterTarget <- clusterAcShare * as.vector(rowsum(areaHrNow, clusterIdx))

    # 0.5 degree area in clusters without model stock of the pool
    diagnostics[[pool]]$zeroStockFallback[ti] <-
      sum(as.vector(rowsum(areaHrNow, clusterIdx))[zeroStockCluster])

    ipf <- .runIpf(ageAreas, clusterTarget, clusterAcShare, areaHrNow, clusterIdx)
    ageAreas <- ipf$ageAreas
    diagnostics[[pool]]$ipfIter[ti] <- ipf$iter
    if (ipf$err >= ipfTol) {
      warning(
        "IPF did not converge for ", pool, " in ", modelYears[ti],
        " after ", ipfMaxIter, " iterations (cluster margin error ", signif(ipf$err, 3), " Mha)"
      )
    }

    diagnostics[[pool]]$cellDev[ti] <- max(abs(rowSums(ageAreas) - areaHrNow))
    clusterDev <- rowsum(ageAreas, clusterIdx) - clusterTarget
    diagnostics[[pool]]$clusterDevMax[ti] <- max(abs(clusterDev))
    diagnostics[[pool]]$clusterDevRms[ti] <- sqrt(mean(clusterDev^2))
    diagnostics[[pool]]$hrGrossExcess[ti] <- hrGrossExcess[[pool]]

    # the balanced field is the tracked state for the next time step
    if (pool == "secdforest") {
      secdf <- ageAreas
    } else if (pool == "forestry") {
      forestry <- ageAreas
    } else {
      otherParts <- .splitOther(ageAreas, .natShare(otherNat, youngSecd))
      otherNat <- otherParts$otherNat
      youngSecd <- otherParts$youngSecd
    }

    ageShare <- ageAreas / rowSums(ageAreas)
    ageShare[!is.finite(ageShare)] <- NA_real_

    mzShareArr[[pool]][, ti, ] <- ageShare
    rm(ageShare, ageAreas)
  }

  message(sprintf(
    "  %s | cell dev %.2e | cluster dev %.2e Mha | ipf %s/%s/%s",
    modelYears[ti],
    max(vapply(diagnostics, function(d) d$cellDev[ti], numeric(1))),
    max(vapply(diagnostics, function(d) d$clusterDevMax[ti], numeric(1))),
    diagnostics$secdforest$ipfIter[ti], diagnostics$forestry$ipfIter[ti],
    diagnostics$other$ipfIter[ti]
  ))
  gc(verbose = FALSE)
}

# =================================================================================================
# Write output
# =================================================================================================

for (pool in names(poolLongName)) {
  mzFile <- file.path(outputdir, paste0("cell.ageclass_", pool, "_0.5_share.mz"))
  # write.magpie() takes the file format from the extension, so the temporary file ends in .mz
  mzFileTmp <- sub("\\.mz$", "_tmp.mz", mzFile)
  unlink(mzFileTmp)

  ageClassesHr <- .fixCoords(as.magpie(mzShareArr[[pool]], spatial = 1, temporal = 2))
  write.magpie(ageClassesHr, mzFileTmp,
    file_type = "mz",
    comment = paste0("unit: share of ", poolLongName[[pool]], " area in each age class")
  )
  mzShareArr[[pool]] <- NULL
  rm(ageClassesHr)
  gc(verbose = FALSE)

  unlink(mzFile)
  if (!file.rename(mzFileTmp, mzFile)) {
    stop("Could not rename ", mzFileTmp, " to ", mzFile, ". The result is kept in ", mzFileTmp, ".")
  }
  message("Wrote ", mzFile)
}
rm(mzShareArr)
gc(verbose = FALSE)

# =================================================================================================
# Summary
# =================================================================================================

message("\n### Residual misalignment between 0.5 degree and cluster level")
for (pool in names(diagnostics)) {
  poolDiag <- diagnostics[[pool]]
  message(sprintf(
    paste(
      "%-11s max cell dev %.2e Mha | max cluster dev %.2e Mha | max rms %.2e Mha",
      "| max ipf iter %s | max HR gross gain in excess of model inflow %.1f Mha",
      "| max HR area in clusters with zero model stock %.1f Mha"
    ),
    pool, max(poolDiag$cellDev), max(poolDiag$clusterDevMax), max(poolDiag$clusterDevRms),
    max(poolDiag$ipfIter), max(poolDiag$hrGrossExcess, na.rm = TRUE),
    max(poolDiag$zeroStockFallback, na.rm = TRUE)
  ))
}
