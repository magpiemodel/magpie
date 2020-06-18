*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization relates factor costs to volume of production of
*' a given crop. The latter [17_production] depends on area harvested
*' from [30_crop] and yields from [14_yields]. In other words, in this
*' implementation, factor costs entirely depend on the volume of production.
*' As such, there are no incentives to allocate and concentrate production
*' into more productive cells.

*' @limitations This realization assumes that factor costs, within a region,
*' purely depend on the production and are independent of the area under cultivation.
*' By implication, cases in which the harvested area could significantly influence
*' factors costs are hardly accounted in this realization.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/38_factor_costs/sticky_performance_Jun18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/38_factor_costs/sticky_performance_Jun18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/38_factor_costs/sticky_performance_Jun18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/38_factor_costs/sticky_performance_Jun18/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/38_factor_costs/sticky_performance_Jun18/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/38_factor_costs/sticky_performance_Jun18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/38_factor_costs/sticky_performance_Jun18/presolve.gms"
$Ifi "%phase%" == "solve" $include "./modules/38_factor_costs/sticky_performance_Jun18/solve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/38_factor_costs/sticky_performance_Jun18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
