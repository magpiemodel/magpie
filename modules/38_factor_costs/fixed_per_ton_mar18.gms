*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description The fixed_per_ton factor costs realization relates
*' factor costs to volume of production of a given crop.
*' The latter ([17_production]) depends on area harvested ([30_crop]) and yields ([14_yields]).
*' In other words, in this implementation/realization, factor costs
*' entirely depend on the volume of production.
*' As such, in this realization, there no incentives to allocate and concentrate production 
*' into high-productive cells.


*' @limitations This realization assumes that within a region,factor costs,
*' purely depend on the production and are independent of the area under production.
*' Cases in which the area under production significantly could influence
*' factors costs are hardly accounted.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/38_factor_costs/fixed_per_ton_mar18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/38_factor_costs/fixed_per_ton_mar18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/38_factor_costs/fixed_per_ton_mar18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/38_factor_costs/fixed_per_ton_mar18/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/38_factor_costs/fixed_per_ton_mar18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/38_factor_costs/fixed_per_ton_mar18/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/38_factor_costs/fixed_per_ton_mar18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
