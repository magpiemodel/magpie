*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization is based on sticky_feb18, but in addition includes a 
*' CES production function, which accounts for climate change impacts on labor productivity
*' provided by [37_labor_prod], and wage increase impact on labor productivity based on 
*' wages in [36_employment]. 
*' The main goal of this realization is to improve crop patterns at different spatial
*' scales. Specifically, the goal is reached by reducing capital relocation flexibility between
*' crop types. In the "sticky" realization, the factor costs are separated into variable labor cost and
*' capital investment cost. Then, capital is further divided into immobile and mobile, where
*' mobility is defined between crops. In this way, changes in cropland are favored in locations
*' with existing capital stocks. 

*' @limitations This realization assumes that factor costs, within a region,
*' purely depend on the production and are independent of the area under cultivation.
*' By implication, cases in which the harvested area could significantly influence
*' factors costs are hardly accounted in this realization.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/38_factor_costs/sticky_labor/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/38_factor_costs/sticky_labor/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/38_factor_costs/sticky_labor/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/38_factor_costs/sticky_labor/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/38_factor_costs/sticky_labor/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/38_factor_costs/sticky_labor/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/38_factor_costs/sticky_labor/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/38_factor_costs/sticky_labor/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/38_factor_costs/sticky_labor/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/38_factor_costs/sticky_labor/nl_release.gms"
$Ifi "%phase%" == "nl_relax" $include "./modules/38_factor_costs/sticky_labor/nl_relax.gms"
*######################## R SECTION END (PHASES) ###############################
