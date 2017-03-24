*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$setglobal c21_trade_liberalization  regionalized
*   options are "regionalized" and "globalized" and "fragmented"


table f21_self_suff(t_all,i,k_trade) regional self-sufficiency rates (1)
$ondelim
$include "./modules/21_trade/selfsuff_flexreg_dev/input/f21_trade_self_suff.cs3"
$offdelim;

table f21_exp_shr(t_all,i,k_trade) regional and crop-specific export share (1)
$ondelim
$include "./modules/21_trade/selfsuff_flexreg_dev/input/f21_trade_export_share.cs3"
$offdelim;

table f21_trade_balanceflow(t_all,k_trade) domestic balance flows (mio. ton DM)
$ondelim
$include "./modules/21_trade/selfsuff_flexreg_dev/input/f21_trade_balanceflow.cs3"
$offdelim;

table f21_trade_bal_reduction_annual(t_all,kall) trade balance reduction (1)
$ondelim
$Ifi "%c21_trade_liberalization%" == "globalized" $include "./modules/21_trade/input/f21_trade_bal_red_annual_globalized.csv"
$Ifi "%c21_trade_liberalization%" == "regionalized" $include "./modules/21_trade/input/f21_trade_bal_red_annual_regionalized.csv"
$Ifi "%c21_trade_liberalization%" == "fragmented" $include "./modules/21_trade/input/f21_trade_bal_red_annual_fragmented.csv"
$offdelim;
