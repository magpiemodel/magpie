*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description This is the current default implementation of the module.
*' It deactivates calculations related to the phosphorus module.

*' @limitations The realization is still under development.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/54_phosphorus/off/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/54_phosphorus/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/54_phosphorus/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
