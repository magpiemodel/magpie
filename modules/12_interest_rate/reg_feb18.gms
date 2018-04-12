
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/12_interest_rate/reg_feb18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/12_interest_rate/reg_feb18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/12_interest_rate/reg_feb18/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/12_interest_rate/reg_feb18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/12_interest_rate/reg_feb18/presolve.gms"
*######################## R SECTION END (PHASES) ###############################
