*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

variables
 v71_feed_balanceflow(j,kli_rum,kforage)  cluster feed balance flow for forage feed for ruminant livestock (mio. t DM)
 ;
 
equations
 q71_feed_rum_liv(j,kforage)             production constraint for ruminant livestock products
 q71_balanceflow_constrain(i,kforage)    balanceflow constraint for cluster forage feed products 
 q71_prod_mon_liv(j,kli_mon)              production constraint for monogastrics livestock products
 ;

parameters
 i71_urban_area_share(j)                             share of urban area within a region (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov71_feed_balanceflow(t,j,kli_rum,kforage,type) cluster feed balance flow for forage feed for ruminant livestock (mio. t DM)
 oq71_feed_rum_liv(t,j2,kforage,type)            production constraint for ruminant livestock products
 oq71_balanceflow_constrain(t,i2,kforage,type)   balanceflow constraint for cluster forage feed products 
 oq71_prod_mon_liv(t,j,kli_mon,type)             production constraint for monogastrics livestock products
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
