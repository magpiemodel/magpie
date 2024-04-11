*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' In this realization the model is solved directly using nonlinear optimization.
*' If the optimization returns an infeasible solution the solve is repeated,
*' either until a feasible solution is found or the maximum number of iterations
*' as defined in `s80_maxiter` is reached.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/80_optimization/nlp_apr17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/80_optimization/nlp_apr17/input.gms"
$Ifi "%phase%" == "solve" $include "./modules/80_optimization/nlp_apr17/solve.gms"
*######################## R SECTION END (PHASES) ###############################
