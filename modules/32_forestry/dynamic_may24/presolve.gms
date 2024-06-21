*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*Reduction of ac_est is not possible.
v32_hvarea_forestry.fx(j,ac_est) = 0;
v32_land_reduction.fx(j,type32,ac_est) = 0;

** START ndc **
* calc NPI/NDC afforestation per time step based on forest stock change
   p32_aff_pol_timestep("y1995",j) = 0;
   p32_aff_pol_timestep(t,j)$(ord(t)>1) = p32_aff_pol(t,j) - p32_aff_pol(t-1,j);
* Suitable area (`p32_aff_pot`) for NPI/NDC afforestation
   p32_aff_pot(t,j) = 0.95 * (sum((kcr,w),vm_area.l(j,kcr,w) - vm_area.lo(j,kcr,w))
                        + (vm_fallow.l(j) - vm_fallow.lo(j)) 
                        + (vm_land.l(j,"past") - vm_land.lo(j,"past")) 
                        - pm_land_conservation(t,j,"other","restore"));
*** NDC/NPI re/afforesation is further constrained by the remaining forest establishment potential
   p32_aff_pot(t,j)$(p32_aff_pot(t,j) > pm_max_forest_est(t,j)) = pm_max_forest_est(t,j);
* suitable area `p32_aff_pot` can be negative, if land restoration is switched on (level smaller than lower bound), therefore set negative values to 0
   p32_aff_pot(t,j)$(p32_aff_pot(t,j) < 1e-6) = 0;
* Limit prescribed NPI/NDC afforestation in `p32_aff_pol_timestep` if not enough suitable area (`p32_aff_pot`) for afforestation is available
   p32_aff_pol_timestep(t,j)$(p32_aff_pol_timestep(t,j) > p32_aff_pot(t,j)) = p32_aff_pot(t,j);
** END ndc **

*' @code
*' Afforestation switch:
*' 0 = Use natveg growth curve towards LPJmL natural vegetation
*' 1 = Use plantation growth curve (faster than natveg) towards LPJmL natural vegetation
if(s32_aff_plantation = 0,
 p32_carbon_density_ac(t,j,"aff",ac,ag_pools) = pm_carbon_density_secdforest_ac(t,j,ac,ag_pools);
elseif s32_aff_plantation = 1,
 p32_carbon_density_ac(t,j,"aff",ac,ag_pools) = pm_carbon_density_plantation_ac(t,j,ac,"vegc");
);

*' Timber plantations carbon densities:
p32_carbon_density_ac(t,j,"plant",ac,ag_pools) = pm_carbon_density_plantation_ac(t,j,ac,ag_pools);

*' NDC carbon densities are natveg carbon densities.
p32_carbon_density_ac(t,j,"ndc",ac,ag_pools) = pm_carbon_density_secdforest_ac(t,j,ac,ag_pools);

*' CDR from afforestation for each age-class, depending on planning horizon.
p32_cdr_ac(t,j,ac)$(ord(ac) > 1 AND (ord(ac)-1) <= s32_planing_horizon/5)
= p32_carbon_density_ac(t,j,"aff",ac,"vegc") - p32_carbon_density_ac(t,j,"aff",ac-1,"vegc");

* Disturbance from generic sources to managed and natural forests
p32_disturbance_loss_ftype32(t,j,"aff",ac_sub) = pc32_land(j,"aff",ac_sub) * f32_forest_shock(t,"%c32_shock_scenario%") * m_timestep_length;
pc32_land(j,"aff",ac_est) = pc32_land(j,"aff",ac_est) + sum(ac_sub,p32_disturbance_loss_ftype32(t,j,"aff",ac_sub))/card(ac_est2);

pc32_land(j,"aff",ac_sub) = pc32_land(j,"aff",ac_sub) - p32_disturbance_loss_ftype32(t,j,"aff",ac_sub);

*' Regrowth of natural vegetation (natural succession) is modelled by shifting
*' age-classes according to time step length. For first year of simulation, the
*' shift is just 1. Division by 5 happends because the age-classes exist in 5 year steps
s32_shift = m_yeardiff_forestry(t)/5;
*' @stop

