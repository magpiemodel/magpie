*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
