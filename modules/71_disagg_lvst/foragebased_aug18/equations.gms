*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Ruminant livestock production within a cell is determined by the production of the non-transportable
*' feed items grazed pasture and fodder. These must be larger than the ruminant feed requirements
*' that are given by the product of ruminant production and the respective feed baskets:

q71_feed_rum_liv(j2,kforage) ..
                 vm_prod(j2,kforage) =g=
                  sum(kli_rum, v71_prod_rum(j2,kli_rum,kforage)
                 * sum((ct,cell(i2,j2),kforage2),im_feed_baskets(ct,i2,kli_rum,kforage2))
				 * (1 + v71_feed_balanceflow(j2,kli_rum,kforage)$(s71_lp_fix=0))
				 + v71_feed_balanceflow(j2,kli_rum,kforage)$(s71_lp_fix=1))
				 ;


*' The above equation contains a split of pasture and fodder fed ruminants, since we assume that depending
*' on the intensity level of the livestock production, ruminants will graze on pastures (extensive systems)
*' or will be fed via harvested fodder crops (intensive systems).
*' Please note that `s71_lp_fix` is set to zero (for more information please look into the source code).

*' The balance flow for pasture and fodder (summarized with forage) production, accounts as in
*' [70_livestock] `q70_feed(i2,kap,kall)` for inconsistencies with the FAO inventory of national feed use.

*' @stop

* If module is fixed to linear behaviour the balance flow is allowed to be used in any cell
* containing pasture or cropland area in the previous time step ensured by the restrictions
* in the nl_fix statement. The balance flow within a region is then determined by

q71_balanceflow_constraint_lp(i2,kli_rum,kforage)$(s71_lp_fix=1) ..
                 sum(ct, fm_feed_balanceflow(ct,i2,kli_rum,kforage)) =e=
                  sum(cell(i2,j2), v71_feed_balanceflow(j2,kli_rum,kforage))
                 ;

* Note that for fixation to linear behaviour `q71_balanceflow_constraint_lp` replaces `q71_balanceflow_constraint_nlp`.

*' @equations

*' In each cluster the balance flow is constrained by its share of livestock production regarding the regional level by

q71_balanceflow_constraint_nlp(j2,kli_rum,kforage)$(s71_lp_fix=0) ..
		         v71_feed_balanceflow(j2,kli_rum,kforage) =e=
		         sum((ct,cell(i2,j2)),fm_feed_balanceflow(ct,i2,kli_rum,kforage)
				 /(im_feed_baskets(ct,i2,kli_rum,kforage)*vm_prod_reg(i2,kli_rum) + 10**(-6)))
                 ;

*' Note that $10^{-6}$ is required to avoid division by zero.
*' The regional ruminant production is then given by

q71_sum_rum_liv(j2,kli_rum) ..
                 vm_prod(j2,kli_rum) =e= sum(kforage,v71_prod_rum(j2,kli_rum,kforage))
                 ;

*' To account for the above mentioned fact that monogastric livestock are held close to the population, it is
*' distributed based on urban area by the formula

q71_prod_mon_liv(j2,kli_mon) ..
                 vm_prod(j2,kli_mon) =l=
                  i71_urban_area_share(j2) * s71_scale_mon * sum(cell(i2,j2),vm_prod_reg(i2,kli_mon))
                  + v71_additional_mon(j2,kli_mon)
                 ;

*' Note that s71_scale_mon relaxes the constraint (per default by 10%) and v71_additional_mon ensures
*' feasability by punishing additonal monogastric production within a cluster.

*' The punishmment of additional monogastric livestock production are calculated via

q71_punishment_mon(i2) ..
                vm_costs_additional_mon(i2) =e=
                sum((cell(i2,j2),kli_mon), v71_additional_mon(j2,kli_mon)) *  s71_punish_additional_mon
                ;

*' Note that the punishment costs are based on transport costs and scaled up by one order of magnitude
*' of the average transport costs to account for additional transport between clusters.
