
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/20_processing/coupleproducts_feb17/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/20_processing/coupleproducts_feb17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/20_processing/coupleproducts_feb17/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/20_processing/coupleproducts_feb17/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/20_processing/coupleproducts_feb17/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/20_processing/coupleproducts_feb17/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/20_processing/coupleproducts_feb17/presolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/20_processing/coupleproducts_feb17/nl_fix.gms"
$Ifi "%phase%" == "l_solve" $include "./modules/20_processing/coupleproducts_feb17/l_solve.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/20_processing/coupleproducts_feb17/nl_release.gms"
$Ifi "%phase%" == "nl_relax" $include "./modules/20_processing/coupleproducts_feb17/nl_relax.gms"
$Ifi "%phase%" == "nl_solve" $include "./modules/20_processing/coupleproducts_feb17/nl_solve.gms"
$Ifi "%phase%" == "intersolve" $include "./modules/20_processing/coupleproducts_feb17/intersolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/20_processing/coupleproducts_feb17/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
