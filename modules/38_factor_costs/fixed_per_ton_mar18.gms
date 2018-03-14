
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/38_factor_costs/fixed_per_ton_mar18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/38_factor_costs/fixed_per_ton_mar18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/38_factor_costs/fixed_per_ton_mar18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/38_factor_costs/fixed_per_ton_mar18/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/38_factor_costs/fixed_per_ton_mar18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/38_factor_costs/fixed_per_ton_mar18/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/38_factor_costs/fixed_per_ton_mar18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
