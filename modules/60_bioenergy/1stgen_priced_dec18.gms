
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/60_bioenergy/1stgen_priced_dec18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/60_bioenergy/1stgen_priced_dec18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/60_bioenergy/1stgen_priced_dec18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/60_bioenergy/1stgen_priced_dec18/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/60_bioenergy/1stgen_priced_dec18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/60_bioenergy/1stgen_priced_dec18/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/60_bioenergy/1stgen_priced_dec18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
