*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/59_som/off/declarations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/59_som/off/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/59_som/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
