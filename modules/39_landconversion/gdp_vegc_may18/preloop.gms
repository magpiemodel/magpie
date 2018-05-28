*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

p39_cost_landcon_past(t,j,land) = 0;

** set the global range of establishment and clearing cost depending on the scenario
$Ifi "%c39_cost_scenario%" == "low" i39_establish_gdp(land,bound39) = f39_establish_gdp(land,"low_estimate",bound39);
$Ifi "%c39_cost_scenario%" == "medium" i39_establish_gdp(land,bound39) = f39_establish_gdp(land,"medium_estimate",bound39);
$Ifi "%c39_cost_scenario%" == "high" i39_establish_gdp(land,bound39) = f39_establish_gdp(land,"high_estimate",bound39);

$Ifi "%c39_cost_scenario%" == "low" i39_landclear_gdp(bound39) = f39_landclear_gdp("low_estimate",bound39);
$Ifi "%c39_cost_scenario%" == "medium" i39_landclear_gdp(bound39) = f39_landclear_gdp("medium_estimate",bound39);
$Ifi "%c39_cost_scenario%" == "high" i39_landclear_gdp(bound39) = f39_landclear_gdp("high_estimate",bound39);

*' @code
*' Regional land establishment and clearing costs
*' are derived by scaling a global range of establishment 
*' `i39_establish_gdp` and clearing `i39_landclear_gdp` costs with regional GDP per capita `im_gdp_pc_mer`. 
*'
*' Determine global minimum and maximum GDP per capita in 1995:
s39_min_gdp = smin(i,im_gdp_pc_mer("y1995",i));
s39_max_gdp = smax(i,im_gdp_pc_mer("y1995",i));
*'
*' The region with the lowest (highest) GDP per capita in 1995 is assigned the lowest (highest) establishment cost per hectare.
*' The establishment cost per hectare of all other regions are distributed within the range of 
*' `i39_establish_gdp` according to the regional GDP per capita in 1995. 
*' `p39_establish_a` is the slope and `p39_establish_b` is the intercept of the function used below to calculate `p39_establish_costs`.
*' For future time steps, establishment cost scaled with the GDP per capita trajectory.
p39_establish_a(land) = (i39_establish_gdp(land,"high_gdp")
						- i39_establish_gdp(land,"low_gdp")) / (s39_max_gdp-s39_min_gdp);
p39_establish_b(land) = i39_establish_gdp(land,"low_gdp")
					    - p39_establish_a(land) * s39_min_gdp;
p39_establish_costs_reg(t,i,land) = p39_establish_a(land) * im_gdp_pc_mer(t,i)
									+ p39_establish_b(land);
*' Assume identical land establishment costs in all cells belonging to a region. 
p39_establish_costs(t,j,land) = sum(cell(i,j), p39_establish_costs_reg(t,i,land));
*' @stop

*' @code
*' The calculation of regional land clearing costs follows the same rules as described for establishment costs above.
p39_landclear_a =  (i39_landclear_gdp("high_gdp")
				   - i39_landclear_gdp("low_gdp"))/(s39_max_gdp-s39_min_gdp);
p39_landclear_b = i39_landclear_gdp("low_gdp")-p39_landclear_a*s39_min_gdp;
p39_landclear_costs_reg(t,i,land) = 0;
p39_landclear_costs_reg(t,i,land_natveg) = p39_landclear_a*im_gdp_pc_mer(t,i)
										   + p39_landclear_b;
*' Assume identical land clearing costs in all cells belonging to a region. 
p39_landclear_costs(t,j,land) = sum(cell(i,j), p39_landclear_costs_reg(t,i,land));

*' Land clearing costs are additionally scaled with spatially explicit vegetation carbon density.

*' Determine maximum vegetation carbon density in each region.
p39_max_vegc_reg(i) = smax(cell(i,j), fm_carbon_density("y1995",j,"primforest","vegc"));
*'
*' Calculate reduction factor for land clearing costs. The cell with the highest 
*' vegetation carbon density in a region has the highest clearing costs in this regions.
*' The clearing costs in all other cells of this region will be reduced based on the ratio
*' of spatially explicit vegetation carbon density `fm_carbon_density` and maximum regional 
*' vegetation carbon density `p39_max_vegc_reg`.
pc39_vegc_fact(j) = 1;
pc39_vegc_fact(j) = sum(cell(i,j),(fm_carbon_density("y1995",j,"primforest","vegc")
						/ p39_max_vegc_reg(i)$(p39_max_vegc_reg(i)>0)));
*'
*' Apply the scaling factor `pc39_vegc_fact`.
p39_landclear_costs(t,j,land_natveg) = p39_landclear_costs(t,j,land_natveg) 
									   * pc39_vegc_fact(j);
*' @stop

**



