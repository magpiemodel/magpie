*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*shift age-classes according to time step length
s35_shift = m_yeardiff(t)/5;
if((ord(t) = 1),
	p35_land(t,j,ac,si,"before") = i35_land(j,ac,si);
else
	p35_land(t,j,ac,si,"before") =
				    0$(ord(ac) = 1)
                  + p35_land(t-1,j,ac-s35_shift,si,"after")$(ord(ac) > 1 AND ord(ac) < card(ac))
                  + p35_land(t-1,j,ac,si,"after")$(ord(ac) = card(ac));
);

*calculate new v35_land.l
pc35_land(j,land35,si) = sum(ac_land35(ac,land35), p35_land(t,j,ac,si,"before"));
v35_land.l(j,land35,si) = pc35_land(j,land35,si);
pcm_land(j,"other",si) = sum(land35, pc35_land(j,land35,si));
vm_land.l(j,"other",si) = pcm_land(j,"other",si);

*set boundaries
v35_land.lo(j,"new",si) = 0;
v35_land.up(j,"new",si) = Inf;

v35_land.lo(j,"grow",si) = pc35_land(j,"grow",si)*sum(cell(i,j), p35_protect_other(t,i));
v35_land.up(j,"grow",si) = pc35_land(j,"grow",si);
m_boundfix(v35_land,(j,"grow",si),l,10e-5);

v35_land.lo(j,"old",si) = pc35_land(j,"old",si)*sum(cell(i,j), p35_protect_other(t,i));
v35_land.up(j,"old",si) = pc35_land(j,"old",si);
m_boundfix(v35_land,(j,"old",si),l,10e-5);

if((ord(t) = 1),
*highest carbon density 1st time step to account for reshuffling
	p35_carbon_density(t,j,land35,c_pools) = pm_carbon_density_ac(t,j,"acx",c_pools);
else
*calculate carbon density
	p35_carbon_density(t,j,"new",c_pools) = pm_carbon_density_ac(t,j,"ac0",c_pools);
	p35_carbon_density(t,j,"grow",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p35_land(t,j,ac,si,"before"),(ac_land35(ac,"grow"),si));
	p35_carbon_density(t,j,"old",c_pools) = pm_carbon_density_ac(t,j,"acx",c_pools);
);

pc35_carbon_density(j,land35,c_pools) = p35_carbon_density(t,j,land35,c_pools);

*carbon stock update
pcm_carbon_stock(j,"other",c_pools) = sum(land35, pc35_carbon_density(j,land35,c_pools)*sum(si, pc35_land(j,land35,si)));
vm_carbon_stock.l(j,"other",c_pools) = pcm_carbon_stock(j,"other",c_pools);
