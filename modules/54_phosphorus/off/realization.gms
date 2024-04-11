*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This is the current default implementation of the module.
*' It deactivates calculations related to the phosphorus module.

*' @limitations The realization is still under development.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/54_phosphorus/off/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/54_phosphorus/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/54_phosphorus/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
