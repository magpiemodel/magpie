*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
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
*-->commented annuities
q39_cost_landcon_annuity(j2,land) .. v39_cost_landcon_annuity(j2,land) =e=
	(vm_landexpansion(j2,land)*i39_cost_establish(land)
 	+ vm_carbon_stock_reduction(j2,land,"vegc")*i39_cost_clearing(land));
* 	* sum(cell(i2,j2),pm_interest(i2)/(1+pm_interest(i2)));

*' Land conversion costs in the current time step consist of
*' the annuitized costs for land conversion in the current time step `v39_cost_landcon_annuity`
*' and the land conversion costs from the past `pc39_cost_landcon_past`.
q39_cost_landcon(j2,land) .. vm_cost_landcon(j2,land) =e=
			v39_cost_landcon_annuity(j2,land);
* + pc39_cost_landcon_past(j2,land);
