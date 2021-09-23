*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' In this realization, per hectare land conversion costs are separated into 
*' costs for expansion of cropland, pasture and forestry (establishment costs) and 
*' costs for clearing of primary forest, secondary forest and other natural land (clearing costs).
*' By default, we assume a global cost factor of 8000 USD/ha (static over time) 
*' for establishment of cropland and pasture, and 1000 USD/ha for forestry land.
*' By default, clearing of natural vegetation is not priced. Plausible values range 
*' between 0-5 USD/tC (based on @kreidenweis_pasture_2018). 
*'
*' @limitations Data availability for land conversion costs is very limited.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/39_landconversion/global_static_aug18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/39_landconversion/global_static_aug18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/39_landconversion/global_static_aug18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/39_landconversion/global_static_aug18/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/39_landconversion/global_static_aug18/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/39_landconversion/global_static_aug18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/39_landconversion/global_static_aug18/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/39_landconversion/global_static_aug18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
