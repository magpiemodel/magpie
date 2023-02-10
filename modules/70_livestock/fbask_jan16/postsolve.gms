*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_feed(t,i,kap,kall,"marginal")       = vm_dem_feed.m(i,kap,kall);
 ov_cost_prod_livst(t,i,factors,"marginal") = vm_cost_prod_livst.m(i,factors);
 ov_cost_prod_fish(t,i,"marginal")          = vm_cost_prod_fish.m(i);
 oq70_feed(t,i,kap,kall,"marginal")         = q70_feed.m(i,kap,kall);
 oq70_cost_prod_liv_labor(t,i,"marginal")   = q70_cost_prod_liv_labor.m(i);
 oq70_cost_prod_liv_capital(t,i,"marginal") = q70_cost_prod_liv_capital.m(i);
 oq70_cost_prod_fish(t,i,"marginal")        = q70_cost_prod_fish.m(i);
 ov_dem_feed(t,i,kap,kall,"level")          = vm_dem_feed.l(i,kap,kall);
 ov_cost_prod_livst(t,i,factors,"level")    = vm_cost_prod_livst.l(i,factors);
 ov_cost_prod_fish(t,i,"level")             = vm_cost_prod_fish.l(i);
 oq70_feed(t,i,kap,kall,"level")            = q70_feed.l(i,kap,kall);
 oq70_cost_prod_liv_labor(t,i,"level")      = q70_cost_prod_liv_labor.l(i);
 oq70_cost_prod_liv_capital(t,i,"level")    = q70_cost_prod_liv_capital.l(i);
 oq70_cost_prod_fish(t,i,"level")           = q70_cost_prod_fish.l(i);
 ov_dem_feed(t,i,kap,kall,"upper")          = vm_dem_feed.up(i,kap,kall);
 ov_cost_prod_livst(t,i,factors,"upper")    = vm_cost_prod_livst.up(i,factors);
 ov_cost_prod_fish(t,i,"upper")             = vm_cost_prod_fish.up(i);
 oq70_feed(t,i,kap,kall,"upper")            = q70_feed.up(i,kap,kall);
 oq70_cost_prod_liv_labor(t,i,"upper")      = q70_cost_prod_liv_labor.up(i);
 oq70_cost_prod_liv_capital(t,i,"upper")    = q70_cost_prod_liv_capital.up(i);
 oq70_cost_prod_fish(t,i,"upper")           = q70_cost_prod_fish.up(i);
 ov_dem_feed(t,i,kap,kall,"lower")          = vm_dem_feed.lo(i,kap,kall);
 ov_cost_prod_livst(t,i,factors,"lower")    = vm_cost_prod_livst.lo(i,factors);
 ov_cost_prod_fish(t,i,"lower")             = vm_cost_prod_fish.lo(i);
 oq70_feed(t,i,kap,kall,"lower")            = q70_feed.lo(i,kap,kall);
 oq70_cost_prod_liv_labor(t,i,"lower")      = q70_cost_prod_liv_labor.lo(i);
 oq70_cost_prod_liv_capital(t,i,"lower")    = q70_cost_prod_liv_capital.lo(i);
 oq70_cost_prod_fish(t,i,"lower")           = q70_cost_prod_fish.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
