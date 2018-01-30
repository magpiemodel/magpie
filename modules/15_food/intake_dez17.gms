*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/15_food/intake_dez17/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/15_food/intake_dez17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/15_food/intake_dez17/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/15_food/intake_dez17/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/15_food/intake_dez17/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/15_food/intake_dez17/presolve.gms"
$Ifi "%phase%" == "intersolve" $include "./modules/15_food/intake_dez17/intersolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/15_food/intake_dez17/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
