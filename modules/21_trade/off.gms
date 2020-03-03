*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization, there is no agricultural trade, i.e. regions
*' are fully self-sufficient and dependent on domestic production.

*' @limitations This realization does not account for current trends in agricultural trade.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/off/declarations.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/off/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
