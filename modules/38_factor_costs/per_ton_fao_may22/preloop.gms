*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*  calculate capital cost shares from regression
p38_capital_share_calibration(iso) = sum(t_past$(ord(t_past) eq card(t_past)), f38_historical_share(t_past,iso) - (f38_reg_parameters("slope") * 
                                    log10(im_gdp_pc_ppp_iso(t_past,iso)) + f38_reg_parameters("intercept")));

p38_capital_cost_shares_iso(t,iso)$(m_year(t)<2010)  = f38_historical_share(t,iso);
p38_capital_cost_shares_iso(t,iso)$(m_year(t)>=2010) = f38_reg_parameters("slope") * log10(im_gdp_pc_ppp_iso(t,iso)) + f38_reg_parameters("intercept") + p38_capital_share_calibration(iso);

* aggregate factor cost shares
pm_factor_cost_shares(t,i,"capital") = sum(t_past$(ord(t_past) eq card(t_past)), 
                                            sum(i_to_iso(i,iso), f38_hist_factor_costs(t_past,iso) * p38_capital_cost_shares_iso(t,iso)) / 
                                            sum(i_to_iso(i,iso), f38_hist_factor_costs(t_past,iso)));
pm_factor_cost_shares(t,i,"labor")   = 1 - pm_factor_cost_shares(t,i,"capital");
