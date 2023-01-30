*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c21_trade_liberalization  l909090r808080
*   options are "regionalized" and "globalized" and "fragmented"

scalars
  s21_trade_tariff Trade tariff switch (1=on 0=off)  (1)                   / 1 /
  s21_trade_bal_damper Fraction to ease self sufficiency pool trade for roundwood /0.75/
;

table f21_trade_bal_reduction(t_all,trade_groups21,trade_regime21) Share of inelastic trade pool (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_bal_reduction.cs3"
$offdelim;

table f21_self_suff(t_all,h,kall) Superregional self-sufficiency rates (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_self_suff.cs3"
$offdelim;

table f21_exp_shr(t_all,h,kall) Superregional and crop-specific export share (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_export_share.cs3"
$offdelim;

table f21_trade_balanceflow(t_all,kall) Domestic balance flows (mio. tDM per yr)
$ondelim
$include "./modules/21_trade/input/f21_trade_balanceflow.cs3"
$offdelim;

table f21_trade_margin(h,kall) Costs of freight and insurance (USD05MER per tDM)
$ondelim
$include "./modules/21_trade/input/f21_trade_margin.cs3"
$offdelim
;

table f21_trade_tariff(h,kall) Specific duty tariffs (USD05MER per tDM)
$ondelim
$include "./modules/21_trade/input/f21_trade_tariff.cs3"
$offdelim
;
