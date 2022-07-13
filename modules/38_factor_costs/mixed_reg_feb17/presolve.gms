*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


p38_share_calibration(i) = f38_historical_share("y2010",i)-(f38_reg_parameters("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso("y2010",iso)))+f38_reg_parameters("intercept"));

if (m_year(t)<2010,
 p38_cost_share(t,i,"capital") = f38_historical_share(t,i);
 p38_cost_share(t,i,"labor")   = 1 - f38_historical_share(t,i);

elseif (m_year(t)>=2010),
p38_cost_share(t,i,"capital") = f38_reg_parameters("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso(t,iso)))+f38_reg_parameters("intercept")+p38_share_calibration(i);
p38_cost_share(t,i,"labor")   = 1 - p38_cost_share(t,i,"capital");
);

if (m_year(t)>s38_shock_year,
   p38_fac_req(i,kcr,"irrigated") = f38_fac_req(i,kcr,"irrigated") * s38_factor_irrigation ;
);
