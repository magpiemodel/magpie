*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* capital cost share to split non-magpie factor costs into labor and capital
p36_share_calibration(i) = f36_hist_cap_share("y2010",i)-(f36_regr_cap_share("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso("y2010",iso)))+f36_regr_cap_share("intercept"));

if (m_year(t)<2010,
 p36_cost_share(t,i) = f36_hist_cap_share(t,i);
elseif (m_year(t)>=2010),
 p36_cost_share(t,i) = f36_regr_cap_share("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso(t,iso)))+f36_regr_cap_share("intercept")+p36_share_calibration(i);
);

*' @code

*' Non-MAgPIE labor costs consist of the labor cost share of subsidies and from livestock
*' categories not covered by MAgPIE (i.e. wool, beeswax, honey, silk-worms), which 
*' are both kept constant for future years. 

p36_nonmagpie_labor_costs(t,i) = (f36_unspecified_subsidies(t,i) + f36_nonmagpie_factor_costs(t,i)) *
                                     (1-p36_cost_share(t,i)) * (1/pm_productivity_gain_from_wages(t,i)) *
                                     (pm_hourly_costs(t,i,"scenario") / pm_hourly_costs(t,i,"baseline"));

*' @stop
