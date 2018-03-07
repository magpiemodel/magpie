
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/39_landconversion/gdp_vegetation_dev/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/39_landconversion/gdp_vegetation_dev/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/39_landconversion/gdp_vegetation_dev/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/39_landconversion/gdp_vegetation_dev/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/39_landconversion/gdp_vegetation_dev/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/39_landconversion/gdp_vegetation_dev/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/39_landconversion/gdp_vegetation_dev/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
