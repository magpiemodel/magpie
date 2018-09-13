*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
          i59_lossrate(t)                      Rate of loss or recovery of SOM pool per timestep (1)
          p59_carbon_density(t_all,j,pools59)  Carbon density of a hectare of land (tC per ha)
          i59_tillage_share(i,tillage59)       Share of land under tillage class (1)
          i59_input_share(i,inputs59)          Share of land under input class (1)
          i59_cratio(j,kcr)                    Ratio of carbon density of land relative to natural vegetaion (1)
          p59_som_pool(j,pools59)              Actual C pool (mio. tC)
;

equations
         q59_som_target_cropland(j)         Estimates the long-term target state of cropland (mio. tC)
         q59_som_target_noncropland(j)      Estimates the long-term target state of noncropland (mio. tC)
         q59_som_transfer_to_cropland(j)    Estimates the transfer of carbon pools due to land conversion (mio. tC)
         q59_som_pool_cropland(j)           Actual C pool in croplands (mio. tC)
         q59_som_pool_noncropland(j)        Actual C pool in non-croplands (mio. tC)
         q59_nr_som(j)                      Soil organic matter loss (Tg N per yr)
         q59_crop_diff(j)                   Cropland difference
         q59_crop_diff_constraint(i)        Cropland difference constraint 
;

positive variables
         v59_som_target(j,pools59)           Long-term target state of C pool (mio. tC)
         v59_som_pool(j,pools59)             Soil organic matter pool (mio. tC)
         v59_crop_expansion(j)               Crop land expansion (mio. ha)
         v59_crop_reduction(j)               Land reduction (mio. ha)
;

variables
         v59_som_transfer_to_cropland(j)     Transfer of SOM from other land to cropland (mio. tC)
         vm_nr_som(j)                        Release of soil organic matter (Tg N per yr)
         vm_costs_overrate_cropdiff(i)	     Punishment costs for overrated cropland difference (mio. USD05 per yr)  
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov59_som_target(t,j,pools59,type)       long-term target state of C pool (Tg C)
 ov59_som_pool(t,j,pools59,type)         soil organic matter pool (Tg C)
 ov59_crop_expansion(t,j,type)           crop land expansion (mio. ha)
 ov59_crop_reduction(t,j,type)           land reduction (mio. ha)
 ov59_som_transfer_to_cropland(t,j,type) transfer of SOM from other land to cropland (Tg C)
 ov_nr_som(t,j,type)                     release of soil organic matter (Tg Nr)
 ov_costs_overrate_cropdiff(t,i,type)    punishment costs for overrated cropland difference (mio. USD05 per yr)  
 oq59_som_target_cropland(t,j,type)      estimates the long-term target state of cropland
 oq59_som_target_noncropland(t,j,type)   estimates the long-term target state of noncropland
 oq59_som_transfer_to_cropland(t,j,type) estimates the transfer of carbonpools due to land conversion
 oq59_som_pool_cropland(t,j,type)        actual C pool in croplands
 oq59_som_pool_noncropland(t,j,type)     actual C pool in non-croplands
 oq59_nr_som(t,j,type)                   soil organic matter loss
 oq59_crop_diff(t,j,type)                cropland difference
 oq59_crop_diff_constraint(t,i,type)     cropland difference constraint 
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
