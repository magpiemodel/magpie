*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/62_material/exo_flexreg_apr16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/62_material/exo_flexreg_apr16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/62_material/exo_flexreg_apr16/input.gms"
$Ifi "%phase%" == "presolve" $include "./modules/62_material/exo_flexreg_apr16/presolve.gms"
*######################## R SECTION END (PHASES) ###############################
