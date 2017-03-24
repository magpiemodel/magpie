*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/50_nr_soil_budget/off/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/50_nr_soil_budget/off/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/50_nr_soil_budget/off/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/50_nr_soil_budget/off/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/50_nr_soil_budget/off/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/50_nr_soil_budget/off/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/50_nr_soil_budget/off/presolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/50_nr_soil_budget/off/nl_fix.gms"
$Ifi "%phase%" == "l_solve" $include "./modules/50_nr_soil_budget/off/l_solve.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/50_nr_soil_budget/off/nl_release.gms"
$Ifi "%phase%" == "nl_relax" $include "./modules/50_nr_soil_budget/off/nl_relax.gms"
$Ifi "%phase%" == "nl_solve" $include "./modules/50_nr_soil_budget/off/nl_solve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/50_nr_soil_budget/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
