*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description  In this realization, agricultural trade is fully liberalized in all timesteps. 

*' @limitations This realization does not account for current trends in agricultural trade.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/21_trade/free_apr16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/free_apr16/declarations.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/free_apr16/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/free_apr16/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/free_apr16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
