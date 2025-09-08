*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
  s21_trade_tariff Trade tariff switch (1=on 0=off)  (1)                   / 1 /
  s21_min_trade_margin_forestry Minimum trade margin for forestry products (USD17MER per tDM) / 62 /
;

table f21_trade_balance(t_all,h,kall) trade balance of positive exports and negative imports (mio. tDM per yr)
$ondelim
$include "./modules/21_trade/input/f21_trade_balance.cs3"
$offdelim;

table f21_trade_margin(h,kall) Costs of freight and insurance (USD17MER per tDM)
$ondelim
$include "./modules/21_trade/input/f21_trade_margin.cs3"
$offdelim
;

table f21_trade_tariff(h,kall) Specific duty tariffs (USD17MER per tDM)
$ondelim
$include "./modules/21_trade/input/f21_trade_tariff.cs3"
$offdelim
;
