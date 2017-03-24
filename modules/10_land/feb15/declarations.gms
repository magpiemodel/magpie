*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


parameters
 pm_land_start(j,land,si)         areas of different land pools and types (si0 and nsi0) from initialization [mio. ha]
 pcm_land(j,land,si)              area of different land types in the previous timestep (mio. ha)
;

variables
 vm_landdiff    aggregated difference in land between current and previous timestep (mio. ha)
;

positive variables
 vm_land(j,land,si)                   areas of the different land types (mio.ha)
 vm_landexpansion(j,land,si)         land expansion (mio. ha)
 vm_landreduction(j,land,si)         land reduction (mio. ha)
;

equations
 q10_land(j,si)                    land conversion constraint
 q10_lu_miti(j)                    land constraint for land-based mitigation
 q10_landexpansion(j,land,si)      land expansion constraint
 q10_landreduction(j,land,si)      land reduction constraint
 q10_landdiff                      land difference constraint
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_landdiff(t,type)                  aggregated difference in land between current and previous timestep (mio. ha)
 ov_land(t,j,land,si,type)            areas of the different land types (mio.ha)
 ov_landexpansion(t,j,land,si,type)   land expansion (mio. ha)
 ov_landreduction(t,j,land,si,type)   land reduction (mio. ha)
 oq10_land(t,j,si,type)               land conversion constraint
 oq10_lu_miti(t,j,type)               land constraint for land-based mitigation
 oq10_landexpansion(t,j,land,si,type) land expansion constraint
 oq10_landreduction(t,j,land,si,type) land reduction constraint
 oq10_landdiff(t,type)                land difference constraint
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
