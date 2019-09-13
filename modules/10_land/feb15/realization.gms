*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @limitations This realization does not track sources and targets of land transitions.
*' Interface variables like vm_croplandexpansion and vm_croplandreduction
*' are therefore not meaningful.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/10_land/feb15/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/10_land/feb15/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/10_land/feb15/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/10_land/feb15/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/10_land/feb15/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/10_land/feb15/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/10_land/feb15/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
