*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/55_awms/off/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/55_awms/off/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/55_awms/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/55_awms/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
