*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description Within this realization, there are two ways for a region to fulfill
*' its demand for agricultural products: a self-sufficiency pool based on
*' historical region specific trade patterns, and a comparative advantage pool
*' based on most cost-efficient production.

*' In the self-sufficiency pool, regional self-sufficiency ratios `f21_self_suff_seedred_1995(i,k)` defines
*' how much of the demand of each region `i` for each traded goods `k_trade` has to be met by domestic production.
*' Self sufficiency ratios smaller than one indicate that the region imports from the world market,
*' while self-sufficiencies greater than one indicate that the region produces for export. Trade costs,
*' inlucding trade margins and tariffs, are considered.
*'
*' ![Implementation of trade.](trade_pools.png){ width=100% }

*' @limitations This realization depends on predetermined self-sufficiency rates and export shares,
*' which leads to a relative fixed trade pattern.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/21_trade/selfsuff_reduced_test/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/selfsuff_reduced_test/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/21_trade/selfsuff_reduced_test/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/selfsuff_reduced_test/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/21_trade/selfsuff_reduced_test/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/selfsuff_reduced_test/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/selfsuff_reduced_test/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
