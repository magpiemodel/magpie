*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the aug17 realization, inputs are taken into the module and are directly 
*' delivered to the modules that require the data.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/09_drivers/aug17/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/09_drivers/aug17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/09_drivers/aug17/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/09_drivers/aug17/preloop.gms"
*######################## R SECTION END (PHASES) ###############################
