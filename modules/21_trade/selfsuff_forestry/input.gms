*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c21_trade_liberalization  l908080r807070
*   options are "regionalized" and "globalized" and "fragmented"

scalars
  s21_trade_tariff Trade tariff switch (1=on 0=off)  (1)                   / 1 /
  s21_redn_factor Reduction factor for trade balance reduction for timber products (1) / 0.5 /
  s21_counter blub / 0 /
  s21_maxiter blub / 2 /
;

table f21_trade_bal_reduction(t_all,trade_groups21,trade_regime21) Share of inelastic trade pool (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_bal_reduction.cs3"
$offdelim;

table f21_self_suff(t_all,i,kall) Regional self-sufficiency rates (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_self_suff.cs3"
$offdelim;

table f21_exp_shr(t_all,i,kall) Regional and crop-specific export share (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_export_share.cs3"
$offdelim;

table f21_trade_balanceflow(t_all,kall) Domestic balance flows (mio. tDM per yr)
$ondelim
$include "./modules/21_trade/input/f21_trade_balanceflow.cs3"
$offdelim;

table f21_trade_margin(i,kall) Costs of freight and insurance (USD05MER per tDM)
$ondelim
$include "./modules/21_trade/input/f21_trade_margin.cs3"
$offdelim
;

table f21_trade_tariff(i,kall) Specific duty tariffs (USD05MER per tDM)
$ondelim
$include "./modules/21_trade/input/f21_trade_tariff.cs3"
$offdelim
;

table f21_trade_balance(t_all,i,kall) trade balance of positive exports and negative imports (mio. tDM per yr)
$ondelim
$include "./modules/21_trade/input/f21_trade_balance.cs3"
$offdelim;
