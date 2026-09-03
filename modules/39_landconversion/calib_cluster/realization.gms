*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' This realization extends the `calib` realization with two additional
*' capabilities:
*'
*' 1. **Cluster-level calibration:** For countries listed in `policy_countries39`
*'    (default: BRA), land conversion costs are calibrated at the cluster level
*'    rather than the regional level, enabling better spatial resolution within
*'    heterogeneous countries.
*'
*' 2. **Independent pasture calibration:** Pasture expansion costs are
*'    calibrated with a separate factor (`f39_calib_past` at regional level,
*'    `f39_calib_past_cluster` at cluster level), independent of the cropland
*'    calibration factor. This allows pasture dynamics to be calibrated to
*'    historic data without affecting cropland costs.
*'
*' For countries not in `policy_countries39`, behaviour is identical to `calib`.
*' For selected countries, cluster-level calibration overrides the regional
*' value for both cropland and pasture. Clusters with no cluster-level data
*' fall back to the regional calibration value.
*'
*' @limitations Data availability for land conversion costs is very limited.
*' Cluster-level calibration files must be prepared externally.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/39_landconversion/calib_cluster/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/39_landconversion/calib_cluster/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/39_landconversion/calib_cluster/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/39_landconversion/calib_cluster/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/39_landconversion/calib_cluster/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/39_landconversion/calib_cluster/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/39_landconversion/calib_cluster/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/39_landconversion/calib_cluster/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
