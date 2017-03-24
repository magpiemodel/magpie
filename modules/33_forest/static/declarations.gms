*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

parameters
 pc33_carbon_density(j,c_pools) carbon density in optimization (tC per ha)
;

positive variables
  vm_landdiff_forest          aggregated difference in forest land compared to previous timestep (mio. ha)
  v33_land(j,land33,si)       forest area for each cell (ifft and semi_nat) [mio. ha]
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_landdiff_forest(t,type)    aggregated difference in forest land compared to previous timestep (mio. ha)
 ov33_land(t,j,land33,si,type) forest area for each cell (ifft and semi_nat) [mio. ha]
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
