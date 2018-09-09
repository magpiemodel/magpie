*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

positive variables
 v71_prod_rum(j,kli_rum,kforage)                   production of forage fed ruminants within a cell (mio. tDM per yr)
;

variables
 v71_feed_balanceflow(j,kli_rum,kforage)           cellular feed balanceflow for forage feed for ruminant livestock (mio. tDM per yr)
;

equations
 q71_feed_rum_liv(j,kforage)                       production constraint for ruminant livestock products (mio. tDM per yr)
 q71_balanceflow_constraint_nlp(j,kli_rum,kforage) nonlinear balanceflow constraint for cellular forage feed products (mio. tDM per yr)
 q71_balanceflow_constraint_lp(i,kli_rum,kforage)  linear balanceflow constraint for cellular forage feed product (mio. tDM per yr)
 q71_sum_rum_liv(j,kli_rum)                        total production of forage fed ruminants (mio. tDM per yr)
 q71_prod_mon_liv(j,kli_mon)                       production constraint for monogastrics livestock products (mio. tDM per yr)
;

parameters
 i71_urban_area_share(j)                           share of urban area within a region (1)
;

scalars
 s71_lp_fix                                        switch to fix equations to linear relation (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov71_feed_balanceflow(t,j,kli_rum,kforage,type)       cluster feed balance flow for forage feed for ruminant livestock (mio. t DM)
 ov71_prod_rum(t,j,kli_rum,kforage,type)               production of pasture and fodder fed ruminants within a cluster
 oq71_feed_rum_liv(t,j,kforage,type)                   production constraint for ruminant livestock products
 oq71_balanceflow_constraint(t,j,kli_rum,kforage,type) balanceflow constraint for cluster forage feed products
 oq71_prod_mon_liv(t,j,kli_mon,type)                   production constraint for monogastrics livestock products
 oq71_sum_rum_liv(t,j,kli_rum,type)                    total production of pasture and fodder fet ruminants
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
