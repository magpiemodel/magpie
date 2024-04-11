*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' In the exo_flexreg_apr16 realisation, demand for material usage
*' is estimated to grow proportional to food demand calculated by `vm_dem_food` interface
*' in food module([15_food]). Observed material demand is fed as an input to the
*' material module based on historical data. The assumption that material demand
*' grows proportional to food demand is a simplification that can be justified
*' by the minor importance of non-bioenergy material usage of agricultural products.
*' In addition, biomass demand for bioplastic production is included, with 
*' future bioplastic production kept constant or following a logistic curve 
*' if a bioplastic production target is exogenously set.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/62_material/exo_flexreg_apr16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/62_material/exo_flexreg_apr16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/62_material/exo_flexreg_apr16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/62_material/exo_flexreg_apr16/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/62_material/exo_flexreg_apr16/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/62_material/exo_flexreg_apr16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/62_material/exo_flexreg_apr16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################

