*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization, future shares of tree cover and bioenergy trees 
*' on cropland at cluster level follow exogenous assumptions. 
*' @stop
*'
*' @limitations There are currently no known limitations of this realization.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/61_agroforestry/exo/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/61_agroforestry/exo/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/61_agroforestry/exo/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/61_agroforestry/exo/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/61_agroforestry/exo/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/61_agroforestry/exo/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
