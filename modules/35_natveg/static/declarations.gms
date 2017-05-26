*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

positive variables
  v35_secdforest(j,land35) secdforest (mio. ha)
  v35_other(j,land35)      other land (mio. ha)
  vm_landdiff_natveg       aggregated difference in other land compared to previous timestep (mio. ha)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_landdiff_natveg(t,type)  aggregated difference in other land compared to previous timestep (mio. ha)
 ov35_other(t,j,land35,type) natveg land pools (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

