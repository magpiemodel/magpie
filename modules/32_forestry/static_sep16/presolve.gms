*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' Forestry above ground carbon stocks are calculated by multiplying plantations in 1995
*' with the forestry above ground carbon density of the current time step (`pc32_carbon_density`).
pc32_carbon_density(j,ag_pools) = fm_carbon_density(t,j,"forestry",ag_pools);
vm_carbon_stock.fx(j,"forestry",ag_pools) = 
	sum((type32,ac), v32_land.l(j,type32,ac)*pm_carbon_density_ac(t,j,ac,ag_pools));

*' Wood demand is also set to zero because forestry is not modeled in this realization.
*vm_supply.fx(i2,kforestry) = 0;

*' Production and future trade realated calculations are also set to zero because
*' they are modeled by a different realization of this module.
*vm_prod.fx(j2,kforestry) = 0;
*vm_prod_reg.fx(i2,kforestry) = 0;
vm_prod_future_reg_ff.fx(i,kforestry) = 0;
vm_cost_trade_forestry_ff.fx(i2) = 0;
*' @stop
*** EOF presolve.gms ***
