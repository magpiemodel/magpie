*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
*f21_self_suff(t_all,"MEA","wood")     = 0.05;
*f21_self_suff(t_all,"MEA","woodfuel") = 0.05;

f21_self_suff(t_all,"MEA",kforestry) = 0.2;
f21_self_suff(t_all,"JPN",kforestry) = 0.50;
*f21_self_suff(t_all,"REF",kforestry) = 0.90;
*f21_self_suff(t_all,i,"woodfuel") = f21_self_suff(t_all,i,"wood");

*f21_trade_tariff("MEA",kforestry)    = 0.01;
*f21_trade_tariff("MEA",kforestry)    = 100;
*f21_trade_tariff("JPN",kforestry)    = 999999;

i21_trade_bal_reduction(t_all,k_trade)=f21_trade_bal_reduction(t_all,"easytrade","%c21_trade_liberalization%");
i21_trade_bal_reduction(t_all,k_hardtrade21)=f21_trade_bal_reduction(t_all,"hardtrade","%c21_trade_liberalization%");

i21_trade_margin(i2,k_trade) = f21_trade_margin(i2,k_trade);
i21_trade_margin(i2,kforestry) = i21_trade_margin(i2,"others");

if ((s21_trade_tariff=1),
    i21_trade_tariff(i2,k_trade) = f21_trade_tariff(i2,k_trade);
elseif (s21_trade_tariff=0),
    i21_trade_tariff(i2,k_trade) = 0;
);

*' Future trade calculations for forestry

i21_trade_bal_reduction_ff(t_ext,kforestry) = i21_trade_bal_reduction("y2150",kforestry);
i21_trade_bal_reduction_ff(t_all,kforestry) = i21_trade_bal_reduction(t_all,kforestry);

i21_trade_margin_ff(i2,"woodfuel") = f21_trade_margin(i2,"cottn_pro");
i21_trade_margin_ff(i2,"wood") = i21_trade_margin_ff(i2,"woodfuel");

if ((s21_trade_tariff=1),
    i21_trade_tariff_ff(i2,kforestry) = f21_trade_tariff(i2,kforestry);
elseif (s21_trade_tariff=0),
    i21_trade_tariff_ff(i2,kforestry) = 0;
);

*' Extended time frame calculations. Holding constant after y2150.

p21_demand_ext(t_ext,i,"wood") = fm_forestry_demand("y2150",i,"wood");
p21_demand_ext(t_all,i,"wood") = fm_forestry_demand(t_all,i,"wood");
p21_demand_ext(t_ext,i,"woodfuel") = fm_forestry_demand("y2150",i,"woodfuel");
p21_demand_ext(t_all,i,"woodfuel") = fm_forestry_demand(t_all,i,"woodfuel");

p21_selfsuff_ext(t_ext,i,kforestry) = f21_self_suff("y2150",i,kforestry);
p21_selfsuff_ext(t_all,i,kforestry) = f21_self_suff(t_all,i,kforestry);

p21_trade_balanceflow_ext(t_ext,kforestry) = f21_trade_balanceflow("y2150",kforestry);
p21_trade_balanceflow_ext(t_all,kforestry) = f21_trade_balanceflow(t_all,kforestry);

p21_exp_shr_ext(t_ext,i,kforestry) = f21_exp_shr("y2150",i,kforestry);
p21_exp_shr_ext(t_all,i,kforestry) = f21_exp_shr(t_all,i,kforestry);
