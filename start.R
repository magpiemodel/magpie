# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ======================================================================
# magpie/start.R — single entry point with three modes
#   (a) OPEN-PROM coupling trigger: env-vars set by task 7
#   (b) standalone + project: user fills manual_project / manual_subscenario below
#   (c) standalone + default: leave both manual_* empty -> run magpie default cfg
# ======================================================================

library(gms)
source("scripts/start_functions.R")

# Read a CSV with auto-detected separator (',' or ';'). Spreadsheet apps
# (Excel/Numbers/LibreOffice) round-trip CSVs to whichever default their
# locale prefers, so the file's separator can flip between edits.
read_csv_auto <- function(path, ...) {
  hdr <- readLines(path, n = 1, warn = FALSE)
  n_comma <- nchar(hdr) - nchar(gsub(",", "", hdr, fixed = TRUE))
  n_semi  <- nchar(hdr) - nchar(gsub(";", "", hdr, fixed = TRUE))
  if (n_semi > n_comma) read.csv2(path, ...) else read.csv(path, ...)
}

# ----------------------------------------------------------------------
# Standalone manual override
# Only used when running `cd magpie && Rscript start.R` to manually pick a
# project + subscenario. Leave both empty to run magpie defaults (no
# project-driven cfg). When triggered by OPEN-PROM task 7, env-vars
# below override these.
# ----------------------------------------------------------------------
manual_project     <- ""   # e.g. "uptake"
manual_subscenario <- ""   # e.g. "SSP2-PkBudg650"

# ----------------------------------------------------------------------
# Resolve project + subscenario: env-var > manual > empty
# ----------------------------------------------------------------------
project     <- Sys.getenv("OPENPROM_MAGPIE_PROJECT",     unset = manual_project)
subscenario <- Sys.getenv("OPENPROM_MAGPIE_SUBSCENARIO", unset = manual_subscenario)

source("config/default.cfg")

if (nzchar(project) && nzchar(subscenario)) {
  # ====================================================================
  # Project-driven cfg assembly (mode a / b)
  # ====================================================================
  proj_dir      <- file.path("projects", project)
  scenarios_csv <- file.path(proj_dir, "scenarios.csv")
  overlays_csv  <- file.path(proj_dir, "overlays.csv")

  if (!file.exists(scenarios_csv)) {
    stop("[", project, "] scenarios.csv not found at: ", scenarios_csv)
  }

  scenario_config <- read_csv_auto(scenarios_csv)
  if (!all(c("title", "base") %in% names(scenario_config))) {
    stop("[", project, "] scenarios.csv must have columns 'title' and 'base'")
  }
  row_index <- which(scenario_config$title == subscenario)
  if (length(row_index) != 1) {
    stop("[", project, "] subscenario '", subscenario,
         "' not found / ambiguous in ", scenarios_csv)
  }
  row <- scenario_config[row_index, ]

  # Column 'base': pipe-separated base scenario tuple -> setScenario
  base_tuple <- strsplit(row[["base"]], "\\|")[[1]]
  cfg <- setScenario(cfg, base_tuple)

  # Column 'overlay': overlays.csv column name (apply only when non-empty).
  # We read overlays.csv ourselves (auto-detect separator) and pass it as a
  # data.frame to setScenario, which bypasses PIK's separator heuristic in
  # gms::setScenario that breaks on comma-separated overlay files.
  if ("overlay" %in% names(scenario_config)) {
    overlay_name <- row[["overlay"]]
    if (!is.na(overlay_name) && nzchar(overlay_name)) {
      if (!file.exists(overlays_csv)) {
        stop("[", project, "] overlay '", overlay_name,
             "' requested but overlays.csv not found at: ", overlays_csv)
      }
      overlays_df <- read_csv_auto(overlays_csv,
                                   colClasses  = "character",
                                   check.names = FALSE)
      rownames(overlays_df) <- overlays_df[[1]]
      overlays_df <- overlays_df[, -1, drop = FALSE]
      cfg <- setScenario(cfg, overlay_name, scenario_config = overlays_df)
    }
  }

  message("\nApply ", project, " project settings on config:")

  # Helper: PIK-style "Update setting" log. Prints only if the value changes.
  apply_gms <- function(cfg, key, val) {
    old <- cfg$gms[[key]]
    cfg$gms[[key]] <- val
    if (is.null(old) || as.character(old) != as.character(val)) {
      message("  Update setting | gms$", key, ":",
              ifelse(is.null(old), "NULL", as.character(old)), " -> ", val)
    }
    cfg
  }

  # Project-specific column 'no_ghgprices_land_until' -> c56_mute_ghgprices_until
  # (skipped silently if a future project lacks this column)
  if ("no_ghgprices_land_until" %in% names(scenario_config) &&
      !is.na(row[["no_ghgprices_land_until"]]) &&
      nzchar(row[["no_ghgprices_land_until"]])) {
    cfg <- apply_gms(cfg, "c56_mute_ghgprices_until", row[["no_ghgprices_land_until"]])
  }

  # Generic loop for cfg_mag$gms$<key> columns
  for (i in seq_len(ncol(scenario_config))) {
    param <- names(scenario_config)[i]
    if (grepl("^cfg_mag", param)) {
      pname <- sub("^cfg_mag.gms.", "", param)
      val   <- row[[i]]
      if (!is.na(val) && val != "") cfg <- apply_gms(cfg, pname, val)
    }
  }
  message("uptake project settings applied.\n")

  cfg$title <- subscenario

} else {
  # ====================================================================
  # Default mode (c): no project-driven assembly, use magpie defaults
  # ====================================================================
  cfg$title <- "default"
}

# ----------------------------------------------------------------------
# OPENPROM_COUPLING_* channel (only active under task 7 trigger)
# ----------------------------------------------------------------------
openprom_mif      <- Sys.getenv("OPENPROM_COUPLING_MIF",       unset = "")
openprom_scenario <- Sys.getenv("OPENPROM_COUPLING_SCENARIO",  unset = subscenario)
openprom_ghg      <- Sys.getenv("OPENPROM_COUPLING_GHG",       unset = "on")
openprom_bio      <- Sys.getenv("OPENPROM_COUPLING_BIOENERGY", unset = "on")
if (nzchar(openprom_mif)) {
  message(sprintf("[openprom-coupling] using mif: %s (scenario=%s, ghg=%s, bio=%s)",
                  openprom_mif, openprom_scenario, openprom_ghg, openprom_bio))
  if (tolower(openprom_ghg) == "on") {
    cfg$path_to_report_ghgprices <- openprom_mif
    cfg$gms$c56_pollutant_prices <- "coupling"
  }
  if (tolower(openprom_bio) == "on") {
    cfg$path_to_report_bioenergy <- openprom_mif
    cfg$gms$c60_2ndgen_biodem    <- "coupling"
  }
}

start_run(cfg = cfg, codeCheck = FALSE)
