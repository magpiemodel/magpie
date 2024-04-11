*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description  In this realization, agricultural trade is fully liberalized in all timesteps. 

*' @limitations This realization does not account for current trends in agricultural trade.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/21_trade/free_apr16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/free_apr16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/21_trade/free_apr16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/free_apr16/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/free_apr16/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/free_apr16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
