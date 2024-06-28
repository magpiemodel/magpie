*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @code
*' This realization of the livestock module also estimates an exogenous 
*' pasture management factor `pm_past_mngmnt_factor` that is used to scale
*' biophysical pasture yields in the module [14_yields].

*' The exogenous calculation of pasture management requires information on
*' changes in the number of cattle reared to fulfil the food demand for ruminant
*' livestock products: 

p70_cattle_stock_proxy(t,i) = im_pop(t,i)*pm_kcal_pc_initial(t,i,"livst_rum")
                  /i70_livestock_productivity(t,i,"sys_beef");

p70_milk_cow_proxy(t,i) = im_pop(t,i)*pm_kcal_pc_initial(t,i,"livst_milk")
                  /i70_livestock_productivity(t,i,"sys_dairy");

*' The lower bound for `p70_cattle_stock_proxy` and `p70_milk_cow_proxy` is
*' set to 20% of initial values in 1995:

p70_cattle_stock_proxy(t,i)$(p70_cattle_stock_proxy(t,i) < 0.2*p70_cattle_stock_proxy("y1995",i)) = 0.2*p70_cattle_stock_proxy("y1995",i);
p70_milk_cow_proxy(t,i)$(p70_milk_cow_proxy(t,i) < 0.2*p70_milk_cow_proxy("y1995",i)) = 0.2*p70_milk_cow_proxy("y1995",i);

*' The parameter `p70_cattle_feed_pc_proxy` is a proxy for regional daily per capita
*' feed demand for pasture biomass driven by demand for beef and dairy products,
*' which is later used for weighted aggregation.
p70_cattle_feed_pc_proxy(t,i,kli_rd) = pm_kcal_pc_initial(t,i,kli_rd)*im_feed_baskets(t,i,kli_rd,"pasture")/(fm_nutrition_attributes(t,kli_rd,"kcal") * 10**6);

*' The parameter `p70_incr_cattle` describes the changes in the number of cattle
*' relative to the previous time step:

if (ord(t)>1,
   p70_incr_cattle(t,i) = ( (p70_cattle_feed_pc_proxy(t,i,"livst_rum")  + 10**(-6))* (p70_cattle_stock_proxy(t,i)/p70_cattle_stock_proxy(t-1,i))
                                          +  (p70_cattle_feed_pc_proxy(t,i,"livst_milk") + 10**(-6)) * (p70_milk_cow_proxy(t,i)/p70_milk_cow_proxy(t-1,i)) )
                                        / sum(kli_rd, p70_cattle_feed_pc_proxy(t,i,kli_rd) + 10**(-6));
else
   p70_incr_cattle(t,i) = 1;
);

*' The pasture management factor is calculated by applying a linear relationship 
*' that links changes in pasture management with changes in the number of cattle:

if (m_year(t) <= s70_past_mngmnt_factor_fix,
   pm_past_mngmnt_factor(t,i) = 1;
else               
   pm_past_mngmnt_factor(t,i) =   ( (s70_pyld_intercept + f70_pyld_slope_reg(i)*p70_incr_cattle(t,i)**(5/(m_year(t)-m_year(t-1))) 
           )**((m_year(t)-m_year(t-1))/5) )*pm_past_mngmnt_factor(t-1,i);
 );

*' @stop

p70_cost_share_calibration(i) = f70_hist_cap_share("y2010",i)-(f70_cap_share_reg("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso("y2010",iso)))+f70_cap_share_reg("intercept"));

if (m_year(t)<2010,
 p70_cost_share_livst(t,i,"capital") = f70_hist_cap_share(t,i);
 p70_cost_share_livst(t,i,"labor")   = 1 - f70_hist_cap_share(t,i);

elseif (m_year(t)>=2010),
 p70_cost_share_livst(t,i,"capital") = f70_cap_share_reg("slope")*log10(sum(i_to_iso(i,iso),im_gdp_pc_ppp_iso(t,iso)))+f70_cap_share_reg("intercept")+p70_cost_share_calibration(i);
 p70_cost_share_livst(t,i,"labor")   = 1 - p70_cost_share_livst(t,i,"capital");
);


*** Section implementing the "sticky" part of the realization
*' The capital need per unit of production is based on the capital share of the factor requirements, 
*' as well as the interest and the depreciation rates, analogously to the `sticky_feb18` realization.
*' In addition `s70_multiplicator_capital_need` can be used to increase the capital need.

p70_capital_need(t,i,kli) = i70_fac_req_livst(t,i,kli)      
                            * p70_cost_share_livst(t,i,"capital")
                            / (pm_interest(t,i)+s70_depreciation_rate)
                            * s70_multiplicator_capital_need;

if (ord(t) = 1,

*' Estimate capital stock based on initial production.

  p70_capital(t,i,kli) = p70_capital_need(t,i,kli) * p70_initial_1995_prod(i,kli);

else

*' Update of existing stocks due to depreciation

  p70_capital(t,i,kli) = p70_capital(t,i,kli) * (1-s70_depreciation_rate)**(m_timestep_length);

);
