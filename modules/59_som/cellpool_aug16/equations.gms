*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


q59_som_target_cropland(j2) ..
              v59_som_target(j2,"cropland")
              =e=
              sum((kcr,w), vm_area(j2,kcr,w) * i59_cratio(j2,kcr)) * sum(ct,f59_topsoilc_density(ct,j2))
              ;


q59_som_target_noncropland(j2) ..
              v59_som_target(j2,"noncropland")
              =e=
              sum((noncropland59), vm_land(j2,noncropland59)) * sum(ct,f59_topsoilc_density(ct,j2))
			  ;

q59_crop_diff(j2)  ..	

 	          v59_crop_reduction(j2) - v59_crop_expansion(j2) =e=

                  pcm_land(j2,"crop") - vm_land(j2,"crop")
;

q59_crop_diff_constraint(i2) ..	
 	          sum(cell(i2,j2),v59_crop_reduction(j2)*v59_crop_expansion(j2)*s59_punish_cropdiff) 
                  =e= 
                  vm_punish_overrate_cropdiff(i2);

			  
q59_som_transfer_to_cropland(j2) ..
              v59_som_transfer_to_cropland(j2)
              =e=
              sum(ct, 
              + v59_crop_expansion(j2) * p59_carbon_density(ct,j2,"noncropland")
              - v59_crop_reduction(j2) * p59_carbon_density(ct,j2,"cropland")
              );


q59_som_pool_cropland(j2) ..
             v59_som_pool(j2,"cropland")
              =e=
              sum(ct,
                i59_lossrate(ct) *  v59_som_target(j2,"cropland") +
                 (1-i59_lossrate(ct)) * (p59_som_pool(j2,"cropland") + v59_som_transfer_to_cropland(j2))
              );

q59_som_pool_noncropland(j2) ..
               v59_som_pool(j2,"noncropland")
               =e=
               sum(ct,
                 i59_lossrate(ct) * v59_som_target(j2,"noncropland") +
                  (1-i59_lossrate(ct)) * (p59_som_pool(j2,"noncropland") - v59_som_transfer_to_cropland(j2))
               );

q59_nr_som(j2) ..
           vm_nr_som(j2)
           =e=		  
           sum(ct,i59_lossrate(ct)) * (
             p59_som_pool(j2,"cropland")
             + v59_som_transfer_to_cropland(j2)
             - v59_som_target(j2,"cropland")
           )/15 * 1/m_timestep_length;
