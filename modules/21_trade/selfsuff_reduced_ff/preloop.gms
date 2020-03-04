*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

f21_self_suff(t_all,"MEA","wood") = 0.3;
f21_self_suff(t_all,"MEA","woodfuel") = 0.3;
f21_self_suff(t_all,"JPN","wood") = 0.3;
f21_self_suff(t_all,"JPN","woodfuel") = 0.3;

f21_exp_shr(t_all,"JPN",kforestry) = 0;
f21_exp_shr(t_all,"MEA",kforestry) = 0;

f21_trade_margin("MEA",kforestry) = 0.1;
f21_trade_margin("JPN",kforestry) = 0.1;

f21_trade_tariff("JPN",kforestry) = 0.0000001;
f21_trade_tariff("MEA",kforestry) = 0.0000001;

i21_trade_bal_reduction(t_all,k_trade)=f21_trade_bal_reduction(t_all,"easytrade","%c21_trade_liberalization%");
i21_trade_bal_reduction(t_all,k_hardtrade21)=f21_trade_bal_reduction(t_all,"hardtrade","%c21_trade_liberalization%");

i21_trade_margin(i,k_trade) = f21_trade_margin(i,k_trade);

if ((s21_trade_tariff=1),
    i21_trade_tariff(i,k_trade) = f21_trade_tariff(i,k_trade);
elseif (s21_trade_tariff=0),
    i21_trade_tariff(i,k_trade) = 0;
);

*' Future trade calculations for forestry

i21_trade_bal_reduction_ff(t_ext,kforestry) = i21_trade_bal_reduction("y2150","livst_rum");
i21_trade_bal_reduction_ff(t_all,kforestry) = i21_trade_bal_reduction(t_all,"livst_rum");

i21_trade_margin_ff(i,"woodfuel") = i21_trade_margin(i,"woodfuel");
i21_trade_margin_ff(i,"wood") = i21_trade_margin_ff(i,"woodfuel");

if ((s21_trade_tariff=1),
    i21_trade_tariff_ff(i,kforestry) = f21_trade_tariff(i,kforestry);
elseif (s21_trade_tariff=0),
    i21_trade_tariff_ff(i,kforestry) = 0;
);

p21_selfsuff_ext(t_ext,i,kforestry) = f21_self_suff("y2150",i,kforestry);
p21_selfsuff_ext(t_all,i,kforestry) = f21_self_suff(t_all,i,kforestry);

p21_trade_balanceflow_ext(t_ext,kforestry) = f21_trade_balanceflow("y2150",kforestry);
p21_trade_balanceflow_ext(t_all,kforestry) = f21_trade_balanceflow(t_all,kforestry);

p21_exp_shr_ext(t_ext,i,kforestry) = f21_exp_shr("y2150",i,kforestry);
p21_exp_shr_ext(t_all,i,kforestry) = f21_exp_shr(t_all,i,kforestry);
