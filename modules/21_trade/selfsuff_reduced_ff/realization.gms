*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization accounts for future forestry trade and future resultant
*' demand after trade to enable optimum plantation establishments in current time step.
*' This realization covers all the dynamics from selfsuff_reduced realization as well.

*' @limitations This realization depends on predetermined self-sufficiency rates and export shares,
*' which leads to a relative fixed trade pattern.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/21_trade/selfsuff_reduced_ff/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/selfsuff_reduced_ff/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/21_trade/selfsuff_reduced_ff/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/selfsuff_reduced_ff/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/selfsuff_reduced_ff/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/21_trade/selfsuff_reduced_ff/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/selfsuff_reduced_ff/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
