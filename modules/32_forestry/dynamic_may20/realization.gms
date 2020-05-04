*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description dynamic_nov19 realization builds up of the affore_vegc_dec16 realization
*' and additionally handles the production of two timber products from plantation
*' forests while still accounting for afforestation policies. This realization
*' harvests timber from available plantations to meet a portion of overall timber
*' demand. The model is free to decide the amount of production coming from plantations.
*' New plantations are also established in the simulation step to account for future
*' timber demand and trade.

*' @limitations

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/32_forestry/dynamic_may20/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/32_forestry/dynamic_may20/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/32_forestry/dynamic_may20/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/32_forestry/dynamic_may20/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/32_forestry/dynamic_may20/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/32_forestry/dynamic_may20/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/32_forestry/dynamic_may20/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/32_forestry/dynamic_may20/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
