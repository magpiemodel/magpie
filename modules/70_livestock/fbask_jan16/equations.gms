*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Demand for different feed items is derived by multiplying the regional
*' livestock production with the respective feed baskets. Additionally,
*' inconsistencies with the FAO inventory of national feed use in the case of
*' crops as well as consideration of alternative feed sources that reduce e.g.
*' the demand for grazed biomass like scavenging and roadside grazing are
*' balanced out by the parameter `fm_feed_balanceflow`.

q70_feed(i2,kap,kall) ..
 vm_dem_feed(i2,kap,kall) =g= vm_prod_reg(i2,kap)
     *sum(ct,im_feed_baskets(ct,i2,kap,kall))
     +sum(ct,fm_feed_balanceflow(ct,i2,kap,kall));

*' Factor requirement costs (e.g. labour, capital, but without costs for feed)
*' of livestock production depend on the amount of production and the per-unit
*' costs. For ruminant products (milk and meet), we use a regression of per-unit
*' factor costs from the GTAP database [@narayanan_gtap7_2008] and livestock
*' productivity. Here, factor costs rise with intensification. The per-unit
*' costs for non-ruminants and fish are assumed to be independent from
*' productivity trajectories for simplification. Therefore,
*' `i70_cost_regr(i,kli,"cost_regr_b")` is set to zero in the case of livestock
*' products generated in monogastric systems.

*' To account for increased hourly labor costs and producitivity in case of an external 
*' wage scenario, the total labor costs are scaled by the corresponding increase in hourly
*' labor costs and the related productivity gain from [36_employment].

q70_cost_prod_liv_labor(i2) ..
 vm_cost_prod_livst(i2,"labor") =e= sum(kli, vm_prod_reg(i2,kli) * sum(ct, i70_fac_req_livst(ct,i2,kli))) 
     *sum(ct, p70_cost_share_livst(ct,i2,"labor")) 
     *sum(ct, (1/pm_productivity_gain_from_wages(ct,i2)) * (pm_hourly_costs(ct,i2,"scenario") / pm_hourly_costs(ct,i2,"baseline")));
  
q70_cost_prod_liv_capital(i2) ..
 vm_cost_prod_livst(i2,"capital") =e= sum(kli, vm_prod_reg(i2,kli) * sum(ct, i70_fac_req_livst(ct,i2,kli))) 
     *sum(ct, p70_cost_share_livst(ct,i2,"capital"));

q70_cost_prod_fish(i2) ..
 vm_cost_prod_fish(i2) =e=
     vm_prod_reg(i2,"fish")*i70_cost_regr(i2,"fish","cost_regr_a");
