*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' In this realization the model is solved directly using nonlinear optimization.
*' However, the regions are solved in parallel. This allows to use higher spatial
*' resolution, but works only with fixed trade patterns (exo trade realization).
*' To derive these trade patterns a normal run with global optimization is needed.
*' The start script highres.R illustrates how this can be used.
*' If the optimization returns an infeasible solution the solve is repeated,
*' either until a feasible solution is found or the maximum number of iterations
*' as defined in `s80_maxiter` is reached.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/80_optimization/nlp_par/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/80_optimization/nlp_par/input.gms"
$Ifi "%phase%" == "solve" $include "./modules/80_optimization/nlp_par/solve.gms"
*######################## R SECTION END (PHASES) ###############################
