*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' This realization accounts for costs of land expansion 
*' (cropland, pasture and forestry) and a reward for cropland reduction.
*' Global cost for cropland expansion (10000 USD/ha as default) are scaled with a regional and time-dependent calibration factor  
*' for a better match of regional cropland in 2015 with historic data. In addition, a reward on cropland reduction 
*' is applied in selected regions for matching reductions in cropland between 1995 and 2015.
*' The calibration factor is faded out until 2050.
*' Default land conversion costs for expansion of pasture and forestry are 
*' 8000 and 1000 USD/ha (global and static over time), respectively. 
*'
*' @limitations Data availability for land conversion costs is very limited.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/39_landconversion/devstate/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/39_landconversion/devstate/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/39_landconversion/devstate/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/39_landconversion/devstate/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/39_landconversion/devstate/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/39_landconversion/devstate/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/39_landconversion/devstate/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/39_landconversion/devstate/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
