*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In the exo_flexreg_apr16 realisation, Demand for material usage
*' is calculated based on Historical material demand or Historical material demand
*' combined with the relationship to food demand calculated by `vm_dem_food` interface
*' in food module [15_food]. Observed material demand is fed as an exogenous input to
*' the module based on historical data.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/62_material/exo_flexreg_apr16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/62_material/exo_flexreg_apr16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/62_material/exo_flexreg_apr16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/62_material/exo_flexreg_apr16/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/62_material/exo_flexreg_apr16/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/62_material/exo_flexreg_apr16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/62_material/exo_flexreg_apr16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
