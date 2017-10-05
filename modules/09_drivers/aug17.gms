
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/09_drivers/aug17/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/09_drivers/aug17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/09_drivers/aug17/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/09_drivers/aug17/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/09_drivers/aug17/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/09_drivers/aug17/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/09_drivers/aug17/presolve.gms"
$Ifi "%phase%" == "solve" $include "./modules/09_drivers/aug17/solve.gms"
$Ifi "%phase%" == "intersolve" $include "./modules/09_drivers/aug17/intersolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/09_drivers/aug17/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/09_drivers/aug17/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/09_drivers/aug17/nl_release.gms"
$Ifi "%phase%" == "nl_relax" $include "./modules/09_drivers/aug17/nl_relax.gms"
*######################## R SECTION END (PHASES) ###############################
