*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

$ontext
*' @code
*' Land clearing costs are additionally scaled with spatially explicit vegetation carbon density.
*'
*' Determine maximum vegetation carbon density in each region.
p39_carbon_density(t,j,land,c_pools)$(vm_land.l(j,land) > 0) = 
	vm_carbon_stock.l(j,land,c_pools)/vm_land.l(j,land);
p39_max_vegc_reg(t,i) = 
	smax((cell(i,j),land_natveg), p39_carbon_density(t,j,land_natveg,"vegc"));
*'
*' Calculate reduction factor for land clearing costs. The cell with the highest 
*' vegetation carbon density in a region has the highest clearing costs in this regions.
*' The clearing costs in all other cells of this region will be reduced based on the ratio
*' of spatially explicit vegetation carbon density `p39_carbon_density` and maximum regional 
*' vegetation carbon density `p39_max_vegc_reg`.
p39_vegc_fact(t,j,land) = 0;
p39_vegc_fact(t,j,land_natveg) = sum(cell(i,j),(p39_carbon_density(t,j,land_natveg,"vegc")
						/ p39_max_vegc_reg(t,i)$(p39_max_vegc_reg(t,i)>0)));
*'
*' Apply the scaling factor `p39_vegc_fact`.
p39_landclear_costs(t,j,land_natveg) = p39_landclear_costs(t,j,land_natveg) 
									   * p39_vegc_fact(t,j,land_natveg);
*' @stop
$offtext

pc39_landclear_costs(j,land) = p39_landclear_costs(t,j,land);
pc39_establish_costs(j,land) = p39_establish_costs(t,j,land);
pc39_cost_landcon_past(j,land) = p39_cost_landcon_past(t,j,land);
                             