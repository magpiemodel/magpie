*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization calculates the nitrogen balance for crop land and pasture land
*' using exogenous uptake efficiencies. Several scenarios are available for the efficiency.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/50_nr_soil_budget/macceff_aug22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/50_nr_soil_budget/macceff_aug22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/50_nr_soil_budget/macceff_aug22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/50_nr_soil_budget/macceff_aug22/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/50_nr_soil_budget/macceff_aug22/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/50_nr_soil_budget/macceff_aug22/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/50_nr_soil_budget/macceff_aug22/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/50_nr_soil_budget/macceff_aug22/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
