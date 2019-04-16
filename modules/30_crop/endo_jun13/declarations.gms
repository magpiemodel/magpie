*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_area(j,kcr,w)                Agricultural production area (mio. ha)
;

equations
 q30_cropland(j)                 Total cropland calculation (mio. ha)
 q30_suitability(j)              Suitability constraint (mio. ha)
 q30_rotation_max(j,crp30,w)     Local maximum rotational constraints (mio. ha)
 q30_rotation_min(j,crp30,w)     Local minimum rotational constraints (mio. ha)
 q30_prod(j,kcr)                 Production of cropped products (mio. tDM)
 q30_carbon(j,c_pools)           Cropland carbon content calculation (mio. tC)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_area(t,j,kcr,w,type)             Agricultural production area (mio. ha)
 oq30_cropland(t,j,type)             Total cropland calculation (mio. ha)
 oq30_suitability(t,j,type)          Suitability constraint (mio. ha)
 oq30_rotation_max(t,j,crp30,w,type) Local maximum rotational constraints (mio. ha)
 oq30_rotation_min(t,j,crp30,w,type) Local minimum rotational constraints (mio. ha)
 oq30_prod(t,j,kcr,type)             Production of cropped products (mio. tDM)
 oq30_carbon(t,j,c_pools,type)       Cropland carbon content calculation (mio. tC)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
