*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

p32_pot_afforest(t,i) = sum((cell(i,j),si)$(fm_carbon_density(t,j,"forestry","vegc") > 20), 
pcm_land(j,"crop",si) + pcm_land(j,"past",si));
p32_min_afforest(t,i)$((p32_min_afforest(t,i) - p32_pot_afforest(t,i))>0) = 0;

**interface boundaries
vm_land.lo(j,"forestry",si) = 0;
vm_land.up(j,"forestry",si) = Inf;

vm_carbon_stock.lo(j,"forestry",c_pools) = 0;
vm_carbon_stock.up(j,"forestry",c_pools) = Inf;

*boundaries afforestation mask
v32_land.lo(j,"new",si) = 0;
v32_land.up(j,"new",si) = f32_aff_mask(j) * sum(land, pcm_land(j,land,si));

*boundary carbon density
v32_land.fx(j,"new",si)$(fm_carbon_density(t,j,"forestry","vegc") <= 20) = 0;

**land
*calculate age class share for each forest land type
ac_land32(ac,land32) = no;
ac_land32(ac,"new")  = yes$(ord(ac) = 1);
ac_land32(ac,"prot") = yes$(ord(ac) > 1 AND (ord(ac)-1) <= sm_invest_horizon/5);
ac_land32(ac,"grow") = yes$((ord(ac)-1) > sm_invest_horizon/5 AND ord(ac) < card(ac));
ac_land32(ac,"old")  = yes$(ord(ac) = card(ac));

*shift age-classes according to time step length
s32_shift = m_yeardiff(t)/5;
if((ord(t) = 1),
    p32_land_fore(t,j,ac,si,"before") = 0$(not sameas(ac,"acx")) + pcm_land(j,"forestry",si)$(sameas(ac,"acx"));
else
    p32_land_fore(t,j,ac,si,"before") =
                      0$(ord(ac) = 1)
                    + p32_land_fore(t-1,j,ac-s32_shift,si,"after")$(ord(ac) > 1 AND ord(ac) < card(ac))
                    + p32_land_fore(t-1,j,ac,si,"after")$(ord(ac) = card(ac));
);

*calculate v32_land.l
v32_land.l(j,land32,si) = sum(ac_land32(ac,land32), p32_land_fore(t,j,ac,si,"before"));
pc32_land_fore(j,land32,si) = v32_land.l(j,land32,si);

*set boundaries
v32_land.fx(j,"prot",si) = pc32_land_fore(j,"prot",si);

v32_land.lo(j,"grow",si) = 0;
v32_land.up(j,"grow",si) = pc32_land_fore(j,"grow",si);
m_boundfix(v32_land,(j,"grow",si),l,10e-5);

*fix forestry area for wood production
v32_land.fx(j,"old",si) = pc32_land_fore(j,"old",si);

*calculate carbon density
p32_carbon_density(t,j,"new",c_pools) = pm_carbon_density_ac(t,j,"ac0",c_pools);
p32_carbon_density(t,j,"prot",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p32_land_fore(t,j,ac,si,"before"),(ac_land32(ac,"prot"),si));
p32_carbon_density(t,j,"grow",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p32_land_fore(t,j,ac,si,"before"),(ac_land32(ac,"grow"),si));
p32_carbon_density(t,j,"old",c_pools) = pm_carbon_density_ac(t,j,"acx",c_pools);

pc32_carbon_density(j,land32,c_pools) = p32_carbon_density(t,j,land32,c_pools);
pc32_carbon_density_ac(j,ac,c_pools) = pm_carbon_density_ac(t,j,ac,c_pools);

*** EOF presolve.gms ***
