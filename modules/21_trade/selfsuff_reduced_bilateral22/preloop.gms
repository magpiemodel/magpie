*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i21_trade_bal_reduction(t_all,k_trade)=f21_trade_bal_reduction(t_all,"easytrade","%c21_trade_liberalization%");
i21_trade_bal_reduction(t_all,k_hardtrade21)=f21_trade_bal_reduction(t_all,"hardtrade","%c21_trade_liberalization%");

i21_trade_margin(i_ex,i_im,k_trade) = f21_trade_margin(i_ex,i_im,k_trade);

if ((s21_trade_tariff=1),
    i21_trade_tariff(t_all, i_ex,i_im,k_trade) = f21_trade_tariff(i_ex,i_im,k_trade);
elseif (s21_trade_tariff=0),
    i21_trade_tariff(t_all, i_ex,i_im,k_trade) = 0;
);

if ((s21_trade_tariff_fadeout=1),
loop(t_all,
   i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) > s21_trade_tariff_startyear AND m_year(t_all) < s21_trade_tariff_targetyear) = (1-((m_year(t_all)-s21_trade_tariff_startyear) /
                                                                                                                                           (s21_trade_tariff_targetyear-s21_trade_tariff_startyear)) * 
                                                                                                                                           i21_trade_tariff(t_all,i_ex,i_im,k_trade));
i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) <= s21_trade_tariff_startyear) = i21_trade_tariff(t_all,i_ex,i_im,k_trade); 
i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) >= s21_trade_tariff_targetyear) = 0 ; 
);
);

pm_selfsuff_ext(t_ext,h,kforestry) = f21_self_suff("y2150",h,kforestry);
pm_selfsuff_ext(t_all,h,kforestry) = f21_self_suff(t_all,h,kforestry);
*Implausible jumps in selfsuff for wood in some regions.
pm_selfsuff_ext(tstart21,h,kforestry) = f21_self_suff("y2010",h,kforestry);

v21_import_for_feasibility.fx(h,k_trade) = 0;
v21_import_for_feasibility.lo(h,k_import21) = 0;
v21_import_for_feasibility.up(h,k_import21) = Inf;
