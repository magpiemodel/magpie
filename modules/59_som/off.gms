*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization does not track soil organic matter turnover.

*' @limitations The release of nitrogen due to soil organic matter loss is not calculated. 

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/59_som/off/declarations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/59_som/off/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/59_som/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
