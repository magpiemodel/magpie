*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization calculates agricultural employment based
*' on it's relation to total labor costs. It therefore depends 
*' on the labor costs calculated in the modules [38_factor_costs], [57_maccs] and 
*' [70_livestock]. Resulting total costs and production patterns can be affected
*' if an external wage scenario is used, which increases labor costs for
*' crop and livestock production in [38_factor_costs] and [70_livestock], and
*' for mitigation in [57_maccs].

*' @limitations Labor availability is not seen as a limiting factor for
*' agricultural production, as the number of people employed is directly linked
*' to labor costs which scale with the amount of production. Furthermore, 
*' hourly labor costs are projected into the future based on a regression with 
*' GDP pc, while factor requirements for crops (i.e. labor + capital costs per 
*' production unit) are kept constant. This means, that the increase in the 
*' baseline wages over time is assumed to be matched by a corresponding increase
*' in labor productivity. For external wage scenarios that lead to higher wages
*' the additional wage increase can be either related to productivity increase
*' or higher total labor costs.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/36_employment/exo_may22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/36_employment/exo_may22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/36_employment/exo_may22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/36_employment/exo_may22/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/36_employment/exo_may22/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/36_employment/exo_may22/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/36_employment/exo_may22/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
