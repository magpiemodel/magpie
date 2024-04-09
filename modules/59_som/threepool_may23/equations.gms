*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @equations

*' For every cell a new equilibrium value for the soil organic carbon pool
*' on cropland is calculated as the sum over all crop types and irrigation regimes via

q59_steadystate_term_crop(i2, sPools59, w, tillage59) .. 
  v59_topsoilc_crop_steadystate(i2, sPools59, w, tillage59)  =e=     
    sum(kcr_tillage59(kcr, tillage59), vm_res_recycling(i2, kcr, w, "c") * 
                                         i59_cinput_multiplier_residue(i2, sPools59, kcr)) /
        sum(ct, f59_topsoilc_decay(ct, i2, sPools59, w, tillage59));

*' as well as for all non cropland via
                                  
q59_steadystate_term_noncrop(i2, noncropland59, sPools59) ..  
  v59_topsoilc_noncrop_steadystate(i2, noncropland59, sPools59)  =e=        
    sum(ct, f59_litter_input(ct, i2, sPools59) /
            f59_topsoilc_decay(ct, i2, sPools59, "rainfed", "notill")) *
      sum(cell(i2,j2), vm_land(j2, noncropland59));

*' To account for land-use transitions the previous carbon stocks has to be adjusted
*' to calculate the new actual carbon stocks. Previous stocks are thus given by   
*' the carbons stocks of current cropland plus the carbon offset (plus or minus) 
*' from area being non-cropland in the time step before. 
*' For cropland the previous SOC state after accounting for transitions is given by

q59_previousstate_term_crop(i2, sPools59, w, tillage59) ..
  v59_topsoilc_crop_previousstate(i2, sPools59, w, tillage59)     
    =e= sum(ct, p59_topsoilc_density_pre(ct, i2, "crop", sPools59) *
            sum((cell(i2, j2), kcr_tillage59(kcr, tillage59)), vm_area(j2, kcr, w))) +
           sum((ct, noncropland59), (p59_topsoilc_density_pre(ct, i2, noncropland59, sPools59) -
                                    p59_topsoilc_density_pre(ct, i2, "crop", sPools59)) *
            v59_cropland_transitions(i2, tillage59, w, noncropland59));  

*' with v59_cropland_transitions being a helper variable that translates cropland transitions
*' in to tillage- and irrigation-type-specific SOC transfers via  

q59_lutransitions_to_cropareas(i2, noncropland59) ..
  sum((tillage59, w), v59_cropland_transitions(i2, tillage59, w, noncropland59)) =e=
                          sum(cell(i2,j2), vm_lu_transitions(j2, noncropland59, "crop"));

*' The previous SOC state on non-cropland after accounting for land-use transition is not 
*' tillage- and irrgations-type-specific and thus given by

q59_previousstate_term_noncrop(i2, noncropland59, sPools59) ..
  v59_topsoilc_noncrop_previousstate(i2, noncropland59, sPools59)
    =e= sum((ct, land_from), p59_topsoilc_density_pre(ct, i2, land_from, sPools59) *
            sum(cell(i2, j2), vm_lu_transitions(j2, land_from, noncropland59)));
 
*' Following the 2019-Refinement of the IPCC guidelines 2006 for cropland the actual state
*' can be calculated via

q59_actualstate_crop(i2, sPools59) ..
               v59_topsoilc_actualstate(i2, "crop", sPools59)
               =e= sum((tillage59, w), v59_topsoilc_crop_previousstate(i2, sPools59, w, tillage59) * 
                        (1 - sum(ct, i59_topsoilc_decay_max1(ct, i2, sPools59, w, tillage59)))) +
                   sum((tillage59, w), v59_topsoilc_crop_steadystate(i2, sPools59, w, tillage59) *
                        sum(ct, i59_topsoilc_decay_max1(ct, i2, sPools59, w, tillage59)))
               ;

*' for cropland and via
               
q59_actualstate_noncrop(i2, noncropland59, sPools59) ..
               v59_topsoilc_actualstate(i2, noncropland59, sPools59)
               =e= v59_topsoilc_noncrop_previousstate(i2, noncropland59, sPools59) *
                        (1 - sum(ct, i59_topsoilc_decay_max1(ct, i2, sPools59, "rainfed", "notill"))) +
                   v59_topsoilc_noncrop_steadystate(i2, noncropland59, sPools59) *
                        sum(ct, i59_topsoilc_decay_max1(ct, i2, sPools59, "rainfed", "notill"))
              ;

*' for non-cropland.

*' The soil carbon content of the whole soil profile is than calculated as sum of actual topsoil pool
*' and the reference soil carbon pool of the subsoil, that is assumed to be unaffected by human management:

q59_carbon_soil(i2, land, stockType) ..
                sum(cell(i2,j2), vm_carbon_stock(j2, land, "soilc", stockType))
                =e= sum(sPools59, v59_topsoilc_actualstate(i2, land, sPools59)) + 
                    sum(cell(i2,j2), vm_land(j2, land) * sum(ct, i59_subsoilc_density(ct, j2)));

*' Note, that as long as the three pool soil model is on regional scale, cluster scale soil carbon stocks 
*' are not meaningful.

*' The annual nitrogen release (or sink) for cropland soils is than 
*' calculated by the loss of soil organic carbon given by

q59_nr_som(i2) ..
             vm_nr_som(i2)
               =e= 1/m_timestep_length * 1/15 * sum((tillage59, w, sPools59), 
                        (v59_topsoilc_crop_previousstate(i2, sPools59, w, tillage59) -
                         v59_topsoilc_crop_steadystate(i2, sPools59, w, tillage59))
                        * sum(ct, i59_topsoilc_decay_max1(ct, i2, sPools59, w, tillage59)))
              ;

*' with the carbon to nitrogen ratio of soils assumed to be 15:1.

*' The amount of nitrogen that becomes available to cropland farming is 
*' limited by loss of soil organic matter by

q59_nr_som_fertilizer(i2) ..
          vm_nr_som_fertilizer(i2)
          =l=
          vm_nr_som(i2);

*' as well as by the amount that crops can take up

q59_nr_som_fertilizer2(i2) ..
          vm_nr_som_fertilizer(i2)
          =l=
          sum(cell(i2,j2), vm_landexpansion(j2,"crop")) * s59_nitrogen_uptake;

*' Here we assume a maximum of 200 kg on the expanded area.
