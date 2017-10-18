*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


 q71_prod_in(j2,kli_rum) .. v71_prod_in(j2,kli_rum)
                            =l=
						    sum(kli_rum_kfeed_not_trans(kli_rum,kfeed_not_transportable),
							 vm_prod(j2,kfeed_not_transportable) /
							 sum(ct,i71_share_in_feedmix(ct,j2,kli_rum,kfeed_not_transportable,"dm")))
						    ;
							

						   
 q71_prod_ex(j2,kli_rum) .. v71_prod_ex(j2,kli_rum)
                            =l=
						    vm_prod(j2,"pasture") /
							sum(ct,i71_share_in_feedmix(ct,j2,kli_rum,"pasture","dm"))
						    ;
						   
 
 q71_prod_reg_ex(i2,kli_rum) .. vm_prod_reg(i2,kli_rum) * sum(ct,i71_share_in_feedmix_reg(ct,i2,kli_rum,"pasture","nr"))
                                 =e=
                                 sum(cell(i2,j2),v71_prod_ex(j2,kli_rum));
                                 ;


 q71_prod_rum_liv(j2,kli_rum) .. vm_prod(j2,kli_rum)
                                 =e=
								 v71_prod_in(j2,kli_rum) + v71_prod_ex(j2,kli_rum)
                                 ;
								 
								 
 q71_prod_mon_liv(j2,kli_mon) .. vm_prod(j2,kli_mon)
                                 =e=
								 i71_urban_area_share(j2) *
								 sum(cell(i2,j2),vm_prod_reg(i2,kli_mon))
								 ;

							
							
							