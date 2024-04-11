*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The off realization does not account for any further restriction of the livestock distribution. 

*' @limitations This realization underestimates real world drivers for livestock distribution.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/71_disagg_lvst/off/declarations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/71_disagg_lvst/off/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/71_disagg_lvst/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
