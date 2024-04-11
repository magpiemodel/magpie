*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov71_feed_forage(t,j,kforage,"marginal")      = v71_feed_forage.m(j,kforage);
 ov71_additional_mon(t,j,kli_mon,"marginal")   = v71_additional_mon.m(j,kli_mon);
 ov_costs_additional_mon(t,i,"marginal")       = vm_costs_additional_mon.m(i);
 ov71_feed_balanceflow(t,j,kforage,"marginal") = v71_feed_balanceflow.m(j,kforage);
 oq71_feed_rum_liv(t,j,kforage,"marginal")     = q71_feed_rum_liv.m(j,kforage);
 oq71_feed_forage(t,j,"marginal")              = q71_feed_forage.m(j);
 oq71_feed_balanceflow_nlp(t,j,"marginal")     = q71_feed_balanceflow_nlp.m(j);
 oq71_feed_balanceflow_lp(t,i,"marginal")      = q71_feed_balanceflow_lp.m(i);
 oq71_prod_mon_liv(t,j,kli_mon,"marginal")     = q71_prod_mon_liv.m(j,kli_mon);
 oq71_punishment_mon(t,i,"marginal")           = q71_punishment_mon.m(i);
 ov71_feed_forage(t,j,kforage,"level")         = v71_feed_forage.l(j,kforage);
 ov71_additional_mon(t,j,kli_mon,"level")      = v71_additional_mon.l(j,kli_mon);
 ov_costs_additional_mon(t,i,"level")          = vm_costs_additional_mon.l(i);
 ov71_feed_balanceflow(t,j,kforage,"level")    = v71_feed_balanceflow.l(j,kforage);
 oq71_feed_rum_liv(t,j,kforage,"level")        = q71_feed_rum_liv.l(j,kforage);
 oq71_feed_forage(t,j,"level")                 = q71_feed_forage.l(j);
 oq71_feed_balanceflow_nlp(t,j,"level")        = q71_feed_balanceflow_nlp.l(j);
 oq71_feed_balanceflow_lp(t,i,"level")         = q71_feed_balanceflow_lp.l(i);
 oq71_prod_mon_liv(t,j,kli_mon,"level")        = q71_prod_mon_liv.l(j,kli_mon);
 oq71_punishment_mon(t,i,"level")              = q71_punishment_mon.l(i);
 ov71_feed_forage(t,j,kforage,"upper")         = v71_feed_forage.up(j,kforage);
 ov71_additional_mon(t,j,kli_mon,"upper")      = v71_additional_mon.up(j,kli_mon);
 ov_costs_additional_mon(t,i,"upper")          = vm_costs_additional_mon.up(i);
 ov71_feed_balanceflow(t,j,kforage,"upper")    = v71_feed_balanceflow.up(j,kforage);
 oq71_feed_rum_liv(t,j,kforage,"upper")        = q71_feed_rum_liv.up(j,kforage);
 oq71_feed_forage(t,j,"upper")                 = q71_feed_forage.up(j);
 oq71_feed_balanceflow_nlp(t,j,"upper")        = q71_feed_balanceflow_nlp.up(j);
 oq71_feed_balanceflow_lp(t,i,"upper")         = q71_feed_balanceflow_lp.up(i);
 oq71_prod_mon_liv(t,j,kli_mon,"upper")        = q71_prod_mon_liv.up(j,kli_mon);
 oq71_punishment_mon(t,i,"upper")              = q71_punishment_mon.up(i);
 ov71_feed_forage(t,j,kforage,"lower")         = v71_feed_forage.lo(j,kforage);
 ov71_additional_mon(t,j,kli_mon,"lower")      = v71_additional_mon.lo(j,kli_mon);
 ov_costs_additional_mon(t,i,"lower")          = vm_costs_additional_mon.lo(i);
 ov71_feed_balanceflow(t,j,kforage,"lower")    = v71_feed_balanceflow.lo(j,kforage);
 oq71_feed_rum_liv(t,j,kforage,"lower")        = q71_feed_rum_liv.lo(j,kforage);
 oq71_feed_forage(t,j,"lower")                 = q71_feed_forage.lo(j);
 oq71_feed_balanceflow_nlp(t,j,"lower")        = q71_feed_balanceflow_nlp.lo(j);
 oq71_feed_balanceflow_lp(t,i,"lower")         = q71_feed_balanceflow_lp.lo(i);
 oq71_prod_mon_liv(t,j,kli_mon,"lower")        = q71_prod_mon_liv.lo(j,kli_mon);
 oq71_punishment_mon(t,i,"lower")              = q71_punishment_mon.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
