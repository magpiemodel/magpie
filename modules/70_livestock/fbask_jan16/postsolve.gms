*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_feed(t,i,kap,kagri,"marginal")  = vm_dem_feed.m(i,kap,kagri);
 oq70_feed(t,i,kap,kagri,"marginal")    = q70_feed.m(i,kap,kagri);
 oq70_cost_prod_liv(t,i,kli,"marginal") = q70_cost_prod_liv.m(i,kli);
 ov_dem_feed(t,i,kap,kagri,"level")     = vm_dem_feed.l(i,kap,kagri);
 oq70_feed(t,i,kap,kagri,"level")       = q70_feed.l(i,kap,kagri);
 oq70_cost_prod_liv(t,i,kli,"level")    = q70_cost_prod_liv.l(i,kli);
 ov_dem_feed(t,i,kap,kagri,"upper")     = vm_dem_feed.up(i,kap,kagri);
 oq70_feed(t,i,kap,kagri,"upper")       = q70_feed.up(i,kap,kagri);
 oq70_cost_prod_liv(t,i,kli,"upper")    = q70_cost_prod_liv.up(i,kli);
 ov_dem_feed(t,i,kap,kagri,"lower")     = vm_dem_feed.lo(i,kap,kagri);
 oq70_feed(t,i,kap,kagri,"lower")       = q70_feed.lo(i,kap,kagri);
 oq70_cost_prod_liv(t,i,kli,"lower")    = q70_cost_prod_liv.lo(i,kli);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################