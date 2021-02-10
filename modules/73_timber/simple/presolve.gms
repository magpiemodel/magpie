*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Goal: age-class initialization is independent from timber on/off

* For this, we add a new 73_timber/simple realization, which fixed harvested area. No wood demand/production modelled. 
* 73_timber/simple would be the new default. Plantation area would be static, but age-classes are harvested at rotation age and added again in ac0, which causes emissions and regrowth.

* We change the module contract such that the timber module is responsible for harvested area (plant,natveg) and establishemnt (plant).

*** Major changes needed
*q32_establishment_min_reg(i2) needs to be moved to 73_timber/biomass_mar20
* remove q32_fix_plant_area ?
** For Testing, =n= in q32_establishment_min_reg and q32_fix_plant_area
* p32_plantation_contribution(ct,i2) and f32_estb_calib(i2) need to be moved to 73_timber/biomass_mar20
*in timber73/simple: establishment = harvested timber plant 

** interfaces not needed anymore:
*pm_demand_forestry_future
*sm_timber_demand_switch

** new interfaces required:
*p32_rotation_cellular_estb -> pm_rotation_cellular_estb
*v32_land -> vm_forestry or vm_land_forestry
*v35_secdforest -> vm_secdforest or vm_land_secdforest
*v35_other -> vm_other or vm_land_other # or fix vm_hvarea_other.fx(j,ac_sub) = 0;

* changes in magpie4 R library needed.

vm_cost_timber.fx(i) = 0;
vm_hvarea_forestry.fx(j,ac_sub) = v32_land.l(j,"plant",ac_sub) - v32_land.lo(j,"plant",ac_sub);
vm_hvarea_secdforest.fx(j,ac_sub) = (v35_secdforest.l(j,ac_sub) - v35_secdforest.lo(j,ac_sub))*0.005*m_timestep_length_forestry;
vm_hvarea_primforest.fx(j) = (vm_land.l(j,"primforest") - vm_land.lo(j,"primforest"))*0.0001*m_timestep_length_forestry;
vm_hvarea_other.fx(j,ac_sub) = (v35_other.l(j,ac_sub) - v35_other.lo(j,ac_sub))*0*m_timestep_length_forestry;

