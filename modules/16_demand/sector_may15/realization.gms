*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
$Ifi "%phase%" == "postsolve" $include "./modules/16_demand/sector_may15/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
