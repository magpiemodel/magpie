
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/15_food/anthropometrics_jan18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/15_food/anthropometrics_jan18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/15_food/anthropometrics_jan18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/15_food/anthropometrics_jan18/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/15_food/anthropometrics_jan18/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/15_food/anthropometrics_jan18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/15_food/anthropometrics_jan18/presolve.gms"
$Ifi "%phase%" == "solve" $include "./modules/15_food/anthropometrics_jan18/solve.gms"
$Ifi "%phase%" == "intersolve" $include "./modules/15_food/anthropometrics_jan18/intersolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/15_food/anthropometrics_jan18/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/15_food/anthropometrics_jan18/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/15_food/anthropometrics_jan18/nl_release.gms"
$Ifi "%phase%" == "nl_relax" $include "./modules/15_food/anthropometrics_jan18/nl_relax.gms"
*######################## R SECTION END (PHASES) ###############################
