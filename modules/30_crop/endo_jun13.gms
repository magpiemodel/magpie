*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description The endo_jun13 realization calculates the crop specific agricultural land use endogenously 
*' based on yield data coming from [14_yields] the module and the rotational and suitability constrains stated in the input data of the module.
*' Cropland areas are linked to the crop specific production and the carbon content of the different land carbon pools.
*' The crop specific land use areas are also used in [18_residues], [38_factor_costs], [41_area_equipped_for_irrigation], 
*' [42_water_demand], [50_nr_soil_budget], [53_methane] and [59_som].

*' @limitations There are currently no known limitations of this realization.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/30_crop/endo_jun13/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/30_crop/endo_jun13/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/30_crop/endo_jun13/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/30_crop/endo_jun13/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/30_crop/endo_jun13/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/30_crop/endo_jun13/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/30_crop/endo_jun13/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
