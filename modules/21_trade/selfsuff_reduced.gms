
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/21_trade/selfsuff_reduced/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/selfsuff_reduced/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/21_trade/selfsuff_reduced/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/selfsuff_reduced/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/selfsuff_reduced/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/selfsuff_reduced/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
