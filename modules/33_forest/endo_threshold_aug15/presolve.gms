*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*shift age-classes according to time step length
s33_shift = m_yeardiff(t)/5;
if((ord(t) = 1),
        p33_land(t,j,ac,land33,si,"before") = i33_land(j,ac,land33,si);
else
*add recovered forest area
                p33_land(t-1,j,ac,"modnat",si,"after") = p33_land(t-1,j,ac,"modnat",si,"after") + pm_recovered_forest(t-1,j,ac,si);
                p33_land(t,j,ac,land33,si,"before") =
                                    0$(ord(ac) = 1)
                  + p33_land(t-1,j,ac-s33_shift,land33,si,"after")$(ord(ac) > 1 AND ord(ac) < card(ac))
                  + p33_land(t-1,j,ac,land33,si,"after")$(ord(ac) = card(ac));
);

pc33_land(j,land33,si) = sum(ac, p33_land(t,j,ac,land33,si,"before"));
v33_land.l(j,land33,si) = pc33_land(j,land33,si);
pcm_land(j,"forest",si) = sum(land33, pc33_land(j,land33,si));
vm_land.l(j,"forest",si) = pcm_land(j,"forest",si);

*calculate carbon density
p33_carbon_density(t,j,"modnat",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p33_land(t,j,ac,"modnat",si,"before"),(ac,si));
p33_carbon_density(t,j,"ifft",c_pools) = pm_carbon_density_ac(t,j,"acx",c_pools);

pc33_carbon_density(j,land33,c_pools) = p33_carbon_density(t,j,land33,c_pools);

***protection
*i33_save_fore_protect is related to the inital area of forest+forestry

***production
*f33_save_fore_prod is related to the inital area of forest+forestry

***production and protection
*pc33_save_forest is related to the current area of ifft / modnat

*calculate share of ifft and modnat area designated for protection
p33_save_forest(t,i,land33)$(sum((cell(i,j),si,ac), p33_land(t,j,ac,land33,si,"before")) > 0)
  = sum((si,cell(i,j)), pm_land_start(j,"forestry",si)+pm_land_start(j,"forest",si))
  *i33_save_fore_protect(t,i,land33)/sum((cell(i,j),si,ac), p33_land(t,j,ac,land33,si,"before"));

*if not enogugh area for protection is available in ifft protect more area in modnat (and the other way around)
p33_save_forest_shift(t,i,land33)$(p33_save_forest(t,i,land33) > 1)
= sum((si,cell(i,j)), pm_land_start(j,"forestry",si)+pm_land_start(j,"forest",si))*i33_save_fore_protect(t,i,land33)-sum((cell(i,j),si,ac), p33_land(t,j,ac,land33,si,"before"));

p33_save_forest(t,i,land33)$(sum((cell(i,j),si,ac), p33_land(t,j,ac,land33,si,"before")) > 0) =
        p33_save_forest(t,i,land33) + p33_save_forest_shift(t,i,land33)/sum((cell(i,j),si,ac), p33_land(t,j,ac,land33,si,"before"));

*add share of area designated for production to modnat
p33_save_forest(t,i,"modnat")$(sum((cell(i,j),si,ac), p33_land(t,j,ac,"modnat",si,"before")) > 0)
  = p33_save_forest(t,i,"modnat") + sum((si,cell(i,j)), pm_land_start(j,"forestry",si)+pm_land_start(j,"forest",si))
  *f33_save_fore_prod(i)/sum((cell(i,j),si,ac), p33_land(t,j,ac,"modnat",si,"before"));

*reset shares <0 to 0
p33_save_forest(t,i,land33)$(p33_save_forest(t,i,land33)<0) = 0;
*reset shares >1 to 1
p33_save_forest(t,i,land33)$(p33_save_forest(t,i,land33)>1) = 1;

*set full forest protection for first time step
*p33_save_forest(t,i,land33)$(ord(t) = 1) = 1;

*set boundaries
v33_land.lo(j,land33,si) = sum(cell(i,j), p33_save_forest(t,i,land33))*pc33_land(j,land33,si);
v33_land.up(j,land33,si) = pc33_land(j,land33,si);

m_boundfix(v33_land,(j,land33,si),up,10e-5);

vm_carbon_stock.lo(j,"forest",c_pools) = 0;
vm_carbon_stock.up(j,"forest",c_pools) = Inf;

*carbon stock correction
pcm_carbon_stock(j,"forest",c_pools) = sum(land33, pc33_carbon_density(j,land33,c_pools)*sum(si, pc33_land(j,land33,si)));
vm_carbon_stock.l(j,"forest",c_pools) = pcm_carbon_stock(j,"forest",c_pools);