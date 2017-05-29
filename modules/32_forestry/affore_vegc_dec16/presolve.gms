
**interface boundaries
vm_land.lo(j,"forestry") = 0;
vm_land.up(j,"forestry") = Inf;

vm_carbon_stock.lo(j,"forestry",c_pools) = 0;
vm_carbon_stock.up(j,"forestry",c_pools) = Inf;

*boundaries afforestation mask
v32_land.lo(j,"new") = 0;
v32_land.up(j,"new") = f32_aff_mask(j) * sum(land, pcm_land(j,land));

*boundary carbon density
v32_land.fx(j,"new")$(fm_carbon_density(t,j,"forestry","vegc") <= 20) = 0;

**land
*calculate age class share for each forest land type
j_ac_land32(j,ac,land32) = no;
j_ac_land32(j,ac,"new")  = yes$(ord(ac) = 1);
j_ac_land32(j,ac,"prot") = yes$(ord(ac) > 1 AND (ord(ac)-1) <= sm_invest_horizon/5);
j_ac_land32(j,ac,"grow") = yes$((ord(ac)-1) > sm_invest_horizon/5 AND ord(ac) < card(ac));
j_ac_land32(j,ac,"old")  = yes$(ord(ac) = card(ac));

*shift age-classes according to time step length
s32_shift = sm_years/5;
if((ord(t) = 1),
    p32_land_fore(t,j,ac,"before") = 0$(not sameas(ac,"acx")) + pcm_land(j,"forestry")$(sameas(ac,"acx"));
else
    p32_land_fore(t,j,ac,"before") =
                      0$(ord(ac) = 1)
                    + p32_land_fore(t-1,j,ac-s32_shift,"after")$(ord(ac) > 1 AND ord(ac) < card(ac))
                    + p32_land_fore(t-1,j,ac,"after")$(ord(ac) = card(ac));
);

*calculate v32_land.l
v32_land.l(j,land32) = sum(j_ac_land32(j,ac,land32), p32_land_fore(t,j,ac,"before"));
pc32_land_fore(j,land32) = v32_land.l(j,land32);

*set boundaries
v32_land.fx(j,"prot") = pc32_land_fore(j,"prot");

*v32_land.lo(j,"grow") = 0;
v32_land.fx(j,"grow") = pc32_land_fore(j,"grow");
*m_boundfix(v32_land,(j,"grow"),l,10e-5);

*fix forestry area for wood production
v32_land.fx(j,"old") = pc32_land_fore(j,"old");

*calculate carbon density with CC
p32_carbon_density_cc(t,j,"new",c_pools) = pm_carbon_density_ac(t,j,"ac0",c_pools);
p32_carbon_density_cc(t,j,"prot",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p32_land_fore(t,j,ac,"before"),(j_ac_land32(j,ac,"prot")));
p32_carbon_density_cc(t,j,"grow",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p32_land_fore(t,j,ac,"before"),(j_ac_land32(j,ac,"grow")));
p32_carbon_density_cc(t,j,"old",c_pools) = pm_carbon_density_ac(t,j,"acx",c_pools);

*calculate carbon density without CC
p32_carbon_density_nocc(t,j,"new",c_pools) = pm_carbon_density_ac("y1995",j,"ac0",c_pools);
p32_carbon_density_nocc(t,j,"prot",c_pools) = m_weightedmean(pm_carbon_density_ac("y1995",j,ac,c_pools),p32_land_fore(t,j,ac,"before"),(j_ac_land32(j,ac,"prot")));
p32_carbon_density_nocc(t,j,"grow",c_pools) = m_weightedmean(pm_carbon_density_ac("y1995",j,ac,c_pools),p32_land_fore(t,j,ac,"before"),(j_ac_land32(j,ac,"grow")));
p32_carbon_density_nocc(t,j,"old",c_pools) = pm_carbon_density_ac("y1995",j,"acx",c_pools);

*set carbon density according to sm_cc_carbon switch (with or without climate impacts)
pc32_carbon_density(j,land32,c_pools) = 
	p32_carbon_density_cc(t,j,land32,c_pools)$(sm_cc_carbon = 1) + 
	p32_carbon_density_nocc(t,j,land32,c_pools)$(sm_cc_carbon = 0);

pc32_carbon_density_ac(j,ac,c_pools) = 
	pm_carbon_density_ac(t,j,ac,c_pools)$(sm_cc_carbon = 1) + 
	pm_carbon_density_ac("y1995",j,ac,c_pools)$(sm_cc_carbon = 0);

*** EOF presolve.gms ***
