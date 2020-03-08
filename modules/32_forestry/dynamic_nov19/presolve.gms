*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Declare new set to distribute newly established plantations evenly for longer
** than 5 year time steps. We then overwrite this with yes for ac_additional
** elements which are lower than difference between years.
ac_additional(ac) = no;
ac_additional(ac) = yes$(ord(ac) <= (m_yeardiff(t)/5));

** Start ndc **
* Limit demand for prescribed NPI/NDC afforestation in `p32_aff_pol` if not enough suitable area (`p32_aff_pot`) for afforestation is available.
   p32_aff_pot(t,j) = (vm_land.l(j,"crop") - vm_land.lo(j,"crop")) + (vm_land.l(j,"past") - vm_land.lo(j,"past"));
*correct ndc forest stock based on p32_aff_pot
  if((ord(t) > 1),
      p32_aff_pol(t,j)$(p32_aff_pol(t,j) - p32_aff_pol(t-1,j) > p32_aff_pot(t,j)) = p32_aff_pol(t-1,j) + p32_aff_pot(t,j);
    );
*calc ndc afforestation per time step based on forest stock changes
  p32_aff_pol_timestep("y1995",j) = 0;
  p32_aff_pol_timestep(t,j)$(ord(t)>1) = p32_aff_pol(t,j) - p32_aff_pol(t-1,j);

** END ndc **

*' @code
*' Certain areas (e.g. the boreal zone) are excluded from endogenous afforestation.
** DON'T USE TYPE32 SET HERE
v32_land.lo(j,"aff","ac0") = 0;
v32_land.up(j,"aff","ac0") = f32_aff_mask(j) * sum(land, pcm_land(j,land));

*' No afforestation is allowed if carbon density <= 20 tc/ha
v32_land.fx(j,"aff","ac0")$(fm_carbon_density(t,j,"forestry","vegc") <= 20) = 0;
m_boundfix(v32_land,(j,"aff","ac0"),l,10e-5);

*' CDR from afforestation for each age-class, depending on planning horizon.
p32_cdr_ac(t,j,ac)$(ord(ac) > 1 AND (ord(ac)-1) <= s32_planing_horizon/5)
= pm_carbon_density_ac(t,j,ac,"vegc") - pm_carbon_density_ac(t,j,ac-1,"vegc");

*' Regrowth of natural vegetation (natural succession) is modelled by shifting
*' age-classes according to time step length. For first year of simulation, the
*' shift is just 1.
s32_shift = (5/5)$(ord(t)=1) + (m_timestep_length/5)$(ord(t)>1);

*' Shifting of age-calsses in land.
if((ord(t)>1),
*' Example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s32_shift = 1)
p32_land(t,j,type32,ac)$(ord(ac) > s32_shift) = p32_land(t-1,j,type32,ac-s32_shift);
*' Account for cases at the end of the age class set (s32_shift > 1) which are not shifted by the above calculation
p32_land(t,j,type32,"acx") = p32_land(t,j,type32,"acx") + sum(ac$(ord(ac) > card(ac)-s32_shift), p32_land(t-1,j,type32,ac));
);
*should not be necessary. Just to be on the save side
p32_land(t,j,type32,"ac0") = 0;

*' @stop

** Calculate v32_land.l
v32_land.l(j,type32,ac) = p32_land(t,j,type32,ac);
pc32_land(j,type32,ac) = p32_land(t,j,type32,ac);
vm_land.l(j,"forestry") = sum((type32,ac), p32_land(t,j,type32,ac));
pcm_land(j,"forestry") = sum((type32,ac), p32_land(t,j,type32,ac));

** Release bounds for ALL Age classes before we make brptection of harvest "indication" decisions
v32_land.lo(j,"plant",ac) = 0;
v32_land.up(j,"plant",ac) = Inf;

** Fix land with rotation length
v32_land.fx(j,"plant",ac_sub)$protect32(t,j,ac_sub) = pc32_land(j,"plant",ac_sub);

** Set upper bound for plantations after rotation length
v32_land.up(j,"plant",ac_sub)$harvest32(t,j,ac_sub) = pc32_land(j,"plant",ac_sub);

** Harvest as soon as you jump out of protection
*v32_land.up(j,"plant",ac_sub)$harvest32(t,j,ac_sub) = 0;
m_boundfix(v32_land,(j,"plant",ac_sub),l,10e-5);

** fix C-price induced afforestation and ndc to zero (for testing)
*v32_land.fx(j,"aff",ac) = 0;
*v32_land.fx(j,"ndc",ac) = 0;

** Bounds for ndc and aff forests
*v32_land.fx(j,"aff","ac0") = 0; --- LATER?
v32_land.fx(j,"aff",ac_sub) = pc32_land(j,"aff",ac_sub);
v32_land.fx(j,"ndc",ac_sub) = pc32_land(j,"ndc",ac_sub);

** Setting ac dependent carbon.
** First, plantations carbon density is set to natveg carbon density
** Later the vegc carbon density is overwritten by vegc carbon density of plantations.
p32_carbon_density_ac(t,j,type32,ac,ag_pools)  = pm_carbon_density_ac(t,j,ac,ag_pools);

** Plantation vegc is different
p32_carbon_density_ac(t,j,"plant",ac,"vegc")  = pm_carbon_density_ac_forestry(t,j,ac,"vegc");

** Future demand relevant in current time step depending on rotation length
** Card is used here to exclude y1965 to y1995 when calculating rotation length calculations for past
*pm_rotation_reg(t,j) = ord(t) + ceil(pm_rot_length_estb(t,j)/5) + card(t_past_ff);
pm_rotation_reg(t,i) = ord(t) + ceil((sum(cell(i,j),pcm_land(j,"forestry")*pm_rot_length_estb(t,j))/sum(cell(i,j),pcm_land(j,"forestry")))/5) + card(t_past_ff);

** Future forestry yield
pc32_yield_forestry_future(j,kforestry) = sum(ac_sub$(ord(ac_sub) = p32_rotation_cellular_estb(t,j)), pm_growing_stock(t,j,ac_sub,kforestry,"forestry"));


********** Dampening factor calculation (Deprecated)
p32_rot_ac(j) = p32_rot_length(t,j)/5;
p32_regional_min(j)   = 1/p32_management_factor(j,"normal");
*p32_dampen_pre(ac,j)  = (1-(1/ord(ac)))$(ord(ac)<p32_rot_ac(j)) + 1$(ord(ac)=p32_rot_ac(j)) + (1-(1/p32_rot_ac(j))*(ord(ac)-p32_rot_ac(j)))$(ord(ac)>p32_rot_ac(j));
p32_dampen_final("ac0",j) = 0;
p32_dampen_pre(ac_sub,j)  = (1-(1/ord(ac_sub)))$(ord(ac_sub)<p32_rot_ac(j)) + 1$(ord(ac_sub)>=p32_rot_ac(j) AND ord(ac_sub)<=18) + (1-(1/p32_rot_ac(j))*(ord(ac_sub)-p32_rot_ac(j)))$(ord(ac_sub)>18);
p32_dampen_final(ac_sub,j) = p32_dampen_pre(ac_sub,j)$(p32_dampen_pre(ac_sub,j) >= p32_regional_min(j)) + p32_regional_min(j)$(p32_dampen_pre(ac_sub,j) < p32_regional_min(j));

*** EOF presolve.gms ***
