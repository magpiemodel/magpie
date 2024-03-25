*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
 s21_manna_from_heaven  v21_manna_from_heaven fixed to zero (0) or available at high cost (1) (binary) / 0 /
;

table f21_trade_balance(t_all,h,kall) trade balance of positive exports and negative imports (mio. tDM per yr)
$ondelim
$include "./modules/21_trade/input/f21_trade_balance.cs3"
$offdelim;

table f21_self_suff(t_all,h,kall) Superregional self-sufficiency rates (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_self_suff.cs3"
$offdelim;
