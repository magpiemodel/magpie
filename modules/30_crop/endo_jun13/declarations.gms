*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 pm_croparea_start(j,kcr)        Agricultural land initialization area (mio. ha)
;

positive variables
 vm_area(j,kcr,w)                Agricultural production area (mio. ha)
;

equations
 q30_cropland(j)                 Total cropland calculation (mio. ha)
 q30_suitability(j)              Suitability constraint (mio. ha)
 q30_rotation_max(j,crp30,w)     Local maximum rotational constraints (mio. ha)
 q30_rotation_min(j,crp30,w)     Local minimum rotational constraints (mio. ha)
 q30_prod(j,kcr)                 Production of cropped products (mio. tDM)
 q30_carbon(j,ag_pools)          Cropland above ground carbon content calculation (mio. tC)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_area(t,j,kcr,w,type)             Agricultural production area (mio. ha)
 oq30_cropland(t,j,type)             Total cropland calculation (mio. ha)
 oq30_suitability(t,j,type)          Suitability constraint (mio. ha)
 oq30_rotation_max(t,j,crp30,w,type) Local maximum rotational constraints (mio. ha)
 oq30_rotation_min(t,j,crp30,w,type) Local minimum rotational constraints (mio. ha)
 oq30_prod(t,j,kcr,type)             Production of cropped products (mio. tDM)
 oq30_carbon(t,j,ag_pools,type)      Cropland aboveground carbon content calculation (mio. tC)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
