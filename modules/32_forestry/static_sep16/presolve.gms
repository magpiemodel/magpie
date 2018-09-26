*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @code 
*' Forestry carbon stocks are calculated by multiplying plantations in 1995 
*' with the forestry carbon density of the current time step (`pc32_carbon_density`).
pc32_carbon_density(j,c_pools) = fm_carbon_density(t,j,"forestry",c_pools);
vm_carbon_stock.fx(j,"forestry",c_pools) = vm_land.l(j,"forestry")*pc32_carbon_density(j,c_pools);

*' Wood demand is also set to zero because forestry is not modeled in this realization.
vm_supply.fx(i2,kforestry) = 0;
*' @stop

*** EOF presolve.gms ***