*' Shifting of age-classes
*` @code
* Example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s32_shift = 1)
p32_land(t,j,type32,ac)$(ord(ac) > s32_shift) = pc32_land(j,type32,ac-s32_shift);
* Account for cases at the end of the age class set (s32_shift > 1) which are not shifted by the above calculation
p32_land(t,j,type32,"acx") = p32_land(t,j,type32,"acx") + sum(ac$(ord(ac) > card(ac)-s32_shift), pc32_land(j,type32,ac));

* set ac_est to zero
p32_land(t,j,type32,ac_est) = 0;
*' @stop

** Calculate v32_land.l
v32_land.l(j,type32,ac) = p32_land(t,j,type32,ac);
pc32_land(j,type32,ac) = p32_land(t,j,type32,ac);
vm_land.l(j,"forestry") = sum((type32,ac), v32_land.l(j,type32,ac));
pcm_land(j,"forestry") = sum((type32,ac), v32_land.l(j,type32,ac));
pcm_land_forestry(j,type32) =  sum(ac, v32_land.l(j,type32,ac));

** reset all bounds
v32_land.lo(j,type32,ac) = 0;
v32_land.up(j,type32,ac) = Inf;

if(s32_hvarea = 0,
*** zero. Fixed timber plantations. No harvest. No establisment.
  v32_hvarea_forestry.fx(j,ac_sub) = 0;
  v32_land.fx(j,"plant",ac) = pc32_land(j,"plant",ac);
  s32_establishment_static = 1;
  s32_establishment_dynamic = 0;
elseif s32_hvarea = 1,
*** exogenous. All timber plantations are harvested at rotation age and are re-established such that the total plantation area remains constant.
  v32_land.fx(j,"plant",ac)$(ac.off < p32_rotation_cellular_harvesting(t,j)) = pc32_land(j,"plant",ac);
  v32_land.fx(j,"plant",ac)$(ac.off >= p32_rotation_cellular_harvesting(t,j)) = 0;
  s32_establishment_static = 1;
  s32_establishment_dynamic = 0;

** Timber plantations can be harvested at rotation age (the economically
** optimal point in time harvesting usually natural forests would be preferred over harvest
** from timber plantations, mainly because the growing stock at rotation age (e.g. 50 years)
** in timber plantations is smaller compared to the growing stock of old-growth primary and
** secondary forest (> 100 years).

elseif s32_hvarea = 2,
*** endogenous. All plantations are harvested at rotation age. Plantation establishment is endogenous.
** Fix timber plantations until the end of the rotation. "ac.off" identical to "ord(ac)-1".
** The offset is needed because the first element of ac is ac0, which is not included in p32_rotation_cellular_harvesting.
  v32_land.fx(j,"plant",ac)$(ac.off < p32_rotation_cellular_harvesting(t,j)) = pc32_land(j,"plant",ac);
** After the rotation period, all plantations are harvested.
  v32_land.fx(j,"plant",ac)$(ac.off >= p32_rotation_cellular_harvesting(t,j)) = 0;
  s32_establishment_static = 0;
  s32_establishment_dynamic = 1;
);
** overwrite bounds for ac_est
v32_land.lo(j,"plant",ac_est) = 0;
v32_land.up(j,"plant",ac_est) = Inf;
v32_land.l(j,"plant",ac_est) = 0.001;


** fix ndc afforestation forever, all age-classes are fixed except ac_est
v32_land.fx(j,"ndc",ac_sub) = pc32_land(j,"ndc",ac_sub);
v32_land.lo(j,"ndc",ac_est) = 0;
v32_land.up(j,"ndc",ac_est) = Inf;

** fix c price induced afforestation based on s32_planing_horizon, fixed only until end of s32_planing_horizon, ac_est is free
if(s32_aff_prot = 0,
  v32_land.fx(j,"aff",ac)$(ac.off <= s32_planing_horizon/5) = pc32_land(j,"aff",ac);
  v32_land.up(j,"aff",ac)$(ac.off > s32_planing_horizon/5) = pc32_land(j,"aff",ac);
elseif s32_aff_prot = 1,
  v32_land.fx(j,"aff",ac) = pc32_land(j,"aff",ac);
);
v32_land.lo(j,"aff",ac_est) = 0;
v32_land.up(j,"aff",ac_est) = Inf;
v32_land.l(j,"aff",ac_est) = 0;

** Certain areas (e.g. the boreal zone) are excluded from endogenous afforestation.
** DON'T USE TYPE32 SET HERE
if(m_year(t) <= sm_fix_SSP2,
  v32_land.fx(j,"aff",ac_est) = 0;
else
  v32_land.lo(j,"aff",ac_est) = 0;
  v32_land.up(j,"aff",ac_est) = f32_aff_mask(j) * sum(land, pcm_land(j,land));
);

*' No afforestation is allowed if carbon density <= 20 tc/ha
v32_land.fx(j,"aff",ac_est)$(fm_carbon_density(t,j,"forestry","vegc") <= 20) = 0;

m_boundfix(v32_land,(j,type32,ac_sub),up,1e-6);

** Calculate future yield based on rotation length
p32_yield_forestry_future(t,j) = sum(ac$(ac.off = p32_rotation_cellular_estb(t,j)), pm_timber_yield(t,j,ac,"forestry"));

* Fader for plantation share in establishment decision
if(ord(t) = 1,
  pc32_prod_forestry_ini(i) = sum(cell(i,j), sum(ac$(ac.off = p32_rotation_cellular_harvesting(t,j)), pm_timber_yield(t,j,ac,"forestry") * p32_land(t,j,"plant",ac))) / m_timestep_length_forestry;
  pc32_plant_contr_ini(i)$(sum(kforestry, pm_demand_forestry(t,i,kforestry)) > 0) = pc32_prod_forestry_ini(i) / sum(kforestry, pm_demand_forestry(t,i,kforestry));
  pc32_plant_contr_ini(i)$(sum(kforestry, pm_demand_forestry(t,i,kforestry)) = 0) = 0;
  p32_plant_contr(t,i) = pc32_plant_contr_ini(i);
else
  p32_plant_contr(t,i) = p32_plant_contr(t-1,i) * (1+i32_plant_contr_growth_fader(t))**m_timestep_length_forestry;
);
p32_plant_contr(t,i)$(p32_plant_contr(t,i) > s32_plant_contr_max) = s32_plant_contr_max;

** demand for establishment decision depends on s32_demand_establishment:
** s32_demand_establishment = 0 static (establishment based on current demand)
** s32_demand_establishment = 1 forward looking (establishment based on future demand according to rotation length)
if(s32_demand_establishment = 1,
  if(m_year(t) <= sm_fix_SSP2,
    p32_demand_forestry_future(t,i,kforestry) = sum(t2$(m_year(t2) = sm_fix_SSP2), pm_demand_forestry(t2,i,kforestry));
  else
    p32_demand_forestry_future(t,i,kforestry) = sum(t_ext$(t_ext.pos = t.pos + p32_rotation_regional(t,i)),pm_demand_forestry(t_ext,i,kforestry));
   );
else
  p32_demand_forestry_future(t,i,kforestry) = pm_demand_forestry(t,i,kforestry);
 );

p32_forestry_product_dist(t,i,kforestry)$(p32_demand_forestry_future(t,i,kforestry) > 0) = p32_demand_forestry_future(t,i,kforestry) / sum(kforestry2, p32_demand_forestry_future(t,i,kforestry2));
p32_forestry_product_dist(t,i,kforestry)$(p32_demand_forestry_future(t,i,kforestry) = 0) = 1/card(kforestry);

p32_future_to_current_demand_ratio(t,i)$(sum(kforestry, pm_demand_forestry(t,i,kforestry)) > 0) = sum(kforestry, p32_demand_forestry_future(t,i,kforestry)) / sum(kforestry, pm_demand_forestry(t,i,kforestry));
p32_future_to_current_demand_ratio(t,i)$(sum(kforestry, pm_demand_forestry(t,i,kforestry)) = 0) = 0;

* Avoid conflict between afforestation for carbon uptake on land and secdforest restoration
pm_land_conservation(t,j,"secdforest","restore")$(pm_land_conservation(t,j,"secdforest","restore") > sum(ac, p32_land(t,j,"ndc",ac) + v32_land.lo(j,"plant",ac) + p32_land(t,j,"aff",ac))+ p32_aff_pol_timestep(t,j))
        = pm_land_conservation(t,j,"secdforest","restore") - (sum(ac, p32_land(t,j,"ndc",ac) + p32_land(t,j,"aff",ac) + v32_land.lo(j,"plant",ac)) + p32_aff_pol_timestep(t,j));
pm_land_conservation(t,j,"secdforest","restore")$(pm_land_conservation(t,j,"secdforest","restore") <= sum(ac, p32_land(t,j,"ndc",ac) + p32_land(t,j,"aff",ac) + v32_land.lo(j,"plant",ac)) + p32_aff_pol_timestep(t,j)) = 0;

*** EOF presolve.gms ***
