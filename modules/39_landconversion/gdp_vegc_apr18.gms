
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/39_landconversion/gdp_vegc_apr18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/39_landconversion/gdp_vegc_apr18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/39_landconversion/gdp_vegc_apr18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/39_landconversion/gdp_vegc_apr18/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/39_landconversion/gdp_vegc_apr18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/39_landconversion/gdp_vegc_apr18/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/39_landconversion/gdp_vegc_apr18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
