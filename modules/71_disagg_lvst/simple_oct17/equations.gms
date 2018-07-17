*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


q71_feed_rum_liv(j2,kforage) .. vm_prod(j2,kforage) =g= 
                                sum(kli_rum, vm_prod(j2,kli_rum) * sum((ct, cell(i2,j2)),im_feed_baskets(ct,i2,kli_rum,kforage))
                                + v71_feed_balanceflow(j2,kli_rum,kforage));

q71_balanceflow_constrain(i2,kforage) ..
   sum((ct,kli_rum), fm_feed_balanceflow(ct,i2,kli_rum,kforage)) =e=
   sum( cell(i2,j2), v71_feed_balanceflow(j2,kli_rum,kforage)
   ;
 
	 
*** no residue production in cluster level avaiable so far
*** so the equation above is just running for foddr production							

								 								 
q71_prod_mon_liv(j2,kli_mon) .. vm_prod(j2,kli_mon)
                                 =e=
								 i71_urban_area_share(j2) *
								 sum(cell(i2,j2),vm_prod_reg(i2,kli_mon))
								 ;

							
							
							