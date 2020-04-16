*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description Unlike the previous realization, this implementation allows for the possibility
*' that non-CO2 emissions can be reduced by technical mitigation at additional costs.
*'
*' @limitations There are still issues related to data quality used by our source.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/57_maccs/on_sep16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/57_maccs/on_sep16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/57_maccs/on_sep16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/57_maccs/on_sep16/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/57_maccs/on_sep16/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/57_maccs/on_sep16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
