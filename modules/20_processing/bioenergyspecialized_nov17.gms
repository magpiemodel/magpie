
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/20_processing/bioenergyspecialized_nov17/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/20_processing/bioenergyspecialized_nov17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/20_processing/bioenergyspecialized_nov17/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/20_processing/bioenergyspecialized_nov17/equations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/20_processing/bioenergyspecialized_nov17/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/20_processing/bioenergyspecialized_nov17/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
