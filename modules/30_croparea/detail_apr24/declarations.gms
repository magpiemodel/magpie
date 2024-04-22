*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i30_rotation_rules(t_all,rota30)       Rotational constraints (1)
 i30_rotation_incentives(t_all,rota30)  Penalty for violating rotational constraints (USD05MER per ha)
 p30_rotation_scenario_fader(t_all)     Crop rotation scenario fader (1)
 i30_implementation              Switch for rule-based (1) or penalty-based (0) implementation of rotation scenarios
;

positive variables
 vm_area(j,kcr,w)                     Agricultural production area (mio. ha)
 vm_rotation_penalty(i)               Penalty for violating rotational constraints (mio. USD05MER)
 vm_carbon_stock_croparea(j,ag_pools) Carbon stock in croparea (tC)
 v30_penalty_max_irrig(j,rotamax30)   Penalty for violating max rotational constraints on irrigated land (mio. USD05MER)
 v30_penalty(j,rota30)                Penalty for violating rotational constraints (mio. USD05MER)
;

equations
 q30_prod(j,kcr)                      Production of cropped products (mio. tDM)
 q30_rotation_penalty(i)              Total penalty for rotational constraint violations (mio. USD05MER)
 q30_rotation_max(j,rotamax30)        Local maximum rotational constraints (mio. ha)
 q30_rotation_min(j,rotamin30)        Local minimum rotational constraints (mio. ha)
 q30_rotation_max2(j,rotamax30)        Local maximum rotational constraints (mio. ha)
 q30_rotation_min2(j,rotamin30)        Local minimum rotational constraints (mio. ha)
 q30_rotation_max_irrig(j,rotamax30)  Local maximum rotational constraints (mio. ha)
 q30_carbon(j,ag_pools)               Croplarea above ground carbon content calculation (mio. tC)
 q30_bv_ann(j,potnatveg)              Biodiversity value of annual cropland (mio. ha)
 q30_bv_per(j,potnatveg)              Biodiversity value of perennial cropland (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_area(t,j,kcr,w,type)                     Agricultural production area (mio. ha)
 ov_rotation_penalty(t,i,type)               Penalty for violating rotational constraints (mio. USD05MER)
 ov_carbon_stock_croparea(t,j,ag_pools,type) Carbon stock in croparea (tC)
 ov30_penalty_max_irrig(t,j,rotamax30,type)  Penalty for violating max rotational constraints on irrigated land (mio. USD05MER)
 ov30_penalty(t,j,rota30,type)               Penalty for violating rotational constraints (mio. USD05MER)
 oq30_prod(t,j,kcr,type)                     Production of cropped products (mio. tDM)
 oq30_rotation_penalty(t,i,type)             Total penalty for rotational constraint violations (mio. USD05MER)
 oq30_rotation_max(t,j,rotamax30,type)       Local maximum rotational constraints (mio. ha)
 oq30_rotation_min(t,j,rotamin30,type)       Local minimum rotational constraints (mio. ha)
 oq30_rotation_max2(t,j,rotamax30,type)      Local maximum rotational constraints (mio. ha)
 oq30_rotation_min2(t,j,rotamin30,type)      Local minimum rotational constraints (mio. ha)
 oq30_rotation_max_irrig(t,j,rotamax30,type) Local maximum rotational constraints (mio. ha)
 oq30_carbon(t,j,ag_pools,type)              Croplarea above ground carbon content calculation (mio. tC)
 oq30_bv_ann(t,j,potnatveg,type)             Biodiversity value of annual cropland (mio. ha)
 oq30_bv_per(t,j,potnatveg,type)             Biodiversity value of perennial cropland (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
