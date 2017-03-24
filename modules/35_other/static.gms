*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/35_other/static/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/35_other/static/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/35_other/static/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/35_other/static/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/35_other/static/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
