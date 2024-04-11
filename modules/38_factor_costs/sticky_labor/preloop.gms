*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*   Calibrate the CES function:
s38_ces_elast_par = (1/s38_ces_elast_subst) - 1 ;

p38_intr_depr(t,i) = (1-s38_depreciation_rate) * pm_interest(t,i)/(1+pm_interest(t,i)) + s38_depreciation_rate;

*  calculate labor/capital cost shares from regression
p38_share_calibration(i) = f38_historical_share("y2010",i)-(f38_reg_parameters("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso("y2010",iso)))+f38_reg_parameters("intercept"));

pm_cost_share_crops(t,i,"capital")$(m_year(t)<2010) = f38_historical_share(t,i);
pm_cost_share_crops(t,i,"capital")$(m_year(t)>=2010) = f38_reg_parameters("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso(t,iso)))+f38_reg_parameters("intercept")+p38_share_calibration(i);

pm_cost_share_crops(t,i,"labor")   = 1 - pm_cost_share_crops(t,i,"capital");
