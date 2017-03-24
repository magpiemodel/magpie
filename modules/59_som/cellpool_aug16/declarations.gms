*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

parameters
          i59_lossrate(t) rate of loss or recovery of SOM pool per timestep
          p59_carbon_density(t_all,j,pools59)  carbon density of a hectare of land (t C per ha)
          i59_tillage_share(i,tillage59)      share of land under tillage clas(1)
          i59_input_share(i,inputs59)         share of land under input class (1)
          i59_cratio(j,kcr)                   ratio of carbon densitiy of land relative to natural vegetaion (1)
          p59_som_pool(j,pools59)            actual C pool (Tg C) 
;

equations
         q59_som_target_cropland(j)         estimates the long-term target state of cropland
         q59_som_target_noncropland(j)      estimates the long-term target state of noncropland
         q59_som_transfer_to_cropland(j)    estimates the transfer of carbonpools due to land conversion
         q59_som_pool_cropland(j)           actual C pool in croplands
         q59_som_pool_noncropland(j)        actual C pool in non-croplands
         q59_nr_som(j)                      soil organic matter loss
;

positive variables
         v59_som_target(j,pools59)          long-term target state of C pool (Tg C)
         v59_som_pool(j,pools59)            soil organic matter pool (Tg C)
;

variables
         v59_som_transfer_to_cropland(j)     transfer of SOM from other land to cropland (Tg C)
         vm_nr_som(j)                        release of soil organic matter (Tg Nr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov59_som_target(t,j,pools59,type)       long-term target state of C pool (Tg C)
 ov59_som_pool(t,j,pools59,type)         soil organic matter pool (Tg C)
 ov59_som_transfer_to_cropland(t,j,type) transfer of SOM from other land to cropland (Tg C)
 ov_nr_som(t,j,type)                     release of soil organic matter (Tg Nr)
 oq59_som_target_cropland(t,j,type)      estimates the long-term target state of cropland
 oq59_som_target_noncropland(t,j,type)   estimates the long-term target state of noncropland
 oq59_som_transfer_to_cropland(t,j,type) estimates the transfer of carbonpools due to land conversion
 oq59_som_pool_cropland(t,j,type)        actual C pool in croplands
 oq59_som_pool_noncropland(t,j,type)     actual C pool in non-croplands
 oq59_nr_som(t,j,type)                   soil organic matter loss
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
