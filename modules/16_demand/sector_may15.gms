*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In the sector_may15 realization, demand is calculated as the sum of
*' demand for all products coming from the modules [62_material],
*' [60_bioenergy], [70_livestock], [15_food] and [17_production].
*' It also delivers data to the modules [60_bioenergy], [21_trade], [20_processing],
*' [18_residues], [55_awms], [50_nr_soil_budget], [32_forestry], and [53_methane].


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/16_demand/sector_may15/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/16_demand/sector_may15/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/16_demand/sector_may15/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/16_demand/sector_may15/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/16_demand/sector_may15/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/16_demand/sector_may15/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
