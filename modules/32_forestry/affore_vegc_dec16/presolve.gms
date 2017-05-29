

*boundaries afforestation mask
v32_land.lo(j,"new") = 0;
v32_land.up(j,"new") = f32_aff_mask(j) * sum(land, pcm_land(j,land));

*boundary carbon density
v32_land.fx(j,"new")$(fm_carbon_density(t,j,"forestry","vegc") <= 20) = 0;

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
    p32_land_fore(t,j,ac,"before") = 0$(not sameas(ac,"acx")) + pcm_land(j,"forestry")$(sameas(ac,"acx"));
else
    p32_land_fore(t,j,ac,"before") =
                      0$(ord(ac) = 1)
                    + p32_land_fore(t-1,j,ac-s32_shift,"after")$(ord(ac) > 1 AND ord(ac) < card(ac))
                    + p32_land_fore(t-1,j,ac,"after")$(ord(ac) = card(ac));
);

*calculate v32_land.l
v32_land.l(j,land32) = sum(ac_land32(ac,land32), p32_land_fore(t,j,ac,"before"));
pc32_land_fore(j,land32) = v32_land.l(j,land32);

*set boundaries
v32_land.fx(j,"prot") = pc32_land_fore(j,"prot");

v32_land.fx(j,"grow") = pc32_land_fore(j,"grow");

*fix forestry area for wood production
v32_land.fx(j,"old") = pc32_land_fore(j,"old");

*calculate carbon density
p32_carbon_density(t,j,"new",c_pools) = pm_carbon_density_ac(t,j,"ac0",c_pools);
p32_carbon_density(t,j,"prot",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p32_land_fore(t,j,ac,"before"),(ac_land32(ac,"prot")));
p32_carbon_density(t,j,"grow",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p32_land_fore(t,j,ac,"before"),(ac_land32(ac,"grow")));
p32_carbon_density(t,j,"old",c_pools) = pm_carbon_density_ac(t,j,"acx",c_pools);


*** EOF presolve.gms ***
