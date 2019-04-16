*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_feed(t,i,kap,kall,"marginal")    = vm_dem_feed.m(i,kap,kall);
 oq70_feed(t,i,kap,kall,"marginal")      = q70_feed.m(i,kap,kall);
 oq70_cost_prod_liv(t,i,kall,"marginal") = q70_cost_prod_liv.m(i,kall);
 oq70_cost_prod_fish(t,i,"marginal")     = q70_cost_prod_fish.m(i);
 ov_dem_feed(t,i,kap,kall,"level")       = vm_dem_feed.l(i,kap,kall);
 oq70_feed(t,i,kap,kall,"level")         = q70_feed.l(i,kap,kall);
 oq70_cost_prod_liv(t,i,kall,"level")    = q70_cost_prod_liv.l(i,kall);
 oq70_cost_prod_fish(t,i,"level")        = q70_cost_prod_fish.l(i);
 ov_dem_feed(t,i,kap,kall,"upper")       = vm_dem_feed.up(i,kap,kall);
 oq70_feed(t,i,kap,kall,"upper")         = q70_feed.up(i,kap,kall);
 oq70_cost_prod_liv(t,i,kall,"upper")    = q70_cost_prod_liv.up(i,kall);
 oq70_cost_prod_fish(t,i,"upper")        = q70_cost_prod_fish.up(i);
 ov_dem_feed(t,i,kap,kall,"lower")       = vm_dem_feed.lo(i,kap,kall);
 oq70_feed(t,i,kap,kall,"lower")         = q70_feed.lo(i,kap,kall);
 oq70_cost_prod_liv(t,i,kall,"lower")    = q70_cost_prod_liv.lo(i,kall);
 oq70_cost_prod_fish(t,i,"lower")        = q70_cost_prod_fish.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
