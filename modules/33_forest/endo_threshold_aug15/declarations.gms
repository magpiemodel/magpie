*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

scalars
 s33_shift number of 5-year age-classes corresponding to current time step length
;

positive variables
  vm_landdiff_forest       aggregated difference in forest land compared to previous timestep (mio. ha)
;

parameters
 p33_carbon_density(t,j,c_pools) Carbon density for land33 and c_pools (tC per ha)
 p33_land(t,j,ac,when)                   age classes before and after optimization (mio. ha)
 i33_fore_protect(t,i)                            Share of total forest area designated for protection [1]
 p33_save_forest(t,i)                Share of saved forest in terms of land33 [1]
 p33_save_forest_shift(t,i)  Shifted area of saved forest in current time step between land33 [1]
 i33_save_fore_protect(t,i)                 Share of area designated for protection in inital time step (in terms of forest+forestry area) [1]
;

equations
 q33_carbon_primforest(j,c_pools)      forest carbon content calculation
 q33_carbon_secdforest(j,c_pools)      forest carbon content calculation
 q33_diff                   aggregated difference in other land compared to previous timestep (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_landdiff_forest(t,type)               aggregated difference in forest land compared to previous timestep (mio. ha)
 oq33_carbon_primforest(t,j,c_pools,type) forest carbon content calculation
 oq33_carbon_secdforest(t,j,c_pools,type) forest carbon content calculation
 oq33_diff(t,type)                        aggregated difference in other land compared to previous timestep (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
