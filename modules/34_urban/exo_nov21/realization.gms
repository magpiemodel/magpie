*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description Urban Land based on LUH2v2 (Hurtt 2020) cellular (0.5 degree) input dataset, varying with SSP. 
*' Cellular level is prescribed via a very high punishment term for deviating from original input values.
*' Regional sums of urban land must add be equal for both model and input data.

*' @limitations Urban land is exogenous and does not interact with other model dynamics, except for reducing available non-urban land pool.
*'  Cellular urban land may not exactly match input data due to other land needs in the same cell.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/34_urban/exo_nov21/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/34_urban/exo_nov21/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/34_urban/exo_nov21/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/34_urban/exo_nov21/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/34_urban/exo_nov21/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/34_urban/exo_nov21/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/34_urban/exo_nov21/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/34_urban/exo_nov21/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
