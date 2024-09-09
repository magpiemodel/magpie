*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization trade patterns defined by self-sufficiency ratios and export shares, 
*' together with regional demands, establish a baseline value for the production of traded products in the superregions. 
*' Production is then allowed to fluctuate freely within a band around this baseline value, 
*' only being enforced to maintain the condition of global production exceeding global demand.
*' The width of the production band is determined by the `i21_trade_bal_reduction` (ptb) factor.
*'
*' Effectively, this factor splits the global demand into two pools: The `ptb` share of demand goes 
*' into a pool for which the origin of products is fixed by the self-sufficiency ratios and export shares.
*' This "self-sufficiency" pool thus implies minimum production levels in superregions, which are enforced by the 
*' lower bound of the production band. 
*' The remaining part of the demand can be allocated more freely based on comparative advantage 
*' in production of different superregions, though still being constrained by the upper bounds of the production band.
*'
*' The superregional self-sufficiency ratios `f21_self_suff` define
*' how much of the demand of each superregion `h` for each traded good `k_trade` is met by domestic production.
*' Self-sufficiency ratios smaller than one indicate that the superregion imports from the world market,
*' while self-sufficiencies greater than one indicate that the superregion produces for export. 
*' The superregional export shares `f21_exp_shr` distribute the total excess demand of the importing superregions 
*' to the exporting superregions.
*' 
*' Trade costs are the sum of trade margins (international transport costs) and trade tariffs.
*'
*' ![Implementation of trade.](trade_pools.png){ width=100% }

*' @limitations This realization depends on predetermined self-sufficiency rates and export shares,
*' which leads to a relative fixed trade pattern.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/21_trade/selfsuff_reduced/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/selfsuff_reduced/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/21_trade/selfsuff_reduced/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/selfsuff_reduced/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/21_trade/selfsuff_reduced/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/selfsuff_reduced/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/selfsuff_reduced/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
