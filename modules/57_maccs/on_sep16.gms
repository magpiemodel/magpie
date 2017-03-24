*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/57_maccs/on_sep16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/57_maccs/on_sep16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/57_maccs/on_sep16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/57_maccs/on_sep16/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/57_maccs/on_sep16/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/57_maccs/on_sep16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
