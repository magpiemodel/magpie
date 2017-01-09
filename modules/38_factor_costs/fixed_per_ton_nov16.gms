*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/38_factor_costs/fixed_per_ton_nov16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/38_factor_costs/fixed_per_ton_nov16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/38_factor_costs/fixed_per_ton_nov16/equations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/38_factor_costs/fixed_per_ton_nov16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/38_factor_costs/fixed_per_ton_nov16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
