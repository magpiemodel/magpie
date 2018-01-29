*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

pc32_carbon_density(j,c_pools) = fm_carbon_density(t,j,"forestry",c_pools);

vm_carbon_stock.fx(j,"forestry",c_pools) = vm_land.l(j,"forestry")*pc32_carbon_density(j,c_pools);

*
vm_supply.fx(i2,kforestry) = 0;

*** EOF presolve.gms ***
