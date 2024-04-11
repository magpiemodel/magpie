*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
*' while self-sufficiencies greater than one indicate that the region produces for export. 

*' This realization uses world-region-level bilateral trade margins and tariffs for traded goods.
*'
*' ![Implementation of trade.](trade_pools.png){ width=100% }

*' @limitations This realization depends on predetermined self-sufficiency rates and export shares,
*' which leads to a relative fixed trade pattern. Bilateral trade happens within the above, based on bilateral tariffs and margins.
*' Other notable difference from selfsuff_reduced is that bilateral margins are now defined over regions (as these are transport costs)
*' as opposed to super-regions (which delimit free trade zones or similar large regions)

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/21_trade/selfsuff_reduced_bilateral22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/selfsuff_reduced_bilateral22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/21_trade/selfsuff_reduced_bilateral22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/selfsuff_reduced_bilateral22/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/21_trade/selfsuff_reduced_bilateral22/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/selfsuff_reduced_bilateral22/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/selfsuff_reduced_bilateral22/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
