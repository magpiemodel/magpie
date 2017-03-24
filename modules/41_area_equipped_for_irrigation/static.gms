*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/41_area_equipped_for_irrigation/static/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/41_area_equipped_for_irrigation/static/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/41_area_equipped_for_irrigation/static/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/41_area_equipped_for_irrigation/static/scaling.gms"
$Ifi "%phase%" == "presolve" $include "./modules/41_area_equipped_for_irrigation/static/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/41_area_equipped_for_irrigation/static/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
