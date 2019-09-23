*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


i21_trade_bal_reduction(t_all,k_trade)=f21_trade_bal_reduction(t_all,"easytrade","%c21_trade_liberalization%");
i21_trade_bal_reduction(t_all,k_hardtrade21)=f21_trade_bal_reduction(t_all,"hardtrade","%c21_trade_liberalization%");

i21_trade_margin(i2,k_trade) = f21_trade_margin(i2,k_trade);

i21_trade_margin(i,"wood") = f21_trade_margin(i,"potato");
i21_trade_margin(i,"woodfuel") = f21_trade_margin(i,"potato");

if ((s21_trade_tariff=1),
    i21_trade_tariff(i2,k_trade) = f21_trade_tariff(i2,k_trade);
elseif (s21_trade_tariff=0),
    i21_trade_tariff(i2,k_trade) = 0;
);
