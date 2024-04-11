*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 p30_rotation_scenario_fader(t_all) Crop rotation scenario fader (1)
;

positive variables
 vm_area(j,kcr,w)                       Agricultural production area (mio. ha)
 vm_rotation_penalty(i)                 Penalty for violating rotational constraints (USD05MER)
 vm_carbon_stock_croparea(j,ag_pools)   Carbon stock in croparea (tC)
;

equations
 q30_rotation_max(j,crp30,w)        Local maximum rotational constraints (mio. ha)
 q30_rotation_min(j,crp30,w)        Local minimum rotational constraints (mio. ha)
 q30_prod(j,kcr)                    Production of cropped products (mio. tDM)
 q30_carbon(j,ag_pools)             Croplarea above ground carbon content calculation (mio. tC)
 q30_bv_ann(j,potnatveg)            Biodiversity value of annual cropland (mio. ha)
 q30_bv_per(j,potnatveg)            Biodiversity value of perennial cropland (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_fallow(t,j,type)                      Fallow land (mio. ha)
 ov_area(t,j,kcr,w,type)                  Agricultural production area (mio. ha)
 ov_rotation_penalty(t,i,type)            Penalty for violating rotational constraints (USD05MER)
 oq30_cropland(t,j,type)                  Total cropland calculation (mio. ha)
 oq30_avl_cropland(t,j,type)              Available cropland constraint (mio. ha)
 oq30_rotation_max(t,j,crp30,w,type)      Local maximum rotational constraints (mio. ha)
 oq30_rotation_min(t,j,crp30,w,type)      Local minimum rotational constraints (mio. ha)
 oq30_prod(t,j,kcr,type)                  Production of cropped products (mio. tDM)
 oq30_carbon(t,j,ag_pools,stockType,type) Cropland above ground carbon content calculation (mio. tC)
 oq30_bv_ann(t,j,potnatveg,type)          Biodiversity value of annual cropland (mio. ha)
 oq30_bv_per(t,j,potnatveg,type)          Biodiversity value of perennial cropland (mio. ha)
 oq30_land_snv(t,j,type)                  Land constraint for the SNV policy in cropland areas (mio. ha)
 oq30_land_snv_trans(t,j,type)            Land transition constraint for SNV policy in cropland areas (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
