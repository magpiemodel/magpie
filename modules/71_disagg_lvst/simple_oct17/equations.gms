*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*' @equations

*' Grazed pasture and forage crop production in a cell has to be larger than
*' the ruminant feed requirements. The balance flow is allowed to be used
*' in any arbitrary cell of the world region.

q71_feed_rum_liv(j2,kforage) ..
                 vm_prod(j2,kforage)
                 =g=
                 sum(kli_rum, v71_prod_rum(j2,kli_rum,kforage)
                 * sum((ct,cell(i2,j2),kforage2),im_feed_baskets(ct,i2,kli_rum,kforage2))*
				 ( 1 + sum((ct,cell(i2,j2)), fm_feed_balanceflow(ct,i2,kli_rum,kforage)/ 
				           (im_feed_baskets(ct,i2,kli_rum,kforage) * vm_prod_reg(i2,kli_rum) + 10**(-6)))));

				 
*' Cellular ruminant production has to equal regional ruminant production.

q71_sum_rum_liv(j2,kli_rum) ..
                vm_prod(j2,kli_rum)
                =e=
                sum(kforage,v71_prod_rum(j2,kli_rum,kforage));


*** no residue production in cluster level available so far
*** so the equation above is just running for fodder production

*' Monogastrics are distributed based on urban area. Shall be improved
*' in the future to also account for croplands or other factors.

q71_prod_mon_liv(j2,kli_mon) ..
                 vm_prod(j2,kli_mon)
                 =e=
                 i71_urban_area_share(j2) *
                 sum(cell(i2,j2),vm_prod_reg(i2,kli_mon))
                 ;

