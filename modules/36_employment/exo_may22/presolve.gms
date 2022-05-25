*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* historic hourly labor costs for t_past, calibrated regression values based on GDPpcMER for future years
if (sum(sameas(t_past,t),1) = 1,
	p36_hourly_costs_iso(t,iso) = f36_hist_hourly_costs(t,iso)
else
	p36_hourly_costs_iso(t,iso) = max((im_gdp_pc_mer_iso(t,iso)*f36_regr_hourly_costs("slope")+
							 	 f36_regr_hourly_costs("intercept")+p36_calibration_hourly_costs(iso)), 
								 f36_regr_hourly_costs("threshold"));
);

p36_hourly_costs(t,i) = sum(i_to_iso(i,iso),p36_hourly_costs_iso(t,iso)*p36_total_hours_worked(iso))*(1/sum(i_to_iso(i,iso),p36_total_hours_worked(iso)));


* capital cost share to split non-magpie factor costs into labor and capital
p36_share_calibration(i) = f36_hist_cap_share("y2010",i)-(f36_regr_cap_share("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso("y2010",iso)))+f36_regr_cap_share("intercept"));

if (m_year(t)<2010,
 p36_cost_share(t,i) = f36_hist_cap_share(t,i);
elseif (m_year(t)>=2010),
 p36_cost_share(t,i) = f36_regr_cap_share("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso(t,iso)))+f36_regr_cap_share("intercept")+p36_share_calibration(i);
);

* non-MAgPIE labor costs
p36_nonmagpie_labor_costs(t,i) = (f36_unspecified_subsidies(t,i) + f36_nonmagpie_factor_costs(t,i)) * (1-p36_cost_share(t,i));