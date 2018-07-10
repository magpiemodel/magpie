*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_dem_feed(i,kap,kall)          Regional feed demand including byproducts (mio. tDM per yr)
;

equations
 q70_feed(i,kap,kall)             Regional feed demand
 q70_cost_prod_liv(i,kall)        Regional factor input costs for livestock production
 q70_cost_prod_fish(i)            Regional factor input costs for fish production
;

parameters
 im_slaughter_feed_share(t_all,i,kap,attributes) Share of feed that is incorporated in animal biomass (1)
 im_livestock_productivity(t_all,i,sys)          Productivity indicator for livestock production (t FM per animal per yr)
 im_feed_baskets(t_all,i,kap,kall) feed baskets (t DM per t DM livestock product)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_feed(t,i,kap,kall,type)    Regional feed demand including byproducts (mio. tDM per yr)
 oq70_feed(t,i,kap,kall,type)      Regional feed demand
 oq70_cost_prod_liv(t,i,kall,type) Regional factor input costs for livestock production
 oq70_cost_prod_fish(t,i,type)     Regional factor input costs for fish production
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
