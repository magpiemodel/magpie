*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$setglobal c21_trade_liberalization  regionalized
*   options are "regionalized" and "globalized" and "fragmented"

scalars
  c21_reduction_start  initial annual trade balance reduction            / 0.0025 /
  c21_reduction_regionalized regionalized annual trade balance reduction / 0.005  /
  c21_reduction_globalized   globalized annual trade balance reduction   / 0.01   /
  c21_reduction_fragmented   fragmented annual trade balance reduction   / 0      /
;

table f21_self_suff(t_all,i,kall) regional self-sufficiency rates (1)
$ondelim
$include "./modules/21_trade/selfsuff_flexreg/input/f21_trade_self_suff.cs3"
$offdelim;

table f21_exp_shr(t_all,i,kall) regional and crop-specific export share (1)
$ondelim
$include "./modules/21_trade/selfsuff_flexreg/input/f21_trade_export_share.cs3"
$offdelim;

table f21_trade_balanceflow(t_all,kall) domestic balance flows (mio. ton DM)
$ondelim
$include "./modules/21_trade/selfsuff_flexreg/input/f21_trade_balanceflow.cs3"
$offdelim;
