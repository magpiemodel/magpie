*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_dem_feed(i,kap,kall)          regional feed demand including byproducts (mio. tDM)
;

equations
 q70_feed(i,kap,kall)             regional feed demand
 q70_cost_prod_liv(i,kall)         regional factor input costs for livestock production
 q70_cost_prod_fish(i)               regional factor input costs for fish production
;

parameters
 im_slaughter_feed_share(t_all,i,kap,attributes) share of feed that is incorprated in animal biomass (1)
 im_livestock_productivity(t_all,i,sys)                  productivity indicator for livestock production (t FM per animal)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_feed(t,i,kap,kall,type)    regional feed demand including byproducts (mio. tDM)
 oq70_feed(t,i,kap,kall,type)      regional feed demand
 oq70_cost_prod_liv(t,i,kall,type) regional factor input costs for livestock production
 oq70_cost_prod_fish(t,i,type)     regional factor input costs for fish production
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
