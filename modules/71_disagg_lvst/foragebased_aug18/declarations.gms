*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

positive variables
 v71_prod_rum(j,kli_rum,kforage)                   Production of forage fed ruminants within a cell (mio. tDM per yr)
;

variables
 v71_feed_balanceflow(j,kli_rum,kforage)           Cellular feed balanceflow for forage feed for ruminant livestock (mio. tDM per yr)
;

equations
 q71_feed_rum_liv(j,kforage)                       Production constraint for ruminant livestock products (mio. tDM per yr)
 q71_balanceflow_constraint_nlp(j,kli_rum,kforage) Nonlinear balanceflow constraint for cellular forage feed products (mio. tDM per yr)
 q71_balanceflow_constraint_lp(i,kli_rum,kforage)  Linear balanceflow constraint for cellular forage feed product (mio. tDM per yr)
 q71_sum_rum_liv(j,kli_rum)                        Total production of forage fed ruminants (mio. tDM per yr)
 q71_prod_mon_liv(j,kli_mon)                       Production constraint for monogastrics livestock products (mio. tDM per yr)
;

parameters
 i71_urban_area_share(j)                           Share of urban area within a region (1)
;

scalars
 s71_lp_fix                                        Switch to fix equations to linear relation (Logical)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov71_prod_rum(t,j,kli_rum,kforage,type)                   Production of forage fed ruminants within a cell (mio. tDM per yr)
 ov71_feed_balanceflow(t,j,kli_rum,kforage,type)           Cellular feed balanceflow for forage feed for ruminant livestock (mio. tDM per yr)
 oq71_feed_rum_liv(t,j,kforage,type)                       Production constraint for ruminant livestock products (mio. tDM per yr)
 oq71_balanceflow_constraint_nlp(t,j,kli_rum,kforage,type) Nonlinear balanceflow constraint for cellular forage feed products (mio. tDM per yr)
 oq71_balanceflow_constraint_lp(t,i,kli_rum,kforage,type)  Linear balanceflow constraint for cellular forage feed product (mio. tDM per yr)
 oq71_sum_rum_liv(t,j,kli_rum,type)                        Total production of forage fed ruminants (mio. tDM per yr)
 oq71_prod_mon_liv(t,j,kli_mon,type)                       Production constraint for monogastrics livestock products (mio. tDM per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
