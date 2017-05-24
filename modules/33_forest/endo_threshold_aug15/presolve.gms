*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*shift age-classes according to time step length
s33_shift = m_yeardiff(t)/5;
if((ord(t) = 1),
        p33_land(t,j,ac,"before") = 0;
        p33_land(t,j,"acx","before") = pcm_land(j,"secdforest");
else
*add recovered forest area
                p33_land(t-1,j,ac,"after") = p33_land(t-1,j,ac,"after") + pm_recovered_forest(t-1,j,ac);
                p33_land(t,j,ac,"before") =
                                    0$(ord(ac) = 1)
                  + p33_land(t-1,j,ac-s33_shift,"after")$(ord(ac) > 1 AND ord(ac) < card(ac))
                  + p33_land(t-1,j,ac,"after")$(ord(ac) = card(ac));
);

pcm_land(j,"secdforest") = sum(ac, p33_land(t,j,ac,"before"));
vm_land.l(j,"secdforest") = pcm_land(j,"secdforest");

*calculate carbon density
p33_carbon_density(t,j,c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p33_land(t,j,ac,"before"),(ac));

*carbon stock correction
pcm_carbon_stock(j,"secdforest",c_pools) = p33_carbon_density(t,j,c_pools)*pcm_land(j,"secdforest");
vm_carbon_stock.l(j,"secdforest",c_pools) = pcm_carbon_stock(j,"secdforest",c_pools);

*set bounds
vm_land.lo(j,"primforest") = 0;
vm_land.up(j,"primforest") = pcm_land(j,"primforest");
m_boundfix(vm_land,(j,"primforest"),l,10e-5);

vm_land.lo(j,"secdforest") = 0;
vm_land.up(j,"secdforest") = pcm_land(j,"secdforest");
m_boundfix(vm_land,(j,"secdforest"),l,10e-5);
