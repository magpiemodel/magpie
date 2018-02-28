
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/38_factor_costs/fixed_per_ton_mar18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/38_factor_costs/fixed_per_ton_mar18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/38_factor_costs/fixed_per_ton_mar18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/38_factor_costs/fixed_per_ton_mar18/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/38_factor_costs/fixed_per_ton_mar18/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/38_factor_costs/fixed_per_ton_mar18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/38_factor_costs/fixed_per_ton_mar18/presolve.gms"
$Ifi "%phase%" == "solve" $include "./modules/38_factor_costs/fixed_per_ton_mar18/solve.gms"
$Ifi "%phase%" == "intersolve" $include "./modules/38_factor_costs/fixed_per_ton_mar18/intersolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/38_factor_costs/fixed_per_ton_mar18/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/38_factor_costs/fixed_per_ton_mar18/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/38_factor_costs/fixed_per_ton_mar18/nl_release.gms"
$Ifi "%phase%" == "nl_relax" $include "./modules/38_factor_costs/fixed_per_ton_mar18/nl_relax.gms"
*######################## R SECTION END (PHASES) ###############################
