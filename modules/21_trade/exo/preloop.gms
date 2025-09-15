*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


i21_trade_margin(h,k_trade) = f21_trade_margin(h,k_trade);

if ((s21_trade_tariff=1),
    i21_trade_tariff(h,k_trade) = f21_trade_tariff(h,k_trade);
elseif (s21_trade_tariff=0),
    i21_trade_tariff(h,k_trade) = 0;
);

i21_trade_margin(h,"wood")$(i21_trade_margin(h,"wood") < s21_min_trade_margin_forestry) = s21_min_trade_margin_forestry;
i21_trade_margin(h,"woodfuel")$(i21_trade_margin(h,"woodfuel") < s21_min_trade_margin_forestry) = s21_min_trade_margin_forestry;


** Save self sufficiency values as a interface parameter needed in forestry module
pm_selfsuff_ext(t_ext,h,kforestry) = f21_self_suff("y2150",h,kforestry);
pm_selfsuff_ext(t_all,h,kforestry) = f21_self_suff(t_all,h,kforestry);

** fix to zero by default
v21_manna_from_heaven.fx(h,kall)$(s21_manna_from_heaven = 0) = 0;

