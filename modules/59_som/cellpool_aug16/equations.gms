*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @equations
*' For every cell a new equilibrium value for the soil organic carbon pool
*' on cropland as the sum over all crop types and irrigation regimes is calculated

q59_som_target_cropland(j2) ..
              v59_som_target(j2,"crop")
              =e= (sum((kcr,w), vm_area(j2,kcr,w) * i59_cratio(j2,kcr,w)) 
                   + vm_fallow(j2) * i59_cratio_fallow(j2) 
                   + vm_treecover(j2) * i59_cratio_treecover)
                   * sum(ct,f59_topsoilc_density(ct,j2));

*' as well as for all non cropland given by

q59_som_target_noncropland(j2,noncropland59) ..
              v59_som_target(j2,noncropland59)
              =e= vm_land(j2,noncropland59) * sum(ct,f59_topsoilc_density(ct,j2))
        ;

*' Depending on the setting of `c59_som_scenario `climate impacts (`cc`)
*' are taken into account or not (`nocc` and `nocc_hist`).
*' For a static climate `f59_topsoilc_density` is set to the value of 1995
*' within the input of the module realization.

*' To get the current size of the soil organic carbon pool, the carbon
*' pool of the previous timestep is developing into the direction of the
*' above calculated target values taken the timestep depending lossrate
*' into account by

q59_som_pool(j2,land) ..
               v59_som_pool(j2,land)
               =e= sum(ct,i59_lossrate(ct)) * v59_som_target(j2,land)
                   + (1 - sum(ct,i59_lossrate(ct))) *
                   sum((ct,land_from), p59_carbon_density(ct,j2,land_from) *
                     vm_lu_transitions(j2,land_from,land))
               ;

*' Note that to account correctly for land-use transitions, carbon densities
*' multiplied by the land-use transition matrix of the current timestep
*' is used.

*' The soil carbon content is calculated as sum of actual topsoil pool
*' and the reference soil carbon pool of the subsoil

q59_carbon_soil(j2,land,stockType) ..
                vm_carbon_stock(j2, land,"soilc",stockType)
                =e= v59_som_pool(j2, land) + vm_land(j2, land) *
                     sum(ct,i59_subsoilc_density(ct,j2));

*' The annual nitrogen release (or sink) for cropland soils is than
*' calculated by the loss of soil organic carbon given by

q59_nr_som(j2) ..
           vm_nr_som(j2)
           =e= sum(ct,i59_lossrate(ct))/m_timestep_length*1/15
               * (sum((ct,land_from), p59_carbon_density(ct,j2,land_from) *
                   vm_lu_transitions(j2,land_from,"crop"))
               - v59_som_target(j2,"crop"))
           ;
*' with the carbon to nitrogen ratio of soils assumed to be 15:1.

*' The amount of nitrogen that becomes available to cropland farming is
*' limited by loss of soil organic matter by

q59_nr_som_fertilizer(j2) ..
          vm_nr_som_fertilizer(j2)
          =l=
          vm_nr_som(j2);

*' as well as by the amount that crops can take up

q59_nr_som_fertilizer2(j2) ..
          vm_nr_som_fertilizer(j2)
          =l=
          vm_landexpansion(j2,"crop") * s59_nitrogen_uptake;

*' Here we assume a maximum of 200 kg on the expanded area.
