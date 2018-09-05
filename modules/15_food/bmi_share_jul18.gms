*' @description
*' The module BMI-share
*' uses as drivers the per-capita income and the demography of the
*' world population, including sex and age classes on country level,
*' which are provided from module [09_drivers].
*' The model estimates food demand on iso-country level taking into account
*' anthropometric food requirements as well as economic dynamics.
*' If flexible demand is activated, the module also uses the shadow prices from
*' the optimization, which are the la-grange multipliers of the constraint
*' q15_food_demand.
*' The module consists of a standalone food demand model, which is executed
*' before MAgPIE starts. In the case of endogenous demand, the module is
*' iterated with MAgPIE.
*' Besides providing the fooduse of agricultural products, the model also
*' provides a number of output indicators, including food intake by age-group
*' and sex, food waste, dietary composition between livestock products,
*' empty calories (sugar, oil and alcohol), fruits vegetables and nuts, as well
*' as staples. Finally, it provides anthropometric indicators such as
*' body height, body weight and BMI by age-class and gender.
*' The food demand model can be run in standalone mode by running the
*' the file standalone/demand_model.gms
*'
*' In contrast to the anthropometrics module, it does not only estimate the
*' mean BMI of a country, but the BMI distribution as population shares.
*'
*' @authors Benjamin Leon Bodirsky, Jan Philipp Dietrich


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/15_food/bmi_share_jul18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/15_food/bmi_share_jul18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/15_food/bmi_share_jul18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/15_food/bmi_share_jul18/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/15_food/bmi_share_jul18/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/15_food/bmi_share_jul18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/15_food/bmi_share_jul18/presolve.gms"
$Ifi "%phase%" == "solve" $include "./modules/15_food/bmi_share_jul18/solve.gms"
$Ifi "%phase%" == "intersolve" $include "./modules/15_food/bmi_share_jul18/intersolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/15_food/bmi_share_jul18/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/15_food/bmi_share_jul18/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/15_food/bmi_share_jul18/nl_release.gms"
$Ifi "%phase%" == "nl_relax" $include "./modules/15_food/bmi_share_jul18/nl_relax.gms"
*######################## R SECTION END (PHASES) ###############################