*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description The off realization does not account for any further restriction of the livestock distribution. 

*' @limitations This realization underestimates real world drivers for livestock distribution.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/71_disagg_lvst/off/declarations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/71_disagg_lvst/off/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/71_disagg_lvst/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
