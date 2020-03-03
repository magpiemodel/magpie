*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization sets the demand for inorganic fertilizer and associated costs to zero.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/50_nr_soil_budget/off/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/50_nr_soil_budget/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/50_nr_soil_budget/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
