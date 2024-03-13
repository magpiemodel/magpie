*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
 s61_shift number of 5-year age-classes corresponding to current time step length (1)
;

parameters
 p61_treecover_min_shr(t,j)           Minimum share of treecover on cropland (1)
 p61_betr_min_shr(t,j)                Minimum share of bioenergy trees on cropland (1)
 p61_treecover_scenario_fader(t_all)  Cropland treecover scenario fader (1)
 p61_betr_scenario_fader(t_all)       Bioenergy trees scenario fader (1)
 p61_treecover_bii_coeff(bii_class_secd,potnatveg)  BII coefficient for cropland treecover (1)
 p61_carbon_density_ac(t,j,ac,ag_pools) Carbon density for ac and ag_pools (tC per ha)
 p61_treecover(t,j,ac)                  Cropland tree cover per age class (mio. ha)
 pc61_treecover(j,ac)                   Cropland tree cover per age class in current time step (mio. ha)
;

equations
 q61_cost_agroforestry(j)          Costs and benefits related to agroforestry (mio. USD05MER per yr)
 q61_cost_treecover_est(j)         Establishment cost for cropland tree cover (mio. USD05MER per yr)
 q61_cost_treecover_recur(j)       Recurring cost for cropland tree cover (mio. USD05MER per yr)
 q61_treecover_area(j)             Cropland treecover interface (mio. ha)
 q61_treecover_shr(j)              Cropland treecover minimum share (mio. ha)
 q61_betr_shr(j)                   Bioenergy trees minimum share (mio. ha)
 q61_treecover_est(j,ac)           Cropland treecover establishment (mio. ha)
 q61_treecover_carbon(j,ag_pools,stockType)  Cropland tree cover above ground carbon content (mio. tC)
 q61_treecover_bv(j,potnatveg)     Biodiversity value for cropland treecover (Mha)
;

variables
 vm_cost_agroforestry(j) Cost and rewards related to agroforestry (mio. USD05MER per yr)
;

positive variables
 v61_cost_treecover_est(j)        Establishment cost for cropland tree cover (mio. USD05MER per yr)
 v61_cost_treecover_recur(j)      Recurring cost for cropland tree cover (mio. USD05MER per yr)
 vm_treecover_area(j)             Cropland tree cover (mio. ha)
 v61_treecover(j,ac)              Cropland tree cover per age class (mio. ha)
 vm_treecover_carbon(j,ag_pools,stockType) Cropland tree cover above ground carbon content (mio. tC)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_agroforestry(t,j,type)                     Cost and rewards related to agroforestry (mio. USD05MER per yr)
 ov61_cost_treecover_est(t,j,type)                  Establishment cost for cropland tree cover (mio. USD05MER per yr)
 ov61_cost_treecover_recur(t,j,type)                Recurring cost for cropland tree cover (mio. USD05MER per yr)
 ov_treecover_area(t,j,type)                        Cropland tree cover (mio. ha)
 ov61_treecover(t,j,ac,type)                        Cropland tree cover per age class (mio. ha)
 ov_treecover_carbon(t,j,ag_pools,stockType,type)   Cropland tree cover above ground carbon content (mio. tC)
 oq61_cost_agroforestry(t,j,type)                   Costs and benefits related to agroforestry (mio. USD05MER per yr)
 oq61_cost_treecover_est(t,j,type)                  Establishment cost for cropland tree cover (mio. USD05MER per yr)
 oq61_cost_treecover_recur(t,j,type)                Recurring cost for cropland tree cover (mio. USD05MER per yr)
 oq61_treecover_area(t,j,type)                      Cropland treecover interface (mio. ha)
 oq61_treecover_shr(t,j,type)                       Cropland treecover minimum share (mio. ha)
 oq61_betr_shr(t,j,type)                            Bioenergy trees minimum share (mio. ha)
 oq61_treecover_est(t,j,ac,type)                    Cropland treecover establishment (mio. ha)
 oq61_treecover_carbon(t,j,ag_pools,stockType,type) Cropland tree cover above ground carbon content (mio. tC)
 oq61_treecover_bv(t,j,potnatveg,type)              Biodiversity value for cropland treecover (Mha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
