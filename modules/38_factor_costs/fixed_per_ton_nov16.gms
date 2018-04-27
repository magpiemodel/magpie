*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description The fixed_per_ton factor costs realization relates
*' factor costs to volume of production.
*' The latter depends on area harvested and yields.
*' By implication, in this implementation factor costs
*' purely depend on the volume of production, giving no incentive to
*' concentrate production on high-productive cells
*' @limitations This realization assumes that within a region,factor costs,
*' purely depend on the production and are independent of the area under production.
*' Cases in which the area under production significantly could influence
*' factors costs are hardly considered.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/38_factor_costs/fixed_per_ton_nov16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/38_factor_costs/fixed_per_ton_nov16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/38_factor_costs/fixed_per_ton_nov16/equations.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/38_factor_costs/fixed_per_ton_nov16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
