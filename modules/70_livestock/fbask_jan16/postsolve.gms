*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_feed(t,i,kap,kall,"marginal")   = vm_dem_feed.m(i,kap,kall);
 ov_cost_prod_livst(t,i,req,"marginal") = vm_cost_prod_livst.m(i,req);
 ov_cost_prod_fish(t,i,"marginal")      = vm_cost_prod_fish.m(i);
 oq70_feed(t,i,kap,kall,"marginal")     = q70_feed.m(i,kap,kall);
 oq70_cost_prod_liv(t,i,req,"marginal") = q70_cost_prod_liv.m(i,req);
 oq70_cost_prod_fish(t,i,"marginal")    = q70_cost_prod_fish.m(i);
 ov_dem_feed(t,i,kap,kall,"level")      = vm_dem_feed.l(i,kap,kall);
 ov_cost_prod_livst(t,i,req,"level")    = vm_cost_prod_livst.l(i,req);
 ov_cost_prod_fish(t,i,"level")         = vm_cost_prod_fish.l(i);
 oq70_feed(t,i,kap,kall,"level")        = q70_feed.l(i,kap,kall);
 oq70_cost_prod_liv(t,i,req,"level")    = q70_cost_prod_liv.l(i,req);
 oq70_cost_prod_fish(t,i,"level")       = q70_cost_prod_fish.l(i);
 ov_dem_feed(t,i,kap,kall,"upper")      = vm_dem_feed.up(i,kap,kall);
 ov_cost_prod_livst(t,i,req,"upper")    = vm_cost_prod_livst.up(i,req);
 ov_cost_prod_fish(t,i,"upper")         = vm_cost_prod_fish.up(i);
 oq70_feed(t,i,kap,kall,"upper")        = q70_feed.up(i,kap,kall);
 oq70_cost_prod_liv(t,i,req,"upper")    = q70_cost_prod_liv.up(i,req);
 oq70_cost_prod_fish(t,i,"upper")       = q70_cost_prod_fish.up(i);
 ov_dem_feed(t,i,kap,kall,"lower")      = vm_dem_feed.lo(i,kap,kall);
 ov_cost_prod_livst(t,i,req,"lower")    = vm_cost_prod_livst.lo(i,req);
 ov_cost_prod_fish(t,i,"lower")         = vm_cost_prod_fish.lo(i);
 oq70_feed(t,i,kap,kall,"lower")        = q70_feed.lo(i,kap,kall);
 oq70_cost_prod_liv(t,i,req,"lower")    = q70_cost_prod_liv.lo(i,req);
 oq70_cost_prod_fish(t,i,"lower")       = q70_cost_prod_fish.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
