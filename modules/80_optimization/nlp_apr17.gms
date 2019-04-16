*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
