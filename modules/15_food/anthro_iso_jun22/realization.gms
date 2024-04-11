*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/15_food/anthro_iso_jun22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/15_food/anthro_iso_jun22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/15_food/anthro_iso_jun22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/15_food/anthro_iso_jun22/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/15_food/anthro_iso_jun22/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/15_food/anthro_iso_jun22/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/15_food/anthro_iso_jun22/presolve.gms"
$Ifi "%phase%" == "intersolve" $include "./modules/15_food/anthro_iso_jun22/intersolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/15_food/anthro_iso_jun22/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################

*' @description
*' This realization uses per capita income and the demography of the
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
*' The model is described in [@bodirsky_starved_nodate].
*'
*' ![Execution order](food_demand_coupling.png){ width=60% }
*'
*' The model also includes a number of switches that allow for exogenous
*' diet scenarios, most importantly the shift to the Planetary Health diet
*' [@willett_food_2019].
*'
*' @authors Benjamin Leon Bodirsky, Isabelle Weindl, Felicitas Beier, Jan Philipp Dietrich
