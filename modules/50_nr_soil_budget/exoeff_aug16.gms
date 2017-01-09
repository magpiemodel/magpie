*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/50_nr_soil_budget/exoeff_aug16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/50_nr_soil_budget/exoeff_aug16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/50_nr_soil_budget/exoeff_aug16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/50_nr_soil_budget/exoeff_aug16/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/50_nr_soil_budget/exoeff_aug16/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/50_nr_soil_budget/exoeff_aug16/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/50_nr_soil_budget/exoeff_aug16/presolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/50_nr_soil_budget/exoeff_aug16/nl_fix.gms"
$Ifi "%phase%" == "l_solve" $include "./modules/50_nr_soil_budget/exoeff_aug16/l_solve.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/50_nr_soil_budget/exoeff_aug16/nl_release.gms"
$Ifi "%phase%" == "nl_relax" $include "./modules/50_nr_soil_budget/exoeff_aug16/nl_relax.gms"
$Ifi "%phase%" == "nl_solve" $include "./modules/50_nr_soil_budget/exoeff_aug16/nl_solve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/50_nr_soil_budget/exoeff_aug16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
