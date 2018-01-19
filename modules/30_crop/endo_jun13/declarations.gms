*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_area(j,kcr,w)                agricultural production area (mio. ha)
;

equations
 q30_cropland(j)                 crop conversion constraint
 q30_suitability(j)              suitability constraint
 q30_rotation_max(j,crp30,w)     local rotational constraints
 q30_rotation_min(j,crp30,w)     local rotational constraints (minimum)
 q30_prod(j,kcr)                 production constraint for vegetal products
 q30_carbon(j,c_pools)           cropland carbon content calculation soilc
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_area(t,j,kcr,w,type)             agricultural production area (mio. ha)
 oq30_cropland(t,j,type)             crop conversion constraint
 oq30_suitability(t,j,type)          suitability constraint
 oq30_rotation_max(t,j,crp30,w,type) local rotational constraints
 oq30_rotation_min(t,j,crp30,w,type) local rotational constraints (minimum)
 oq30_prod(t,j,kcr,type)             production constraint for vegetal products
 oq30_carbon(t,j,c_pools,type)       cropland carbon content calculation soilc
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
