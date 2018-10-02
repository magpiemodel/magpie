*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' @equations 
*' For every cell a new equilibrium value for the soil organic carbon 
*' pool on cropland as the sum over all crop types is calculated 


q59_som_target_cropland(j2) ..
              v59_som_target(j2,"cropland")
              =e= sum((kcr,w), vm_area(j2,kcr,w) * i59_cratio(j2,kcr)) * sum(ct,f59_topsoilc_density(ct,j2))
              ;
*' as well as for all non cropland given by

q59_som_target_noncropland(j2) ..
              v59_som_target(j2,"noncropland")
              =e= sum((noncropland59), vm_land(j2,noncropland59)) * sum(ct,f59_topsoilc_density(ct,j2))
			  ;

*' Depending on the setting of `c59_som_scenario `climate impacts (`cc`) are taken into account or not (`nocc`).
*' For a static climate `f59_topsoilc_density` is set to the value of 1995 within the input of the module realization.
			  
*' To account for the transfer of carbon rich soils from natural vegetation to cropland as well as the transfer of 
*' depleted soils from cropland to regrowing natural land, the cropland expansion and reduction of each cell is calculated via
			  
q59_crop_diff(j2)  ..	

 	          v59_crop_reduction(j2) - v59_crop_expansion(j2) 
                  =e= pcm_land(j2,"crop") - vm_land(j2,"crop")
              ;

*' The following nonlinear constraint

q59_crop_diff_constraint(i2) ..	  
              vm_costs_overrate_cropdiff(i2)
			      =e= s59_punish_cropdiff
				   * sum(cell(i2,j2),v59_crop_reduction(j2)*v59_crop_expansion(j2)) 
              ; 

*' ensures that no extra cropland reduction and expansion at the same time is happening. Note that this nonlinear realization 
*' needs two to three times longer runtime and is thus by default not switch on. 

*' The actually carbon transfer from cropland as well as to cropland soils is then given by

q59_som_transfer_to_cropland(j2) ..
              v59_som_transfer_to_cropland(j2)
              =e= sum(ct, 
              v59_crop_expansion(j2) * p59_carbon_density(ct,j2,"noncropland")
              - v59_crop_reduction(j2) * p59_carbon_density(ct,j2,"cropland"))
			  ;

*' To get the current size of the soil organic carbon pool, the pool of the previous timestep corrected by the carbon transfer
*' is developing into the direction of the above calculated target values taken the timestep depending lossrate into account by 

q59_som_pool_cropland(j2) ..
             v59_som_pool(j2,"cropland")
              =e= sum(ct, i59_lossrate(ct)) 
			     * (v59_som_target(j2,"cropland") 
			    - (p59_som_pool(j2,"cropland") + v59_som_transfer_to_cropland(j2))) 
				+ (p59_som_pool(j2,"cropland") + v59_som_transfer_to_cropland(j2))
              ;

*' and
			  
q59_som_pool_noncropland(j2) ..
               v59_som_pool(j2,"noncropland")
               =e= sum(ct,i59_lossrate(ct))
                  * (v59_som_target(j2,"noncropland") 
				 - (p59_som_pool(j2,"noncropland") - v59_som_transfer_to_cropland(j2))) 
				 + (p59_som_pool(j2,"noncropland") - v59_som_transfer_to_cropland(j2))
               ;

*' The annual nitrogen release (or sink) for cropland soils is than calculated by the loss of soil organic carbon given by  			
			   
q59_nr_som(j2) ..
           vm_nr_som(j2)
           =e= sum(ct,i59_lossrate(ct))/m_timestep_length*1/15
		   * (p59_som_pool(j2,"cropland")
             + v59_som_transfer_to_cropland(j2) - v59_som_target(j2,"cropland"))
           ;

*' with the carbon to nitrogen ratio of soils assumed to be 15:1.