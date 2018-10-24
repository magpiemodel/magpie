*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

* Limit demand for prescribed NPI/NDC afforestation in `p32_aff_pol` if not enough suitable area (`p32_aff_pot`) for afforestation is available.
	p32_aff_pot(t,j) = pcm_land(j,"crop") + pcm_land(j,"past");
	if((ord(t) > 1),
		p32_aff_pol(t,j)$(p32_aff_pol(t,j) - p32_aff_pol(t-1,j) > p32_aff_pot(t,j)) = p32_aff_pol(t-1,j) + p32_aff_pot(t,j);
	);

* Calculate NPI/NDC afforestation per time step based on stock changes.
	p32_aff_pol_timestep("y1995",j) = 0;
	p32_aff_pol_timestep(t,j)$(ord(t)>1) = p32_aff_pol(t,j) - p32_aff_pol(t-1,j);

*' @code
*' Wood demand is set to zero because forestry is not modeled in this realization.
vm_supply.fx(i2,kforestry) = 0;

*' Certain areas (e.g. the boreal zone) are excluded from endogenous afforestation.
v32_land.lo(j,"new") = 0;
v32_land.up(j,"new") = f32_aff_mask(j) * sum(land, pcm_land(j,land));

*' Endogenous afforestation is limited to cells with vegetation carbon density above 20 tC/ha.
v32_land.fx(j,"new")$(fm_carbon_density(t,j,"forestry","vegc") <= 20) = 0;
*' @stop

* Mapping `ac_land32` between age classes `ac` and forest land types `land32` depending on
* the 30-year planning horizon `s32_planing_horizon`. The mapping `ac_land32` is used to 
* aggregate age classes in `p32_land` for the optimization. Note that age-classes exist 
* only between the optimization time steps (see below). 
ac_land32(ac,land32) = no;
ac_land32(ac,"new")  = yes$(ord(ac) = 1);
ac_land32(ac,"new_ndc") = yes$(ord(ac) = 1);
ac_land32(ac,"prot") = yes$(ord(ac) > 1 AND (ord(ac)-1) <= s32_planing_horizon/5);
ac_land32(ac,"grow") = yes$((ord(ac)-1) > s32_planing_horizon/5 AND ord(ac) < card(ac));
ac_land32(ac,"old")  = yes$(ord(ac) = card(ac));

* Regrowth of natural vegetation (natural succession) is modelled by shifting age-classes according to time step length.
s32_shift = m_yeardiff(t)/5;
if((ord(t) = 1),
    p32_land(t,j,ac,"before") = 0$(not sameas(ac,"acx")) + pcm_land(j,"forestry")$(sameas(ac,"acx"));
else
* example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s32_shift = 1)
    p32_land(t,j,ac,"before")$(ord(ac) > s32_shift) = p32_land(t-1,j,ac-s32_shift,"after");
* account for cases at the end of the age class set (s32_shift > 1) which are not shifted by the above calculation
    p32_land(t,j,"acx","before") = p32_land(t,j,"acx","before")
                  + sum(ac$(ord(ac) > card(ac)-s32_shift), p32_land(t-1,j,ac,"after"));
);

* Age-classes exist only between the optimization time steps.
* For the optimization, we aggregate age-classes to 5 groups defined in `land32`.
v32_land.l(j,land32) = sum(ac_land32(ac,land32), p32_land(t,j,ac,"before"));
pc32_land(j,land32) = v32_land.l(j,land32);
vm_land.l(j,"forestry") = sum(land32, pc32_land(j,land32));
pcm_land(j,"forestry") = sum(land32, pc32_land(j,land32));

* Fix forestry land to current levels, i.e. forestry land can not decrease in size within the optimization. 
* Since there is no bound on `v32_land(j,"new")` forestry land can increase in size within the optimization. 
v32_land.fx(j,"prot") = pc32_land(j,"prot");
v32_land.fx(j,"grow") = pc32_land(j,"grow");
v32_land.fx(j,"old") = pc32_land(j,"old");

* Aggregate carbon density from `ac` to `land32` for the optimization
p32_carbon_density(t,j,"new",c_pools) = pm_carbon_density_ac(t,j,"ac0",c_pools);
p32_carbon_density(t,j,"new_ndc",c_pools) = pm_carbon_density_ac(t,j,"ac0",c_pools);
p32_carbon_density(t,j,"prot",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p32_land(t,j,ac,"before"),(ac_land32(ac,"prot")));
p32_carbon_density(t,j,"grow",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p32_land(t,j,ac,"before"),(ac_land32(ac,"grow")));
p32_carbon_density(t,j,"old",c_pools) = pm_carbon_density_ac(t,j,"acx",c_pools);



*** EOF presolve.gms ***
