*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
