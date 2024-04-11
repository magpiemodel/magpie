*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov71_prod_rum(t,j,kli_rum,kforage,"marginal")               = v71_prod_rum.m(j,kli_rum,kforage);
 ov71_additional_mon(t,j,kli_mon,"marginal")                 = v71_additional_mon.m(j,kli_mon);
 ov_costs_additional_mon(t,i,"marginal")                     = vm_costs_additional_mon.m(i);
 ov71_feed_balanceflow_share(t,j,kli_rum,kforage,"marginal") = v71_feed_balanceflow_share.m(j,kli_rum,kforage);
 oq71_feed_rum_liv(t,j,kforage,"marginal")                   = q71_feed_rum_liv.m(j,kforage);
 oq71_balanceflow_constraint(t,j,kli_rum,kforage,"marginal") = q71_balanceflow_constraint.m(j,kli_rum,kforage);
 oq71_sum_rum_liv(t,j,kli_rum,"marginal")                    = q71_sum_rum_liv.m(j,kli_rum);
 oq71_prod_mon_liv(t,j,kli_mon,"marginal")                   = q71_prod_mon_liv.m(j,kli_mon);
 oq71_punishment_mon(t,i,"marginal")                         = q71_punishment_mon.m(i);
 ov71_prod_rum(t,j,kli_rum,kforage,"level")                  = v71_prod_rum.l(j,kli_rum,kforage);
 ov71_additional_mon(t,j,kli_mon,"level")                    = v71_additional_mon.l(j,kli_mon);
 ov_costs_additional_mon(t,i,"level")                        = vm_costs_additional_mon.l(i);
 ov71_feed_balanceflow_share(t,j,kli_rum,kforage,"level")    = v71_feed_balanceflow_share.l(j,kli_rum,kforage);
 oq71_feed_rum_liv(t,j,kforage,"level")                      = q71_feed_rum_liv.l(j,kforage);
 oq71_balanceflow_constraint(t,j,kli_rum,kforage,"level")    = q71_balanceflow_constraint.l(j,kli_rum,kforage);
 oq71_sum_rum_liv(t,j,kli_rum,"level")                       = q71_sum_rum_liv.l(j,kli_rum);
 oq71_prod_mon_liv(t,j,kli_mon,"level")                      = q71_prod_mon_liv.l(j,kli_mon);
 oq71_punishment_mon(t,i,"level")                            = q71_punishment_mon.l(i);
 ov71_prod_rum(t,j,kli_rum,kforage,"upper")                  = v71_prod_rum.up(j,kli_rum,kforage);
 ov71_additional_mon(t,j,kli_mon,"upper")                    = v71_additional_mon.up(j,kli_mon);
 ov_costs_additional_mon(t,i,"upper")                        = vm_costs_additional_mon.up(i);
 ov71_feed_balanceflow_share(t,j,kli_rum,kforage,"upper")    = v71_feed_balanceflow_share.up(j,kli_rum,kforage);
 oq71_feed_rum_liv(t,j,kforage,"upper")                      = q71_feed_rum_liv.up(j,kforage);
 oq71_balanceflow_constraint(t,j,kli_rum,kforage,"upper")    = q71_balanceflow_constraint.up(j,kli_rum,kforage);
 oq71_sum_rum_liv(t,j,kli_rum,"upper")                       = q71_sum_rum_liv.up(j,kli_rum);
 oq71_prod_mon_liv(t,j,kli_mon,"upper")                      = q71_prod_mon_liv.up(j,kli_mon);
 oq71_punishment_mon(t,i,"upper")                            = q71_punishment_mon.up(i);
 ov71_prod_rum(t,j,kli_rum,kforage,"lower")                  = v71_prod_rum.lo(j,kli_rum,kforage);
 ov71_additional_mon(t,j,kli_mon,"lower")                    = v71_additional_mon.lo(j,kli_mon);
 ov_costs_additional_mon(t,i,"lower")                        = vm_costs_additional_mon.lo(i);
 ov71_feed_balanceflow_share(t,j,kli_rum,kforage,"lower")    = v71_feed_balanceflow_share.lo(j,kli_rum,kforage);
 oq71_feed_rum_liv(t,j,kforage,"lower")                      = q71_feed_rum_liv.lo(j,kforage);
 oq71_balanceflow_constraint(t,j,kli_rum,kforage,"lower")    = q71_balanceflow_constraint.lo(j,kli_rum,kforage);
 oq71_sum_rum_liv(t,j,kli_rum,"lower")                       = q71_sum_rum_liv.lo(j,kli_rum);
 oq71_prod_mon_liv(t,j,kli_mon,"lower")                      = q71_prod_mon_liv.lo(j,kli_mon);
 oq71_punishment_mon(t,i,"lower")                            = q71_punishment_mon.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
