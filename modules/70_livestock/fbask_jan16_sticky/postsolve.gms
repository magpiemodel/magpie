*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' Capital update from the last investment
p70_capital(t+1,i,kli) = p70_capital(t,i,kli) + v70_investment.l(i,kli);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_feed(t,i,kap,kall,"marginal")       = vm_dem_feed.m(i,kap,kall);
 ov_cost_prod_livst(t,i,factors,"marginal") = vm_cost_prod_livst.m(i,factors);
 ov_cost_prod_fish(t,i,"marginal")          = vm_cost_prod_fish.m(i);
 ov70_investment(t,i,kli,"marginal")        = v70_investment.m(i,kli);
 oq70_feed(t,i,kap,kall,"marginal")         = q70_feed.m(i,kap,kall);
 oq70_cost_prod_liv_labor(t,i,"marginal")   = q70_cost_prod_liv_labor.m(i);
 oq70_cost_prod_liv_capital(t,i,"marginal") = q70_cost_prod_liv_capital.m(i);
 oq70_investment(t,i,kli,"marginal")        = q70_investment.m(i,kli);
 oq70_cost_prod_fish(t,i,"marginal")        = q70_cost_prod_fish.m(i);
 ov_dem_feed(t,i,kap,kall,"level")          = vm_dem_feed.l(i,kap,kall);
 ov_cost_prod_livst(t,i,factors,"level")    = vm_cost_prod_livst.l(i,factors);
 ov_cost_prod_fish(t,i,"level")             = vm_cost_prod_fish.l(i);
 ov70_investment(t,i,kli,"level")           = v70_investment.l(i,kli);
 oq70_feed(t,i,kap,kall,"level")            = q70_feed.l(i,kap,kall);
 oq70_cost_prod_liv_labor(t,i,"level")      = q70_cost_prod_liv_labor.l(i);
 oq70_cost_prod_liv_capital(t,i,"level")    = q70_cost_prod_liv_capital.l(i);
 oq70_investment(t,i,kli,"level")           = q70_investment.l(i,kli);
 oq70_cost_prod_fish(t,i,"level")           = q70_cost_prod_fish.l(i);
 ov_dem_feed(t,i,kap,kall,"upper")          = vm_dem_feed.up(i,kap,kall);
 ov_cost_prod_livst(t,i,factors,"upper")    = vm_cost_prod_livst.up(i,factors);
 ov_cost_prod_fish(t,i,"upper")             = vm_cost_prod_fish.up(i);
 ov70_investment(t,i,kli,"upper")           = v70_investment.up(i,kli);
 oq70_feed(t,i,kap,kall,"upper")            = q70_feed.up(i,kap,kall);
 oq70_cost_prod_liv_labor(t,i,"upper")      = q70_cost_prod_liv_labor.up(i);
 oq70_cost_prod_liv_capital(t,i,"upper")    = q70_cost_prod_liv_capital.up(i);
 oq70_investment(t,i,kli,"upper")           = q70_investment.up(i,kli);
 oq70_cost_prod_fish(t,i,"upper")           = q70_cost_prod_fish.up(i);
 ov_dem_feed(t,i,kap,kall,"lower")          = vm_dem_feed.lo(i,kap,kall);
 ov_cost_prod_livst(t,i,factors,"lower")    = vm_cost_prod_livst.lo(i,factors);
 ov_cost_prod_fish(t,i,"lower")             = vm_cost_prod_fish.lo(i);
 ov70_investment(t,i,kli,"lower")           = v70_investment.lo(i,kli);
 oq70_feed(t,i,kap,kall,"lower")            = q70_feed.lo(i,kap,kall);
 oq70_cost_prod_liv_labor(t,i,"lower")      = q70_cost_prod_liv_labor.lo(i);
 oq70_cost_prod_liv_capital(t,i,"lower")    = q70_cost_prod_liv_capital.lo(i);
 oq70_investment(t,i,kli,"lower")           = q70_investment.lo(i,kli);
 oq70_cost_prod_fish(t,i,"lower")           = q70_cost_prod_fish.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

