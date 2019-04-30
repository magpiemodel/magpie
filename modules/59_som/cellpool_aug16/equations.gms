*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' @equations
*' For every cell a new equilibrium value for the soil organic carbon
*' pool on cropland as the sum over all crop types is calculated

q59_som_target_cropland(j2) ..
              v59_som_target(j2,"crop")
              =e= sum((kcr,w), vm_area(j2,kcr,w) * i59_cratio(j2,kcr,w)) * sum(ct,f59_topsoilc_density(ct,j2))
              ;
*' as well as for all non cropland given by

q59_som_target_noncropland(j2,noncropland59) ..
              v59_som_target(j2,noncropland59)
              =e= vm_land(j2,noncropland59) * sum(ct,f59_topsoilc_density(ct,j2))
			  ;

*' Depending on the setting of `c59_som_scenario `climate impacts (`cc`) are taken into account or not (`nocc`).
*' For a static climate `f59_topsoilc_density` is set to the value of 1995 within the input of the module realization.

*' The actually carbon transfer from cropland as well as to cropland soils is then given by

q59_som_transfer_to_cropland(j2, noncropland59) ..
              v59_som_transfer_to_cropland(j2, noncropland59)
              =e= sum(ct,
              vm_croplandexpansion(j2,noncropland59) * p59_carbon_density(ct,j2,noncropland59)
              - vm_croplandreduction(j2,noncropland59) * p59_carbon_density(ct,j2,"crop"))
			  ;

*' To get the current size of the soil organic carbon pool, the pool of the previous timestep corrected by the carbon transfer
*' is developing into the direction of the above calculated target values taken the timestep depending lossrate into account by

q59_som_pool_cropland(j2) ..
             v59_som_pool(j2,"crop")
              =e= sum(ct, i59_lossrate(ct))
			     * (v59_som_target(j2,"crop")
			    - (p59_som_pool(j2,"crop") + sum(noncropland59, v59_som_transfer_to_cropland(j2,noncropland59))))
				  + (p59_som_pool(j2,"crop") + sum(noncropland59, v59_som_transfer_to_cropland(j2,noncropland59)))
              ;

*' and

q59_som_pool_noncropland(j2, noncropland59) ..
               v59_som_pool(j2, noncropland59)
               =e= sum(ct,i59_lossrate(ct))
                  * (v59_som_target(j2,noncropland59)
				 - (p59_som_pool(j2,noncropland59) - v59_som_transfer_to_cropland(j2,noncropland59)))
				 + (p59_som_pool(j2,noncropland59) - v59_som_transfer_to_cropland(j2,noncropland59))
               ;

q59_carbon_soil_cropland(j2) ..
                vm_carbon_stock(j2,"crop","soilc") =e=
                    v59_som_pool(j2,"crop") + vm_land(j2,"crop") * sum(ct,i59_subsoilc_density(ct,j2))
                ;

q59_carbon_soil_noncropland(j2, noncropland59) ..
                vm_carbon_stock(j2,noncropland59,"soilc") =e=
                  v59_som_pool(j2,noncropland59) +  sum(ct,i59_subsoilc_density(ct,j2))
                                                   *  vm_land(j2,noncropland59)
                ;

*' The annual nitrogen release (or sink) for cropland soils is than calculated by the loss of soil organic carbon given by

q59_nr_som(j2) ..
           vm_nr_som(j2)
           =e= sum(ct,i59_lossrate(ct))/m_timestep_length*1/15
		   * (p59_som_pool(j2,"crop")
             + sum(noncropland59, v59_som_transfer_to_cropland(j2,noncropland59))
             - v59_som_target(j2,"crop"))
           ;
*' with the carbon to nitrogen ratio of soils assumed to be 15:1.

*' The amount of nitrogen that becomes available to cropland farming is limited by loss of soil organic matter by

q59_nr_som_fertilizer(j2) ..
          vm_nr_som_fertilizer(j2)
          =l=
          vm_nr_som(j2);

*' as well as by the amount that crops can take up.

q59_nr_som_fertilizer2(j2) ..
          vm_nr_som_fertilizer(j2)
          =l=
          vm_landexpansion(j2,"crop")*s59_nitrogen_uptake;

*' Here we assume a maximum of 200 kg on the expanded area.
