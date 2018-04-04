*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization an approach is used which was initially
*' suggested by Todd Munson. Instead of directly starting the nonlinear solve,
*' a linear version of the model is solved beforehand. In order to linearize
*' all model nonlinear terms are fixed to best guesses for the respective values.
*' After linear optimization the nonlinear optimization is run.
*'  

*' @limitations This realization requires that all used module realizations with
*' nonlinear terms provide a nl_fix.gms and nl_release.gms which fix and release
*' the nonlinear terms. If this is missing and there are still active nonlinear
*' terms in the linear solve attempt the model will be stopped with an error.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/80_optimization/lp_nlp_apr17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/80_optimization/lp_nlp_apr17/input.gms"
$Ifi "%phase%" == "solve" $include "./modules/80_optimization/lp_nlp_apr17/solve.gms"
*######################## R SECTION END (PHASES) ###############################
