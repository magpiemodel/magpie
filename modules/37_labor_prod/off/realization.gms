*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization labor productivity is fixed to a value of 1, 
*' which implies no change over time. 
*'
*' @limitations The impacts of changing environmental conditions on labor productivity 
*' are not accounted for.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/37_labor_prod/off/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/37_labor_prod/off/preloop.gms"
*######################## R SECTION END (PHASES) ###############################
