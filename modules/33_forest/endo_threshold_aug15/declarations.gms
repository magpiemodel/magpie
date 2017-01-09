*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

scalars
 s33_shift number of 5-year age-classes corresponding to current time step length
;

positive variables
  v33_land(j,land33,si)       forest area for each cell (ifft and semi_nat) [mio. ha]
  vm_landdiff_forest       aggregated difference in forest land compared to previous timestep (mio. ha)
;

parameters
 p33_carbon_density(t,j,land33,c_pools) Carbon density for land33 and c_pools (tC per ha)
 pc33_carbon_density(j,land33,c_pools) Carbon density for land33 and c_pools in optimization (tC per ha)
 p33_land(t,j,ac,land33,si,when)                   other land per age class before and after optimization (mio. ha)
 pc33_land(j,land33,si)                                  current forest area for each cell (ifft and semi_nat) [mio. ha]
 i33_fore_protect(t,i)                            Share of total forest area designated for protection [1]
 p33_save_forest(t,i,land33)                Share of saved forest in terms of land33 [1]
 p33_save_forest_shift(t,i,land33)  Shifted area of saved forest in current time step between land33 [1]
 i33_land(j,ac,land33,si)                   inital forest land[mio. ha]
 i33_save_fore_protect(t,i,land33)                 Share of area designated for protection in inital time step (in terms of forest+forestry area) [1]
 p33_max_deforest(t,i)                                maximum deforestation allowed (Mha)
;

equations
 q33_carbon(j,c_pools)      forest carbon content calculation
 q33_land(j,si)             land constraint
 q33_diff                   aggregated difference in other land compared to previous timestep (mio. ha)
 q33_defor(i)                                deforestation constraint
;

*** EOF declarations.gms ***

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov33_land(t,j,land33,si,type) forest area for each cell (ifft and semi_nat) [mio. ha]
 ov_landdiff_forest(t,type)    aggregated difference in forest land compared to previous timestep (mio. ha)
 oq33_carbon(t,j,c_pools,type) forest carbon content calculation
 oq33_land(t,j,si,type)        land constraint
 oq33_diff(t,type)             aggregated difference in other land compared to previous timestep (mio. ha)
 oq33_defor(t,i,type)          deforestation constraint
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
