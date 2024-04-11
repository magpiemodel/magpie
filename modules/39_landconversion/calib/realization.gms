*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' This realization accounts for land conversion costs of cropland, pasture, forestry and urban land. 
*' Costs for expansion of pasture, forestry and urban land are global and static over time.
*' For cropland, a regional and time-dependent calibration factor is applied on 
*' global costs for land expansion, complemented by a reward for cropland reduction in selected regions, 
*' for a better match of regional cropland in 2015 with historic data.
*' The calibration factor for costs of cropland expansion is lifted to a minium of 1 in all regions by 2050.
*'
*' @limitations Data availability for land conversion costs is very limited.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/39_landconversion/calib/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/39_landconversion/calib/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/39_landconversion/calib/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/39_landconversion/calib/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/39_landconversion/calib/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/39_landconversion/calib/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/39_landconversion/calib/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/39_landconversion/calib/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
