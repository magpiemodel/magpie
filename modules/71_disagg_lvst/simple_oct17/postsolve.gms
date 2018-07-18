*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov71_feed_balanceflow(t,j,kli_rum,kforage,"marginal") = v71_feed_balanceflow.m(j,kli_rum,kforage);
 oq71_feed_rum_liv(t,j,kforage,"marginal")             = q71_feed_rum_liv.m(j,kforage);
 oq71_balanceflow_constrain(t,i,kforage,"marginal")    = q71_balanceflow_constrain.m(i,kforage);
 oq71_prod_mon_liv(t,j,kli_mon,"marginal")             = q71_prod_mon_liv.m(j,kli_mon);
 ov71_feed_balanceflow(t,j,kli_rum,kforage,"level")    = v71_feed_balanceflow.l(j,kli_rum,kforage);
 oq71_feed_rum_liv(t,j,kforage,"level")                = q71_feed_rum_liv.l(j,kforage);
 oq71_balanceflow_constrain(t,i,kforage,"level")       = q71_balanceflow_constrain.l(i,kforage);
 oq71_prod_mon_liv(t,j,kli_mon,"level")                = q71_prod_mon_liv.l(j,kli_mon);
 ov71_feed_balanceflow(t,j,kli_rum,kforage,"upper")    = v71_feed_balanceflow.up(j,kli_rum,kforage);
 oq71_feed_rum_liv(t,j,kforage,"upper")                = q71_feed_rum_liv.up(j,kforage);
 oq71_balanceflow_constrain(t,i,kforage,"upper")       = q71_balanceflow_constrain.up(i,kforage);
 oq71_prod_mon_liv(t,j,kli_mon,"upper")                = q71_prod_mon_liv.up(j,kli_mon);
 ov71_feed_balanceflow(t,j,kli_rum,kforage,"lower")    = v71_feed_balanceflow.lo(j,kli_rum,kforage);
 oq71_feed_rum_liv(t,j,kforage,"lower")                = q71_feed_rum_liv.lo(j,kforage);
 oq71_balanceflow_constrain(t,i,kforage,"lower")       = q71_balanceflow_constrain.lo(i,kforage);
 oq71_prod_mon_liv(t,j,kli_mon,"lower")                = q71_prod_mon_liv.lo(j,kli_mon);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
