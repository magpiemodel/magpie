*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Optimization
*'
*' @description This module takes care of the model optimization of
*' the main model, allowing for switching between optimization procedures.
*' It has been introduced to play with different ways to affect the runtime
*' performance of the model via more optimized model solution strategies.
*' The interfaces to the rest of the model are quite limited as it only requires
*' the variables to be optimized `vm_cost_glo` (total costs) and `vm_landdiff`
*' (gross land use changes compared to last time step) as direct input.
*' The latter was introduced to select out of a range of cost optimal patterns
*' that one which is closest to the pattern of the previous time step. While
*' CONOPT returns this solution by default, CPLEX does not.
*'
*' @authors Jan Philipp Dietrich, Todd Munson

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%optimization%" == "lp_nlp_apr17" $include "./modules/80_optimization/lp_nlp_apr17/realization.gms"
$Ifi "%optimization%" == "nlp_apr17" $include "./modules/80_optimization/nlp_apr17/realization.gms"
$Ifi "%optimization%" == "nlp_par" $include "./modules/80_optimization/nlp_par/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
