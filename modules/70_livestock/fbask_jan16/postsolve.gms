*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


pc70_dem_feed_pasture(i,kli_rum) = max(vm_dem_feed.l(i,kli_rum,"pasture"), 0.001);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov70_feed_intake_pre(t,i,kap,kall,"marginal") = v70_feed_intake_pre.m(i,kap,kall);
 ov_dem_feed(t,i,kap,kall,"marginal")          = vm_dem_feed.m(i,kap,kall);
 ov_cost_prod_livst(t,i,factors,"marginal")    = vm_cost_prod_livst.m(i,factors);
 ov_cost_prod_fish(t,i,"marginal")             = vm_cost_prod_fish.m(i);
 ov_feed_balanceflow(t,i,kap,kall,"marginal")  = vm_feed_balanceflow.m(i,kap,kall);
 ov_feed_intake(t,i,kap,kall,"marginal")       = vm_feed_intake.m(i,kap,kall);
 oq70_feed_intake_pre(t,i,kap,kall,"marginal") = q70_feed_intake_pre.m(i,kap,kall);
 oq70_feed_intake(t,i,kap,kall,"marginal")     = q70_feed_intake.m(i,kap,kall);
 oq70_feed(t,i,kap,kall,"marginal")            = q70_feed.m(i,kap,kall);
 oq70_feed_balanceflow(t,i,kli_rum,"marginal") = q70_feed_balanceflow.m(i,kli_rum);
 oq70_cost_prod_liv_labor(t,i,"marginal")      = q70_cost_prod_liv_labor.m(i);
 oq70_cost_prod_liv_capital(t,i,"marginal")    = q70_cost_prod_liv_capital.m(i);
 oq70_cost_prod_fish(t,i,"marginal")           = q70_cost_prod_fish.m(i);
 ov70_feed_intake_pre(t,i,kap,kall,"level")    = v70_feed_intake_pre.l(i,kap,kall);
 ov_dem_feed(t,i,kap,kall,"level")             = vm_dem_feed.l(i,kap,kall);
 ov_cost_prod_livst(t,i,factors,"level")       = vm_cost_prod_livst.l(i,factors);
 ov_cost_prod_fish(t,i,"level")                = vm_cost_prod_fish.l(i);
 ov_feed_balanceflow(t,i,kap,kall,"level")     = vm_feed_balanceflow.l(i,kap,kall);
 ov_feed_intake(t,i,kap,kall,"level")          = vm_feed_intake.l(i,kap,kall);
 oq70_feed_intake_pre(t,i,kap,kall,"level")    = q70_feed_intake_pre.l(i,kap,kall);
 oq70_feed_intake(t,i,kap,kall,"level")        = q70_feed_intake.l(i,kap,kall);
 oq70_feed(t,i,kap,kall,"level")               = q70_feed.l(i,kap,kall);
 oq70_feed_balanceflow(t,i,kli_rum,"level")    = q70_feed_balanceflow.l(i,kli_rum);
 oq70_cost_prod_liv_labor(t,i,"level")         = q70_cost_prod_liv_labor.l(i);
 oq70_cost_prod_liv_capital(t,i,"level")       = q70_cost_prod_liv_capital.l(i);
 oq70_cost_prod_fish(t,i,"level")              = q70_cost_prod_fish.l(i);
 ov70_feed_intake_pre(t,i,kap,kall,"upper")    = v70_feed_intake_pre.up(i,kap,kall);
 ov_dem_feed(t,i,kap,kall,"upper")             = vm_dem_feed.up(i,kap,kall);
 ov_cost_prod_livst(t,i,factors,"upper")       = vm_cost_prod_livst.up(i,factors);
 ov_cost_prod_fish(t,i,"upper")                = vm_cost_prod_fish.up(i);
 ov_feed_balanceflow(t,i,kap,kall,"upper")     = vm_feed_balanceflow.up(i,kap,kall);
 ov_feed_intake(t,i,kap,kall,"upper")          = vm_feed_intake.up(i,kap,kall);
 oq70_feed_intake_pre(t,i,kap,kall,"upper")    = q70_feed_intake_pre.up(i,kap,kall);
 oq70_feed_intake(t,i,kap,kall,"upper")        = q70_feed_intake.up(i,kap,kall);
 oq70_feed(t,i,kap,kall,"upper")               = q70_feed.up(i,kap,kall);
 oq70_feed_balanceflow(t,i,kli_rum,"upper")    = q70_feed_balanceflow.up(i,kli_rum);
 oq70_cost_prod_liv_labor(t,i,"upper")         = q70_cost_prod_liv_labor.up(i);
 oq70_cost_prod_liv_capital(t,i,"upper")       = q70_cost_prod_liv_capital.up(i);
 oq70_cost_prod_fish(t,i,"upper")              = q70_cost_prod_fish.up(i);
 ov70_feed_intake_pre(t,i,kap,kall,"lower")    = v70_feed_intake_pre.lo(i,kap,kall);
 ov_dem_feed(t,i,kap,kall,"lower")             = vm_dem_feed.lo(i,kap,kall);
 ov_cost_prod_livst(t,i,factors,"lower")       = vm_cost_prod_livst.lo(i,factors);
 ov_cost_prod_fish(t,i,"lower")                = vm_cost_prod_fish.lo(i);
 ov_feed_balanceflow(t,i,kap,kall,"lower")     = vm_feed_balanceflow.lo(i,kap,kall);
 ov_feed_intake(t,i,kap,kall,"lower")          = vm_feed_intake.lo(i,kap,kall);
 oq70_feed_intake_pre(t,i,kap,kall,"lower")    = q70_feed_intake_pre.lo(i,kap,kall);
 oq70_feed_intake(t,i,kap,kall,"lower")        = q70_feed_intake.lo(i,kap,kall);
 oq70_feed(t,i,kap,kall,"lower")               = q70_feed.lo(i,kap,kall);
 oq70_feed_balanceflow(t,i,kli_rum,"lower")    = q70_feed_balanceflow.lo(i,kli_rum);
 oq70_cost_prod_liv_labor(t,i,"lower")         = q70_cost_prod_liv_labor.lo(i);
 oq70_cost_prod_liv_capital(t,i,"lower")       = q70_cost_prod_liv_capital.lo(i);
 oq70_cost_prod_fish(t,i,"lower")              = q70_cost_prod_fish.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
