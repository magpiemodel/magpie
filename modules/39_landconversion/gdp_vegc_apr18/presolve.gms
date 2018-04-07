*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


** Costs for land clearing for natveg (determined by average regional carbon density)
pc39_carbon_density(j,land_natveg)$(vm_land.l(j,land_natveg) > 0) = vm_carbon_stock.l(j,land_natveg,"vegc")/vm_land.l(j,land_natveg);

** Minimal and maximal average carbon density across regions
*s39_min_carbon = smin(j,fm_carbon_density(t,j,"primforest","vegc"));
*s39_max_carbon = smax(j,fm_carbon_density(t,j,"primforest","vegc"));
s39_min_carbon = smin((j,land_natveg),pc39_carbon_density(j,land_natveg));
s39_max_carbon = smax((j,land_natveg),pc39_carbon_density(j,land_natveg));

* slope of the function
p39_landclear_a$(s39_max_carbon-s39_min_carbon > 0) = (i39_landclear_gdp("high_gdp")-i39_landclear_gdp("low_gdp"))/(s39_max_carbon-s39_min_carbon);

* intercept of the function
p39_landclear_b = i39_landclear_gdp("low_gdp")-p39_landclear_a*s39_min_carbon;

* Costs for land clearing
pc39_landclear_costs(j,land_natveg) = p39_landclear_a*pc39_carbon_density(j,land_natveg)+p39_landclear_b;

* just to see what is happening
p39_landclear_costs(t,j,land) = pc39_landclear_costs(j,land);

pc39_establish_costs(i,land) = p39_establish_costs(t,i,land);

p39_cost_landcon_past(t,j,land)$(ord(t) = 1) = 0;
pc39_cost_landcon_past(j,land) = p39_cost_landcon_past(t,j,land);

display s39_min_carbon;
display s39_max_carbon;
display pc39_landclear_costs;
display pc39_establish_costs;

