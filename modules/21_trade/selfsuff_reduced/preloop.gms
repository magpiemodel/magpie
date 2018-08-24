*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


i21_trade_bal_reduction(t_all,k_trade)=f21_trade_bal_reduction(t_all,"easytrade","%c21_trade_liberalization%");
i21_trade_bal_reduction(t_all,k_hardtrade21)=f21_trade_bal_reduction(t_all,"hardtrade","%c21_trade_liberalization%");

i21_trade_margin(i2,k_trade) = f21_trade_margin(i2,k_trade);

if ((s21_trade_tariff=1),
    i21_trade_tariff(i2,k_trade) = f21_trade_tariff(i2,k_trade);
elseif (s21_trade_tariff=0),
    i21_trade_tariff(i2,k_trade) = 0;
);

