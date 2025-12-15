*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 v70_feed_intake_pre(i,kap,kall)     Regional feed intake (pre-calculation) including byproducts (mio. tDM per yr)
 vm_dem_feed(i,kap,kall)             Regional feed demand including byproducts (mio. tDM per yr)
 vm_cost_prod_livst(i,factors)       Livestock factor costs (mio. USD17MER per yr)
 vm_cost_prod_fish(i)                Fish factor costs (mio. USD17MER per yr)
;

variables
 vm_feed_balanceflow(i,kap,kall)     Regional feed balance flows (mio. tDM)
 vm_feed_intake(i,kap,kall)          Regional feed intake including byproducts (mio. tDM per yr)
;

equations
 q70_feed_intake_pre(i,kap,kall)     Regional feed intake pre-calculation
 q70_feed_intake(i,kap,kall)         Regional feed intake
 q70_feed(i,kap,kall)                Regional feed demand
 q70_feed_balanceflow(i,kli_rum)     Regional feed balance flow calculations for ruminant products
 q70_cost_prod_liv_labor(i)          Regional labor costs for livestock production
 q70_cost_prod_liv_capital(i)        Regional capital costs for livestock production
 q70_cost_prod_fish(i)               Regional factor input costs for fish production
;

parameters
 p70_endo_scavenging_flag(i,kli_rum)              Flag indicating regions where pasture balance flows (e.g., due to scavenging) exceed threshold relative to pasture demand (1)
 pc70_dem_feed_pasture(i,kli_rum)                 Pasture feed demand of the previous time step (mio. tDM per yr)
 im_slaughter_feed_share(t_all,i,kap,attributes)  Share of feed that is incorporated in animal biomass (1)
 i70_livestock_productivity(t_all,i,sys)          Productivity indicator for livestock production (t FM per animal per yr)
 im_feed_baskets(t_all,i,kap,kall)                Feed baskets in tDM per tDM livestock product (1)
 p70_cattle_stock_proxy(t,i)                      Proxy for cattle stocks needed to fullfil food demand for ruminant meat (mio. animals per yr)
 p70_milk_cow_proxy(t,i)                          Proxy for milk cows needed to fullfil food demand for milk (mio. animals per yr)
 p70_cattle_feed_pc_proxy(t,i,kli_rd)             Proxy for daily per capita feed demand for pasture biomass driven by demand for beef and dairy products (tDM per capita per day)
 p70_incr_cattle(t,i)                             Change in estimated cattle stocks attributed to food demand projections (1)
 pm_past_mngmnt_factor(t,i)                       Regional pasture management intensification factor (1)
 i70_cereal_scp_fadeout(t_all,i)                  Cereal feed fadeout (share 0-1) to be replaced by SCP (1)
 i70_foddr_scp_fadeout(t_all,i)                   Fodder fadeout (share 0-1) to be replaced by SCP (1)
 p70_country_switch(iso)                          Switch indicating whether country is affected by feed scenarios (1)
 p70_feedscen_region_shr(t_all,i)                 Weighted share of region with regards to feed scenario of countries (1)
 i70_cost_regr(i,kap,cost_regr)                   Regression coefficients for livestock factor requirements (1)
 i70_fac_req_livst(t_all,i,kli)                   Factor requirements (USD17MER per tDM)
 p70_cereal_subst_fader(t_all)                    Cereal feed substitution with SCP fader (1)
 p70_foddr_subst_fader(t_all)                     Foddr substitution with SCP fader (1)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov70_feed_intake_pre(t,i,kap,kall,type) Regional feed intake (pre-calculation) including byproducts (mio. tDM per yr)
 ov_dem_feed(t,i,kap,kall,type)          Regional feed demand including byproducts (mio. tDM per yr)
 ov_cost_prod_livst(t,i,factors,type)    Livestock factor costs (mio. USD17MER per yr)
 ov_cost_prod_fish(t,i,type)             Fish factor costs (mio. USD17MER per yr)
 ov_feed_balanceflow(t,i,kap,kall,type)  Regional feed balance flows (mio. tDM)
 ov_feed_intake(t,i,kap,kall,type)       Regional feed intake including byproducts (mio. tDM per yr)
 oq70_feed_intake_pre(t,i,kap,kall,type) Regional feed intake pre-calculation
 oq70_feed_intake(t,i,kap,kall,type)     Regional feed intake
 oq70_feed(t,i,kap,kall,type)            Regional feed demand
 oq70_feed_balanceflow(t,i,kli_rum,type) Regional feed balance flow calculations for ruminant products
 oq70_cost_prod_liv_labor(t,i,type)      Regional labor costs for livestock production
 oq70_cost_prod_liv_capital(t,i,type)    Regional capital costs for livestock production
 oq70_cost_prod_fish(t,i,type)           Regional factor input costs for fish production
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
