*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/33_forest/endo_threshold_aug15/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/33_forest/endo_threshold_aug15/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/33_forest/endo_threshold_aug15/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/33_forest/endo_threshold_aug15/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/33_forest/endo_threshold_aug15/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/33_forest/endo_threshold_aug15/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/33_forest/endo_threshold_aug15/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
