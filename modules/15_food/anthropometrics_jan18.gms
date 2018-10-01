
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

*' @description
*' The realization anthropometrics_jan18
*' uses per capita income and the demography of the
*' world population (including sex and age classes at the country level,
*' which are provided from module [09_drivers]) as drivers.
*' The module estimates food demand on iso-country level taking
*' anthropometric food requirements as well as economic dynamics into account.
*' If flexible demand is activated, the module also uses the shadow prices
*' for agircultural products from the optimization, which are the Lagrange
*' multipliers of the constraint `q15_food_demand`.
*' The module consists of a standalone food demand model, which is executed
*' before MAgPIE starts. In the case of endogenous demand, the module is
*' iterated with MAgPIE.
*' Besides providing the fooduse of agricultural products, the model also
*' provides a number of output indicators, including the BMI distribution,
*' body weight and height of the population by age and sex, food intake by
*' age group and sex, food waste, dietary composition between livestock products,
*' empty calories (sugar, oil and alcohol), fruits vegetables and nuts, as well
*' as staple calories.
*' The food demand model can be run in standalone mode by running the
*' the file `standalone/demand_model.gms`.
*'
*' @authors Benjamin Leon Bodirsky, Jan Philipp Dietrich
