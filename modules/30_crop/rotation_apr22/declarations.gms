*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i30_rotation_max_shr(t_all,rotamax30)  Maximum share of a certain crop group on cropland (ha per ha)
 i30_rotation_min_shr(t_all,rotamin30)  Minimum share of a certain crop group on cropland (ha per ha)
 p30_rotation_scenario_fader(t_all)     Crop rotation scenario fader (1)
 p30_betr_scenario_fader(t_all)       Bioenergy trees scenario fader (1)
 p30_betr_min_shr(t,j)                Minimum share of bioenergy trees on cropland (1)
;

positive variables
 vm_area(j,kcr,w)                       Agricultural production area (mio. ha)
 vm_rotation_penalty(i)                 Penalty for violating rotational constraints (USD05MER)
 vm_carbon_stock_croparea(j,ag_pools)   Carbon stock in croparea (tC)
;

equations
 q30_prod(j,kcr)                        Production of cropped products (mio. tDM)
 q30_rotation_max(j,rotamax30)          Local maximum rotational constraints (mio. ha)
 q30_rotation_min(j,rotamin30)          Local minimum rotational constraints (mio. ha)
 q30_rotation_max_irrig(j,rotamax30)    Local maximum rotational constraints (mio. ha)
 q30_betr_shr(j)                        Bioenergy trees minimum share (mio. ha)
 q30_carbon(j,ag_pools)                 Croplarea above ground carbon content calculation (mio. tC)
 q30_bv_ann(j,potnatveg)                Biodiversity value of annual cropland (mio. ha)
 q30_bv_per(j,potnatveg)                Biodiversity value of perennial cropland (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_area(t,j,kcr,w,type)                     Agricultural production area (mio. ha)
 ov_rotation_penalty(t,i,type)               Penalty for violating rotational constraints (USD05MER)
 ov_carbon_stock_croparea(t,j,ag_pools,type) Carbon stock in croparea (tC)
 oq30_prod(t,j,kcr,type)                     Production of cropped products (mio. tDM)
 oq30_rotation_max(t,j,rotamax30,type)       Local maximum rotational constraints (mio. ha)
 oq30_rotation_min(t,j,rotamin30,type)       Local minimum rotational constraints (mio. ha)
 oq30_rotation_max_irrig(t,j,rotamax30,type) Local maximum rotational constraints (mio. ha)
 oq30_betr_shr(t,j,type)                     Bioenergy trees minimum share (mio. ha)
 oq30_carbon(t,j,ag_pools,type)              Croplarea above ground carbon content calculation (mio. tC)
 oq30_bv_ann(t,j,potnatveg,type)             Biodiversity value of annual cropland (mio. ha)
 oq30_bv_per(t,j,potnatveg,type)             Biodiversity value of perennial cropland (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
