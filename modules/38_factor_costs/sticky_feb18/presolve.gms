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

p38_variable_costs(t,i,kcr) = f38_fac_req(kcr)  * p38_cost_share(t,i,"labor");
p38_capital_need(t,i,kcr,"mobile") = f38_fac_req(kcr) * p38_cost_share(t,i,"capital") / (pm_interest(t,i)+s38_depreciation_rate) * (1-s38_immobile);
p38_capital_need(t,i,kcr,"immobile") = f38_fac_req(kcr)  * p38_cost_share(t,i,"capital") / (pm_interest(t,i)+s38_depreciation_rate) * s38_immobile;

if (ord(t) = 1,

*' Estimate capital stock based on capital remuneration. We assume that in 1994 and 1995 production is the same and the stocks gets depreciated from 1994.
  p38_capital_immobile(t,j,kcr)    = sum(cell(i,j), p38_capital_need(t,i,kcr,"immobile")*pm_prod_init(j,kcr))*(1-s38_depreciation_rate);
  p38_capital_mobile(t,j)    = sum((cell(i,j),kcr), p38_capital_need(t,i,kcr,"mobile")*pm_prod_init(j,kcr))*(1-s38_depreciation_rate);

else

*' Update of existing stocks

    p38_capital_immobile(t,j,kcr)=p38_capital_immobile(t,j,kcr)*(1-s38_depreciation_rate)**(m_timestep_length);
    p38_capital_mobile(t,j)=p38_capital_mobile(t,j)*(1-s38_depreciation_rate)**(m_timestep_length);

    );
