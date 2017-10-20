*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/31_past/static/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/31_past/static/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/31_past/static/equations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/31_past/static/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/31_past/static/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
