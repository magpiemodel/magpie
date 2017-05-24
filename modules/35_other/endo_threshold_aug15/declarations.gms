*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

scalars
 s35_shift number of 5-year age-classes corresponding to current time step length
;

parameters
 p35_carbon_density(t,j,land35,c_pools) Carbon density for land35 and c_pools (tC per ha)
 pc35_carbon_density(j,land35,c_pools) Carbon density for land35 and c_pools in optimization (tC per ha)
 i35_land(j,ac)          inital other land [mio. ha]
 p35_land(t,j,ac,when)   other land per age class before and after optimization (mio. ha)
 pc35_land(j,land35)     current other land per land35 land type (mio. ha)
 pm_recovered_forest(t,j,ac) recovered forest area (mio. ha)
 p35_protect_other(t,i) region specifc protection of other natural land (binary)
;

equations
 q35_carbon(j,c_pools)      other land carbon content calculation
 q35_land(j)             land pool calculation
 q35_diff                aggregated difference in other land compared to previous timestep (mio. ha)
;

positive variables
  v35_land(j,land35)      natveg land pools (mio. ha)
  vm_landdiff_other       aggregated difference in other land compared to previous timestep (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov35_land(t,j,land35,type)    natveg land pools (mio. ha)
 ov_landdiff_other(t,type)     aggregated difference in other land compared to previous timestep (mio. ha)
 oq35_carbon(t,j,c_pools,type) other land carbon content calculation
 oq35_land(t,j,type)           land pool calculation
 oq35_diff(t,type)             aggregated difference in other land compared to previous timestep (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
