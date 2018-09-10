*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Ruminant livestock production within a cell is determined by the production of the non-transportable 
*' feed items grazed pasture and fodder. They have be larger than the ruminant feed requirements 
*' ensured by the following equation containing a split of pasture and fodder fed ruminants  

q71_feed_rum_liv(j2,kforage) ..
                 vm_prod(j2,kforage)
                 =g=
                 sum(kli_rum, v71_prod_rum(j2,kli_rum,kforage)
                 * sum((ct,cell(i2,j2),kforage2),im_feed_baskets(ct,i2,kli_rum,kforage2))
				 * (1 + v71_feed_balanceflow(j2,kli_rum,kforage)$(s71_lp_fix=0))
				 + v71_feed_balanceflow(j2,kli_rum,kforage)$(s71_lp_fix=1))
				 ;

*' The balance flow for pasture and fodder (summarized with forage) production, that leads to a distortion 
*' of the relationship between the livestock and feed production, is incorporated for a linear and non-linear 
*' realization of this module. 
			
*' If module is fixed to linear behaviour the balance flow is allowed to be used in any cell 
*' containing pasture respectively cropland area in the previous time step ensured by the restrictions 
*' in the nl_fix statement. The balanceflow within a region is than determined by 

q71_balanceflow_constraint_lp(i2,kli_rum,kforage)$(s71_lp_fix=1) ..
                 sum(ct, fm_feed_balanceflow(ct,i2,kli_rum,kforage)) 
                 =e=
                 sum(cell(i2,j2), v71_feed_balanceflow(j2,kli_rum,kforage))
                 ;
				 
*' In the non linear version the balanceflow in each cluster is constraint by its share of 
*' forage production regarding the regional level by  

				 
q71_balanceflow_constraint_nlp(j2,kli_rum,kforage)$(s71_lp_fix=0) ..
		         v71_feed_balanceflow(j2,kli_rum,kforage)
		         =e=
		         sum((ct,cell(i2,j2)), fm_feed_balanceflow(ct,i2,kli_rum,kforage)/ 
		         (im_feed_baskets(ct,i2,kli_rum,kforage) * vm_prod_reg(i2,kli_rum) + 10**(-6)))
                 ;

*' The regional ruminant production is than given by

q71_sum_rum_liv(j2,kli_rum) ..
                 vm_prod(j2,kli_rum)
                 =e=
                 sum(kforage,v71_prod_rum(j2,kli_rum,kforage))
                 ;

*** no residue production in cluster level available so far
*** so the equation above is just running for fodder production

*' To account for the above mentioned simple idea, that monogastric livestocks is held close to the population, it is
*' distributed based on urban area by the formula 

q71_prod_mon_liv(j2,kli_mon) ..
                 vm_prod(j2,kli_mon)
                 =e=
                 i71_urban_area_share(j2) *
                 sum(cell(i2,j2),vm_prod_reg(i2,kli_mon))
                 ;