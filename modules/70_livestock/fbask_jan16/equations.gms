*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
     *sum(ct,f70_feed_baskets(ct,i2,kap,kall,"%c70_feed_scen%"))
     +sum(ct,fm_feed_balanceflow(ct,i2,kap,kall));

*' Factor requirement costs (e.g. labour, capital, but without costs for feed)
*' of livestock production depend on the amount of production and the per-unit
*' costs. For ruminant products (milk and meet), we use a regression of per-unit
*' factor costs from the GTAP database [@narayanan_gtap7_2008] and livestock
*' productivity. Here, factor costs rise with intensification. The per-unit
*' costs for non-ruminants and fish are assumed to be independent from
*' productivity trajectories for simplification. Therefore,
*' `f70_cost_regr(kli,"cost_regr_b")` is set to zero in the case of livestock
*' products generated in monogastric systems.

q70_cost_prod_liv(i2,kli) ..
 vm_cost_prod(i2,kli) =e= vm_prod_reg(i2,kli)
     *(f70_cost_regr(kli,"cost_regr_a") + f70_cost_regr(kli,"cost_regr_b")
     *sum((ct, sys_to_kli(sys,kli)),f70_livestock_productivity(ct,i2,sys,"%c70_feed_scen%")));

q70_cost_prod_fish(i2) ..
 vm_cost_prod(i2,"fish") =e=
     vm_prod_reg(i2,"fish")*f70_cost_regr("fish","cost_regr_a");
