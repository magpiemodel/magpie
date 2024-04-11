*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

if (smax(j, pm_labor_prod(t,j)) <> 1 OR smin(j, pm_labor_prod(t,j)) <> 1,
  abort "This factor cost realization cannot handle labor productivities != 1"
);

* choosing between regional (+time dependent) or global (from 2005) factor requirements
$if "%c38_fac_req%" == "glo" i38_fac_req(t,i,kcr) = f38_fac_req(kcr);
$if "%c38_fac_req%" == "reg" i38_fac_req(t,i,kcr) = f38_fac_req_fao_reg(t,i,kcr);

if (m_year(t)<=1995,
  i38_fac_req(t,i,kcr) = i38_fac_req("y1995",i,kcr);
elseif m_year(t)>=2010,
  i38_fac_req(t,i,kcr) = i38_fac_req("y2010",i,kcr);
else
  i38_fac_req(t,i,kcr) = i38_fac_req(t,i,kcr);
);

p38_share_calibration(i) = f38_historical_share("y2010",i)-(f38_reg_parameters("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso("y2010",iso)))+f38_reg_parameters("intercept"));

if (m_year(t)<2010,
  pm_cost_share_crops(t,i,"capital") = f38_historical_share(t,i);
  pm_cost_share_crops(t,i,"labor")   = 1 - f38_historical_share(t,i);

elseif (m_year(t)>=2010),
  pm_cost_share_crops(t,i,"capital") = f38_reg_parameters("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso(t,iso)))+f38_reg_parameters("intercept")+p38_share_calibration(i);
  pm_cost_share_crops(t,i,"labor")   = 1 - pm_cost_share_crops(t,i,"capital");
);
