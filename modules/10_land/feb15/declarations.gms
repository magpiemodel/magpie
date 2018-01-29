*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


parameters
 pm_land_start(j,land)         areas of different land pools and types (si0 and nsi0) from initialization [mio. ha]
 pcm_land(j,land)              area of different land types in the previous timestep (mio. ha)
;

variables
 vm_landdiff    aggregated difference in land between current and previous timestep (mio. ha)
;

positive variables
 vm_land(j,land)                   areas of the different land types (mio.ha)
 vm_landexpansion(j,land)         land expansion (mio. ha)
 vm_landreduction(j,land)         land reduction (mio. ha)
;

equations
 q10_land(j)                    land conversion constraint
 q10_landexpansion(j,land)      land expansion constraint
 q10_landreduction(j,land)      land reduction constraint
 q10_landdiff                      land difference constraint
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_landdiff(t,type)               aggregated difference in land between current and previous timestep (mio. ha)
 ov_land(t,j,land,type)            areas of the different land types (mio.ha)
 ov_landexpansion(t,j,land,type)   land expansion (mio. ha)
 ov_landreduction(t,j,land,type)   land reduction (mio. ha)
 oq10_land(t,j,type)               land conversion constraint
 oq10_landexpansion(t,j,land,type) land expansion constraint
 oq10_landreduction(t,j,land,type) land reduction constraint
 oq10_landdiff(t,type)             land difference constraint
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
