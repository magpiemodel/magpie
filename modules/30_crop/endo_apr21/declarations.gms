*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 p30_avl_cropland(t,j)             	Total available land for crop cultivation (mio. ha)
 p30_region_setaside_shr(i)			Set-aside share of the region (1)
 p30_country_dummy(iso)		        Dummy parameter indicating whether country is affected by selected set-aside policy (1)
 i30_avl_cropland_iso(iso)			Available land area for cropland at ISO level (mio. ha)
;

positive variables
 vm_area(j,kcr,w)                Agricultural production area (mio. ha)
;

equations
 q30_cropland(j)                 Total cropland calculation (mio. ha)
 q30_avl_cropland(j)             Available cropland constraint (mio. ha)
 q30_rotation_max(j,crp30,w)     Local maximum rotational constraints (mio. ha)
 q30_rotation_min(j,crp30,w)     Local minimum rotational constraints (mio. ha)
 q30_prod(j,kcr)                 Production of cropped products (mio. tDM)
 q30_carbon(j,ag_pools,stockType) Cropland above ground carbon content calculation (mio. tC)
 q30_bv_ann(j,potnatveg)         Biodiversity value of annual cropland (Mha)
 q30_bv_per(j,potnatveg)         Biodiversity value of perennial cropland (Mha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_area(t,j,kcr,w,type)                  Agricultural production area (mio. ha)
 oq30_cropland(t,j,type)                  Total cropland calculation (mio. ha)
 oq30_avl_cropland(t,j,type)              Available cropland constraint (mio. ha)
 oq30_rotation_max(t,j,crp30,w,type)      Local maximum rotational constraints (mio. ha)
 oq30_rotation_min(t,j,crp30,w,type)      Local minimum rotational constraints (mio. ha)
 oq30_prod(t,j,kcr,type)                  Production of cropped products (mio. tDM)
 oq30_carbon(t,j,ag_pools,stockType,type) Cropland above ground carbon content calculation (mio. tC)
 oq30_bv_ann(t,j,potnatveg,type)          Biodiversity value of annual cropland (Mha)
 oq30_bv_per(t,j,potnatveg,type)          Biodiversity value of perennial cropland (Mha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
