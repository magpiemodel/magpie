*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' Land establishment costs apply on expansion of cropland, pasture and forestry.
*' Land clearing costs apply on reduction of carbon stock in primary forest, secondary forest
*' and other natural land.
*' The sum of land establishment and land clearing costs in the current time step
*' is multiplied with an annuity factor to distribute these costs over time.

q39_cost_landcon(j2,land) .. vm_cost_landcon(j2,land) =e=
	(vm_landexpansion(j2,land)*sum((ct,cell(i2,j2)), i39_cost_establish(ct,i2,land))
 	+ vm_carbon_stock_change(j2,land,"vegc")*i39_cost_clearing(land))
 	* sum((cell(i2,j2),ct),pm_interest(ct,i2)/(1+pm_interest(ct,i2)));
