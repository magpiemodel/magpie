*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
          i59_lossrate(t)                      Rate of loss or recovery of SOM pool per timestep (1)
          p59_carbon_density(t_all,j,land)     Soil carbon density of a hectare of land (tC per ha)
          pc59_carbon_density(j,land)          Soil carbon density of a hectare of land between time steps (tC per ha)
          i59_tillage_share(i,tillage59)       Share of land under tillage class (1)
          i59_input_share(i,inputs59)          Share of land under input class (1)
          i59_scm_target_area(t,i)             Target area for soil carbon management at regional level in absolute terms (mio. ha)
          pc59_area(j,kcr,w)                   Cropland area by crop type and irrigation from previous timestep (mio. ha)
          p59_land_scm_reference(j)            Total cropland area snapshot for SCM target calculation when using fixed reference year (mio. ha)
          i59_cratio(j,kcr,w)                  Ratio of carbon density of land relative to natural vegetaion (1)
          i59_cratio_fallow(j)                 Ratio of carbon density of fallow land relative to natural vegetation (1)
          i59_cratio_treecover                 Ratio of carbon density of tree cover on cropland relative to natural vegetation (1)
          i59_cratio_scm(j)                    Ratio of carbon density of cropland under soil carbon managament relative to natural vegetation (1)
          i59_scm_scenario_fader(t_all)        Cropland soil carbon management scenario fader (1)
          p59_scm_country_switch(iso)          Switch indicating whether country is affected by selected soil carbon management policy (1)
          p59_country_weight(i)                Soil carbon management policy country weight per region (1)
          pc59_som_pool(j,land)                Actual C pool (mio. tC)
          i59_subsoilc_density(t_all,j)        Subsoil carbon density of a hectare of land (tC per ha)
          pc59_land_before(j,land)             Land area in previous time step (mio. ha)
;

equations
         q59_som_target_cropland(j)                       Estimates the long-term target state of cropland (mio. tC)
         q59_som_target_noncropland(j,noncropland59)      Estimates the long-term target state of noncropland (mio. tC)
         q59_som_pool(j,land)                             Actual C pool (mio. tC)
         q59_nr_som(j)                                    Soil organic matter loss (Mt N per yr)
         q59_nr_som_fertilizer(j)                         Bound of nitrogen fertilizer of soil organic matter loss (Mt N per yr)
         q59_nr_som_fertilizer2(j)                        Fraction of soil organic matter loss take is taken up by plants (Mt N per yr)
         q59_carbon_soil(j,land,stockType)                Soil carbon content calculation (mio. tC)
         q59_cost_scm(j)                                  Recurring cost for soil carbon management on cropland (mio. USD17MER per yr)
         q59_area_scm_tot(j,kcr,w)                        SCM and non-SCM area must sum to total cropland area (mio. ha)
         q59_scm_target_constraint(i)                     Total SCM area equals regional target (mio. ha)
         q59_scm_max_per_cell(j)                          Upper bound on SCM area per cell to prevent clustering (mio. ha)
;

positive variables
         v59_som_target(j,land)           Long-term target state of C pool (mio. tC)
         v59_som_pool(j,land)             Soil organic matter pool (mio. tC)
         vm_cost_scm(j)                   Recurring cost for soil carbon management on cropland (mio. USD17MER per yr)
         v59_area_scm(j,kcr,w,scmtype59)  Cropland area disaggregated by SCM implementation (mio. ha)
;

variables
         vm_nr_som(j)                                       Release of soil organic matter (Mt N per yr)
         vm_nr_som_fertilizer(j)                            Uptake of soil organic matter from plants (Mt N per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov59_som_target(t,j,land,type)                      Long-term target state of C pool (mio. tC)
 ov59_som_pool(t,j,land,type)                        Soil organic matter pool (mio. tC)
 ov_cost_scm(t,j,type)                               Recurring cost for soil carbon management on cropland (mio. USD17MER per yr)
 ov59_area_scm(t,j,kcr,w,scmtype59,type)             Cropland area disaggregated by SCM implementation (mio. ha)
 ov_nr_som(t,j,type)                                 Release of soil organic matter (Mt N per yr)
 ov_nr_som_fertilizer(t,j,type)                      Uptake of soil organic matter from plants (Mt N per yr)
 oq59_som_target_cropland(t,j,type)                  Estimates the long-term target state of cropland (mio. tC)
 oq59_som_target_noncropland(t,j,noncropland59,type) Estimates the long-term target state of noncropland (mio. tC)
 oq59_som_pool(t,j,land,type)                        Actual C pool (mio. tC)
 oq59_nr_som(t,j,type)                               Soil organic matter loss (Mt N per yr)
 oq59_nr_som_fertilizer(t,j,type)                    Bound of nitrogen fertilizer of soil organic matter loss (Mt N per yr)
 oq59_nr_som_fertilizer2(t,j,type)                   Fraction of soil organic matter loss take is taken up by plants (Mt N per yr)
 oq59_carbon_soil(t,j,land,stockType,type)           Soil carbon content calculation (mio. tC)
 oq59_cost_scm(t,j,type)                             Recurring cost for soil carbon management on cropland (mio. USD17MER per yr)
 oq59_area_scm_tot(t,j,kcr,w,type)                   SCM and non-SCM area must sum to total cropland area (mio. ha)
 oq59_scm_target_constraint(t,i,type)                Total SCM area equals regional target (mio. ha)
 oq59_scm_max_per_cell(t,j,type)                     Upper bound on SCM area per cell to prevent clustering (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
