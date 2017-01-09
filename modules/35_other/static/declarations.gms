*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

parameters
 pm_recovered_forest(t,j,ac,si) recovered forest area (mio. ha)
 pc35_carbon_density(j,c_pools) carbon density in optimization (tC per ha)
;

positive variables
  vm_landdiff_other          aggregated difference in other land compared to previous timestep (mio. ha)
  v35_land(j,land35,si)      natveg land pools (mio. ha)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_landdiff_other(t,type)     aggregated difference in other land compared to previous timestep (mio. ha)
 ov35_land(t,j,land35,si,type) natveg land pools (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

