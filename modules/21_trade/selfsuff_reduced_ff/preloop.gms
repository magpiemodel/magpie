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

i21_trade_bal_reduction_ff(t_ext,kforestry2) = i21_trade_bal_reduction("y2150",kforestry2);
i21_trade_bal_reduction_ff(t_all,kforestry2) = i21_trade_bal_reduction(t_all,kforestry2);

i21_trade_margin_ff(i2,"woodfuel") = f21_trade_margin(i2,"cottn_pro");
i21_trade_margin_ff(i2,"wood") = i21_trade_margin_ff(i2,"woodfuel");

if ((s21_trade_tariff=1),
    i21_trade_tariff_ff(i2,kforestry2) = f21_trade_tariff(i2,kforestry2);
elseif (s21_trade_tariff=0),
    i21_trade_tariff_ff(i2,kforestry2) = 0;
);

*' Extended time frame calculations. Holding constant after y2150.

p21_demand_ext(t_ext,i,"wood") = fm_forestry_demand("y2150",i,"wood");
p21_demand_ext(t_all,i,"wood") = fm_forestry_demand(t_all,i,"wood");
p21_demand_ext(t_ext,i,"woodfuel") = fm_forestry_demand("y2150",i,"woodfuel");
p21_demand_ext(t_all,i,"woodfuel") = fm_forestry_demand(t_all,i,"woodfuel");

p21_selfsuff_ext(t_ext,i,kforestry2) = f21_self_suff("y2150",i,kforestry2);
p21_selfsuff_ext(t_all,i,kforestry2) = f21_self_suff(t_all,i,kforestry2);

p21_trade_balanceflow_ext(t_ext,kforestry2) = f21_trade_balanceflow("y2150",kforestry2);
p21_trade_balanceflow_ext(t_all,kforestry2) = f21_trade_balanceflow(t_all,kforestry2);

p21_exp_shr_ext(t_ext,i,kforestry2) = f21_exp_shr("y2150",i,kforestry2);
p21_exp_shr_ext(t_all,i,kforestry2) = f21_exp_shr(t_all,i,kforestry2);
