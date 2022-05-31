*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

if (smax(j, pm_labor_prod(t,j)) <> 1 OR smin(j, pm_labor_prod(t,j)) <> 1,
	abort "This factor cost realization cannot handle labor productivities != 1"
);

p38_share_calibration(i) = f38_historical_share("y2010",i)-(f38_reg_parameters("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso("y2010",iso)))+f38_reg_parameters("intercept"));

if (m_year(t)<2010,
 p38_cost_share(t,i,"capital") = f38_historical_share(t,i);
 p38_cost_share(t,i,"labor")   = 1 - f38_historical_share(t,i);

elseif (m_year(t)>=2010),
p38_cost_share(t,i,"capital") = f38_reg_parameters("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso(t,iso)))+f38_reg_parameters("intercept")+p38_share_calibration(i);
p38_cost_share(t,i,"labor")   = 1 - p38_cost_share(t,i,"capital");
);
