*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/18_residues/off/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/18_residues/off/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/18_residues/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/18_residues/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
