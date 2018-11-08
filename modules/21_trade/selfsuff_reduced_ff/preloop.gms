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

*' Future trade calculations for forestry

im_trade_bal_reduction(t_ext,kforestry) = i21_trade_bal_reduction("y2150",kforestry);
im_trade_bal_reduction(t_all,kforestry) = i21_trade_bal_reduction(t_all,kforestry);

im_trade_margin(i2,"woodfuel") = f21_trade_margin(i2,"cottn_pro");
im_trade_margin(i2,"wood") = im_trade_margin(i2,"woodfuel");

if ((s21_trade_tariff=1),
    im_trade_tariff(i2,kforestry) = f21_trade_tariff(i2,kforestry);
elseif (s21_trade_tariff=0),
    im_trade_tariff(i2,kforestry) = 0;
);

fm_self_suff_forestry(t_all,i,kforestry) = f21_self_suff(t_all,i,kforestry);
fm_trade_balanceflow_forestry(t_all,kforestry) = f21_trade_balanceflow(t_all,kforestry);
fm_exp_shr_forestry(t_all,i,kforestry) = f21_exp_shr(t_all,i,kforestry);
