*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

variables
 v71_feed_balanceflow(j,kli_rum,kforage)    cluster feed balance flow for forage feed for ruminant livestock (mio. t DM)
;

positive variables
 v71_prod_rum(j,kli_rum,kforage)            production of pasture and fodder fet ruminants within a cluster
;
 
equations
 q71_feed_rum_liv(j,kforage)                production constraint for ruminant livestock products
 q71_balanceflow_constrain(j,kli_rum,kforage)    balanceflow constraint for cluster forage feed products
 q71_prod_mon_liv(j,kli_mon)                production constraint for monogastrics livestock products
 q71_sum_rum_liv(j,kli_rum)                 total production of pasture and fodder fet ruminants
 ;

parameters
 i71_urban_area_share(j)                    share of urban area within a region (1)
 pc71_prod_reg(i,kli_rum)                   regional ruminant production of previous time step (mio. tDM per yr)
;

scalars
 s71_lp_nlp									switch to change between linear (1) and non-linear (0) version of q71_feed_rum_liv
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov71_prod_rum(t,j,kli_rum,kforage,type) production of pasture and fodder fet ruminants within a cluster
 oq71_feed_rum_liv(t,j,kforage,type)     production constraint for ruminant livestock products
 oq71_prod_mon_liv(t,j,kli_mon,type)     production constraint for monogastrics livestock products
 oq71_sum_rum_liv(t,j,kli_rum,type)      total production of pasture and fodder fet ruminants
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
