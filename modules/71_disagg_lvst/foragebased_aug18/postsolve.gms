*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov71_prod_rum(t,j,kli_rum,kforage,"marginal")                   = v71_prod_rum.m(j,kli_rum,kforage);
 ov71_additional_mon(t,j,kli_mon,"marginal")                     = v71_additional_mon.m(j,kli_mon);
 ov_costs_additional_mon(t,i,"marginal")                         = vm_costs_additional_mon.m(i);
 ov71_feed_balanceflow(t,j,kli_rum,kforage,"marginal")           = v71_feed_balanceflow.m(j,kli_rum,kforage);
 oq71_feed_rum_liv(t,j,kforage,"marginal")                       = q71_feed_rum_liv.m(j,kforage);
 oq71_balanceflow_constraint_nlp(t,j,kli_rum,kforage,"marginal") = q71_balanceflow_constraint_nlp.m(j,kli_rum,kforage);
 oq71_balanceflow_constraint_lp(t,i,kli_rum,kforage,"marginal")  = q71_balanceflow_constraint_lp.m(i,kli_rum,kforage);
 oq71_sum_rum_liv(t,j,kli_rum,"marginal")                        = q71_sum_rum_liv.m(j,kli_rum);
 oq71_prod_mon_liv(t,j,kli_mon,"marginal")                       = q71_prod_mon_liv.m(j,kli_mon);
 oq71_punishment_mon(t,i,"marginal")                             = q71_punishment_mon.m(i);
 ov71_prod_rum(t,j,kli_rum,kforage,"level")                      = v71_prod_rum.l(j,kli_rum,kforage);
 ov71_additional_mon(t,j,kli_mon,"level")                        = v71_additional_mon.l(j,kli_mon);
 ov_costs_additional_mon(t,i,"level")                            = vm_costs_additional_mon.l(i);
 ov71_feed_balanceflow(t,j,kli_rum,kforage,"level")              = v71_feed_balanceflow.l(j,kli_rum,kforage);
 oq71_feed_rum_liv(t,j,kforage,"level")                          = q71_feed_rum_liv.l(j,kforage);
 oq71_balanceflow_constraint_nlp(t,j,kli_rum,kforage,"level")    = q71_balanceflow_constraint_nlp.l(j,kli_rum,kforage);
 oq71_balanceflow_constraint_lp(t,i,kli_rum,kforage,"level")     = q71_balanceflow_constraint_lp.l(i,kli_rum,kforage);
 oq71_sum_rum_liv(t,j,kli_rum,"level")                           = q71_sum_rum_liv.l(j,kli_rum);
 oq71_prod_mon_liv(t,j,kli_mon,"level")                          = q71_prod_mon_liv.l(j,kli_mon);
 oq71_punishment_mon(t,i,"level")                                = q71_punishment_mon.l(i);
 ov71_prod_rum(t,j,kli_rum,kforage,"upper")                      = v71_prod_rum.up(j,kli_rum,kforage);
 ov71_additional_mon(t,j,kli_mon,"upper")                        = v71_additional_mon.up(j,kli_mon);
 ov_costs_additional_mon(t,i,"upper")                            = vm_costs_additional_mon.up(i);
 ov71_feed_balanceflow(t,j,kli_rum,kforage,"upper")              = v71_feed_balanceflow.up(j,kli_rum,kforage);
 oq71_feed_rum_liv(t,j,kforage,"upper")                          = q71_feed_rum_liv.up(j,kforage);
 oq71_balanceflow_constraint_nlp(t,j,kli_rum,kforage,"upper")    = q71_balanceflow_constraint_nlp.up(j,kli_rum,kforage);
 oq71_balanceflow_constraint_lp(t,i,kli_rum,kforage,"upper")     = q71_balanceflow_constraint_lp.up(i,kli_rum,kforage);
 oq71_sum_rum_liv(t,j,kli_rum,"upper")                           = q71_sum_rum_liv.up(j,kli_rum);
 oq71_prod_mon_liv(t,j,kli_mon,"upper")                          = q71_prod_mon_liv.up(j,kli_mon);
 oq71_punishment_mon(t,i,"upper")                                = q71_punishment_mon.up(i);
 ov71_prod_rum(t,j,kli_rum,kforage,"lower")                      = v71_prod_rum.lo(j,kli_rum,kforage);
 ov71_additional_mon(t,j,kli_mon,"lower")                        = v71_additional_mon.lo(j,kli_mon);
 ov_costs_additional_mon(t,i,"lower")                            = vm_costs_additional_mon.lo(i);
 ov71_feed_balanceflow(t,j,kli_rum,kforage,"lower")              = v71_feed_balanceflow.lo(j,kli_rum,kforage);
 oq71_feed_rum_liv(t,j,kforage,"lower")                          = q71_feed_rum_liv.lo(j,kforage);
 oq71_balanceflow_constraint_nlp(t,j,kli_rum,kforage,"lower")    = q71_balanceflow_constraint_nlp.lo(j,kli_rum,kforage);
 oq71_balanceflow_constraint_lp(t,i,kli_rum,kforage,"lower")     = q71_balanceflow_constraint_lp.lo(i,kli_rum,kforage);
 oq71_sum_rum_liv(t,j,kli_rum,"lower")                           = q71_sum_rum_liv.lo(j,kli_rum);
 oq71_prod_mon_liv(t,j,kli_mon,"lower")                          = q71_prod_mon_liv.lo(j,kli_mon);
 oq71_punishment_mon(t,i,"lower")                                = q71_punishment_mon.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
