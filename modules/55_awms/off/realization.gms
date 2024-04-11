*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/55_awms/off/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/55_awms/off/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/55_awms/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/55_awms/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
