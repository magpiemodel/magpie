# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Collect reg, iso and grid level data from multiple FSDP runs
# comparison script: TRUE
# ---------------------------------------------------------------

# Version 1.0, Florian Humpenoeder

library(lucode2)
library(magclass)
library(gms)
library(magpiesets)
library(data.table)
library(gdx)
library(quitte)
library(m4fsdp)
library(stringr)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- file.path("output/", list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  lucode2::readArgs("outputdir")
}
###############################################################################

##########
#filter out calibration run
x         <- unlist(lapply(strsplit(basename(outputdir), "_"), function(x) x[2]))
outputdir <- outputdir[which(x %in% c("FSECa", "FSECb", "FSECc", "FSECd", "FSECe"))]

#get revision
x <- unlist(lapply(strsplit(basename(outputdir),"_"), function(x) x[1]))
if (length(unique(x)) == 1) rev <- unique(x) else stop("version prefix is not identical. Check your selection of runs")

##########
# Append health impacts reports
hi_datasets_path <- "/p/projects/magpie/data/FSEC_healthImpactsDatasets_raw"
if (dir.exists(hi_datasets_path)) {

    hi_datasets      <- list.files(hi_datasets_path)
    hi_versionToUse  <- grep(rev, hi_datasets, value = TRUE)

    if (length(hi_versionToUse) == 0) {

        message("In FSDP_collect.R: No corresponding version ID was found within the FSEC health impacts datasets.
              Using the highest current version.")

        highestVersionNr <- max(as.numeric(str_extract(hi_datasets, "(?<=v)(.*?)(?=_)")))
        hi_versionToUse <- grep(paste0("v", highestVersionNr), hi_datasets, value = TRUE)

    } else if (length(hi_versionToUse) >= 2) {
        stop("In FSDP_collect.R: More than one health impacts datasets with this scenario's version ID were found.
            Only one is expected.")
    }

    hi_versionToUse_path <- file.path(hi_datasets_path, hi_versionToUse)
    hi_gdx <- suppressWarnings(readGDX(hi_versionToUse_path))

    .appendHealthImpacts <- function(.x) {
        cfg <- gms::loadConfig(file.path(.x, "config.yml"))
        title <- cfg$title

        message("Appending health impact report: ", title)
        tryCatch(
            expr = {
                appendReportHealthImpacts(healthImpacts_gdx = hi_gdx,
                                          scenario = title,
                                          dir = .x)
            }, error = function(e) {
                message("In FSDP_collect.R: Unable to append health impacts!\n", e)
            }
        )
    }
    lapply(X = outputdir, FUN = .appendHealthImpacts)

} else {
    message("In FSDP_collect.R: Directory storing health impacts datasets wasn't found. Skipping health impacts.")
}

##########
# Append nutrient surplus reports
.appendNutrientSurplus <- function(.x) {
    cfg <- gms::loadConfig(file.path(.x, "config.yml"))
    title <- cfg$title

    tryCatch(
        expr = {
            appendReportNutrientSurplus(scenario = title, dir = .x)
        }, error = function(e) {
            message("In FSDP_collect.R: Unable to append the nutrient surplus dataset!\n", e)
        }
    )
}
lapply(X = outputdir, FUN = .appendNutrientSurplus)

##########
# Generate output files
cat("\nStarting output generation\n")

reg     <- NULL
iso     <- NULL
grid    <- NULL
missing <- NULL

saveRDS(outputdir,"outputdir.rds")

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  cfg <- gms::loadConfig(file.path(outputdir[i], "config.yml"))

  ### regional level outputs
  rep<-file.path(outputdir[i],"report.rds")
  if(file.exists(rep)) {
    reg <- rbind(reg,as.data.table(readRDS(rep)))
  } else missing <- c(missing,outputdir[i])

  ### ISO level outputs
  rep <- file.path(outputdir[i],"report_iso.rds")
  if(file.exists(rep)) {
    iso <- rbind(iso,as.data.table(readRDS(rep)))
  } else missing <- c(missing,outputdir[i])

  ### Grid level outputs
  ## only for BAU and SDP to save time and storage
  scen <- c("BAU", "FSDP")
  if (unlist(strsplit(cfg$title, "_"))[3] %in% scen) {
    y     <- NULL
    years <- c(2020, 2050)

    ## BII
    nc_file <- file.path(outputdir[i], paste(cfg$title, "cell.bii_0.5.mz", sep = "_"))#Note the "_" instead of "-"
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- "BII (index)"
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,outputdir[i])

    ## Crop diversity
    nc_file <- file.path(outputdir[i], paste0(scen, "-CropDiversityGridded.nc"))
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years, "ShannonCropDiversity"]
      getNames(a) <- "Shannon crop diversity (index)"
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,outputdir[i])

    ## land patterns Mha
    nc_file <- file.path(outputdir[i], "cell.land_0.5.mz")
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- paste0(getNames(a)," (Mha)")
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,outputdir[i])

    ## land patterns share
    nc_file <- file.path(outputdir[i], "cell.land_0.5_share.mz")
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- paste0(getNames(a)," (area share)")
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,outputdir[i])

    ## Nitrogen
    nc_file <- file.path(outputdir[i], paste(cfg$title,"nutrientSurplus_intensity.mz", sep="-"))
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- "nutrientSurplus (kg N per ha)"
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,outputdir[i])

    ## Water
    nc_file <- file.path(outputdir[i], paste("watStressViolations.mz", sep = "-"))
    if (file.exists(nc_file)) {
      a <- read.magpie(nc_file)[, years, ]
      getNames(a) <- "water stress and violations"
      getSets(a,  fulldim = FALSE)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y, a)
    } else missing <- c(missing, outputdir[i])

    #add dimensions
    y <- add_dimension(y, dim = 3.1, add = "scenario", nm = gsub(".", "_", cfg$title, fixed = TRUE))
    y <- add_dimension(y, dim = 3.1, add = "model", nm = "MAgPIE")
    getSets(y, fulldim = FALSE)[2] <- "period"

    #save as data.frame with xy coordinates
    y <- as.data.table(as.data.frame(y, rev = 3))

    #bind together
    grid <- rbind(grid, y)

  }
}

