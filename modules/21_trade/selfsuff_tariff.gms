
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/21_trade/selfsuff_tariff/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/selfsuff_tariff/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/21_trade/selfsuff_tariff/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/selfsuff_tariff/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/selfsuff_tariff/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/selfsuff_tariff/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
