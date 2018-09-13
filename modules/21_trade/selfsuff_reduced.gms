*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description Within this realization, there are two ways for a region to fulfill
*' its demand for agricultural products: a self-sufficiency pool based on
*' historical region specific trade patterns, and a comparative advantage pool
*' based on most cost-efficient production.

*' In the self-sufficiency pool, regional self-sufficiency ratios `f21_self_suff_seedred_1995(i,k)` defines
*' how much of the demand of each region `i` for each traded goods `k_trade` has to be met by domestic production.
*' Self sufficiency ratios smaller than one indicate that the region imports from the world market,
*' while self-sufficiencies greater than one indicate that the region produces for export. Trade costs
*' are inlucding trade margins and tariffs are considered.
*'
*' ![Implementation of trade.](trade_pools.png){ width=100% }

*' @limitations This realization depends on predetermined self-sufficiency rates and export shares,
*' which leads to a relative fixed trade pattern.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/21_trade/selfsuff_reduced/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/selfsuff_reduced/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/21_trade/selfsuff_reduced/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/selfsuff_reduced/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/selfsuff_reduced/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/selfsuff_reduced/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
