*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

positive variables
 v71_prod_in(i,kli_rum)              intensive ruminant livestock production (mio. ton DM)
 v71_prod_ex(i,kli_rum)              extensive ruminant livestock production (mio. ton DM)
 ;
 
equations
 q71_prod_in(j,kli_rum)              production constraint for intensive ruminant livestock products
 q71_prod_ex(j,kli_rum)              production constraint for extensive ruminant livestock products
 q71_prod_reg_ex(i, kli_rum)		 production constraint for regional extensive ruminant livestock products	
 q71_prod_rum_liv(j,kli_rum)         production constraint for ruminant livestock products
 q71_prod_mon_liv(j,kli_mon)         production constraint for monogastrics livestock products
 ;

parameters
 i71_share_in_feedmix_reg(t_all,i,kli,kall,dm_ge_nr) regional share of products in feedmix (1)
 i71_share_in_feedmix(t_all,j,kli,kall,dm_ge_nr)     share of products in feedmix (1)
 i71_urban_area_share(j)                             share of urban area within a region (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_feed(t,i,kap,kall,type)    regional feed demand including byproducts (Mt DM)
 oq70_feed(t,i,kap,kall,type)      regional feed demand
 oq70_cost_prod_liv(t,i,kall,type) regional factor input costs for livestock production
 oq70_cost_prod_fish(t,i,type)     regional factor input costs for fish production
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
