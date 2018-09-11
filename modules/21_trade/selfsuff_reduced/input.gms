*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

$setglobal c21_trade_liberalization  l909090r808080
*   options are "regionalized" and "globalized" and "fragmented"

scalars
  s21_trade_tariff trade tariff switch (1=on 0=off)                      / 1 /
;

table f21_trade_bal_reduction(t_all,trade_groups21,trade_regime21) share of inelastic trade pool (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_bal_reduction.cs3"
$offdelim;

table f21_self_suff(t_all,i,kall) regional self-sufficiency rates (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_self_suff.cs3"
$offdelim;

table f21_exp_shr(t_all,i,kall) regional and crop-specific export share (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_export_share.cs3"
$offdelim;

table f21_trade_balanceflow(t_all,kall) domestic balance flows (mio. tDM)
$ondelim
$include "./modules/21_trade/input/f21_trade_balanceflow.cs3"
$offdelim;

table f21_trade_margin(i,kall) costs of freight and insurance (USD per tDM)
$ondelim
$include "./modules/21_trade/input/f21_trade_margin.cs3"
$offdelim
;

table f21_trade_tariff(i,kall) specific duty tariffs (USD per tDM)
$ondelim
$include "./modules/21_trade/input/f21_trade_tariff.cs3"
$offdelim
;
