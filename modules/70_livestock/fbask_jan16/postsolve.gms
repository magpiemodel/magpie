*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

 

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_feed(t,i,kap,kall,"marginal")   = vm_dem_feed.m(i,kap,kall);
 oq70_feed(t,i,kap,kall,"marginal")     = q70_feed.m(i,kap,kall);
 oq70_cost_prod_liv(t,i,kli,"marginal") = q70_cost_prod_liv.m(i,kli);
 ov_dem_feed(t,i,kap,kall,"level")      = vm_dem_feed.l(i,kap,kall);
 oq70_feed(t,i,kap,kall,"level")        = q70_feed.l(i,kap,kall);
 oq70_cost_prod_liv(t,i,kli,"level")    = q70_cost_prod_liv.l(i,kli);
 ov_dem_feed(t,i,kap,kall,"upper")      = vm_dem_feed.up(i,kap,kall);
 oq70_feed(t,i,kap,kall,"upper")        = q70_feed.up(i,kap,kall);
 oq70_cost_prod_liv(t,i,kli,"upper")    = q70_cost_prod_liv.up(i,kli);
 ov_dem_feed(t,i,kap,kall,"lower")      = vm_dem_feed.lo(i,kap,kall);
 oq70_feed(t,i,kap,kall,"lower")        = q70_feed.lo(i,kap,kall);
 oq70_cost_prod_liv(t,i,kli,"lower")    = q70_cost_prod_liv.lo(i,kli);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