if (!is.null(missing)) {
  cat("\nList of folders with missing report files\n")
  print(missing)
}

message("Saving rds files ...")

saveRDS(reg, file = file.path("output", paste(rev, "FSDP_reg.rds", sep = "_")), version = 2, compress = "xz")
saveRDS(iso, file = file.path("output", paste(rev, "FSDP_iso.rds", sep = "_")), version = 2, compress = "xz")
saveRDS(grid, file = file.path("output", paste(rev, "FSDP_grid.rds", sep = "_")), version = 2, compress = "xz")

#save i_to_iso mapping
gdx     <- file.path(outputdir[1], "fulldata.gdx")
reg2iso <- readGDX(gdx, "i_to_iso")
names(reg2iso) <- c("region", "iso_a3")
write.csv(reg2iso, "output/reg2iso.csv")
saveRDS(reg2iso, file = file.path("output", "reg2iso.rds"), version = 2, compress = "xz")

#save validation file
val <- file.path(outputdir[1], "validation.mif")
val <- as.data.table(read.quitte(val))
saveRDS(val, file = file.path("output", paste(rev, "FSDP_validation.rds", sep = "_")), version = 2, compress = "xz")

message("Plotting figures ...")
heatmapFSDP(reg, tableType = 1, file = file.path("output", paste(rev, "FSDP_heatmap1.jpg", sep = "_")))
heatmapFSDP(reg, tableType = 2, file = file.path("output", paste(rev, "FSDP_heatmap2.jpg", sep = "_")))
spatialMapsFSDP(reg, iso, grid, reg2iso, file = file.path("output", paste(rev, "FSDP_spatialMaps.jpg", sep = "_")))
