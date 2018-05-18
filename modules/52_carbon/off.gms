*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization
*' annual land-related CO2 emissions are assumed zero.

*' @limitations CO2 emissions are assumed zero

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/52_carbon/off/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/52_carbon/off/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/52_carbon/off/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/52_carbon/off/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/52_carbon/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
