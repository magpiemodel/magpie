*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/60_bioenergy/bioenergyspecialized_nov17/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/60_bioenergy/bioenergyspecialized_nov17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/60_bioenergy/bioenergyspecialized_nov17/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/60_bioenergy/bioenergyspecialized_nov17/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/60_bioenergy/bioenergyspecialized_nov17/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/60_bioenergy/bioenergyspecialized_nov17/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/60_bioenergy/bioenergyspecialized_nov17/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
