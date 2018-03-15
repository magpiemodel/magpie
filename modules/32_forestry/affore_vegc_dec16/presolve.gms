*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

** BEGIN NDC **

**limit demand for afforestation if not enough area for conversion is available
*calc potential afforestation (cropland + pasture)
	p32_aff_pot(t,j) = pcm_land(j,"crop") + pcm_land(j,"past");
*correct ndc forest stock based on p32_aff_pot
	if((ord(t) > 1),
		p32_aff_pol(t,j)$(p32_aff_pol(t,j) - p32_aff_pol(t-1,j) > p32_aff_pot(t,j)) = p32_aff_pol(t-1,j) + p32_aff_pot(t,j);
	);
*calc ndc afforestation per time step based on forest stock changes
	p32_aff_pol_timestep("y1995",j) = 0;
	p32_aff_pol_timestep(t,j)$(ord(t)>1) = p32_aff_pol(t,j) - p32_aff_pol(t-1,j);

** END NDC **

*
vm_supply.fx(i2,kforestry) = 0;

*boundaries afforestation mask
v32_land.lo(j,"new") = 0;
v32_land.up(j,"new") = f32_aff_mask(j) * sum(land, pcm_land(j,land));

*boundary carbon density
v32_land.fx(j,"new")$(fm_carbon_density(t,j,"forestry","vegc") <= 20) = 0;

**land
*calculate age class share for each forest land type
ac_land32(ac,land32) = no;
ac_land32(ac,"new")  = yes$(ord(ac) = 1);
ac_land32(ac,"new_ndc") = yes$(ord(ac) = 1);
ac_land32(ac,"prot") = yes$(ord(ac) > 1 AND (ord(ac)-1) <= sm_invest_horizon/5);
ac_land32(ac,"grow") = yes$((ord(ac)-1) > sm_invest_horizon/5 AND ord(ac) < card(ac));
ac_land32(ac,"old")  = yes$(ord(ac) = card(ac));

*shift age-classes according to time step length
s32_shift = m_yeardiff(t)/5;
if((ord(t) = 1),
    p32_land(t,j,ac,"before") = 0$(not sameas(ac,"acx")) + pcm_land(j,"forestry")$(sameas(ac,"acx"));
else
    p32_land(t,j,ac,"before") =
                      0$(ord(ac) = 1)
                    + p32_land(t-1,j,ac-s32_shift,"after")$(ord(ac) > 1 AND ord(ac) < card(ac))
                    + p32_land(t-1,j,ac,"after")$(ord(ac) = card(ac));
);

*calculate v32_land.l
v32_land.l(j,land32) = sum(ac_land32(ac,land32), p32_land(t,j,ac,"before"));
pc32_land(j,land32) = v32_land.l(j,land32);

*set boundaries
v32_land.fx(j,"prot") = pc32_land(j,"prot");

v32_land.fx(j,"grow") = pc32_land(j,"grow");

*fix forestry area for wood production
v32_land.fx(j,"old") = pc32_land(j,"old");

*calculate carbon density
p32_carbon_density(t,j,"new",c_pools) = pm_carbon_density_ac(t,j,"ac0",c_pools);
p32_carbon_density(t,j,"new_ndc",c_pools) = pm_carbon_density_ac(t,j,"ac0",c_pools);
p32_carbon_density(t,j,"prot",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p32_land(t,j,ac,"before"),(ac_land32(ac,"prot")));
p32_carbon_density(t,j,"grow",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p32_land(t,j,ac,"before"),(ac_land32(ac,"grow")));
p32_carbon_density(t,j,"old",c_pools) = pm_carbon_density_ac(t,j,"acx",c_pools);


*** EOF presolve.gms ***
