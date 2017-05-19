*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*add recovered forest area
vm_land.l(j,"forest",si) = vm_land.l(j,"forest",si) + sum(ac, pm_recovered_forest(t,j,ac,si));

pc33_carbon_density(j,c_pools) = fm_carbon_density(t,j,"forest",c_pools);

*carbon stock update
pcm_carbon_stock(j,"forest",c_pools) = sum(si, vm_land.l(j,"forest",si))*pc33_carbon_density(j,c_pools);

vm_carbon_stock.fx(j,"forest",c_pools) =
          sum(si, vm_land.l(j,"forest",si))*pc33_carbon_density(j,c_pools);
