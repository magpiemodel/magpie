*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

p39_cost_landcon_past(t,j,land) = 0;

** Costs of establishment (determined by GDP)

* set the cost estimate depending on the scenario
$Ifi "%c39_cost_establish%" == "low" i39_cost_establish(land,bound39) = f39_cost_establish(land,"low_estimate",bound39);
$Ifi "%c39_cost_establish%" == "medium" i39_cost_establish(land,bound39) = f39_cost_establish(land,"medium_estimate",bound39);
$Ifi "%c39_cost_establish%" == "high" i39_cost_establish(land,bound39) = f39_cost_establish(land,"high_estimate",bound39);

* minimum and maximum regional GDP values in 1995
s39_min_gdp = smin(i,im_gdp_pc_mer("y1995",i));
s39_max_gdp = smax(i,im_gdp_pc_mer("y1995",i));

* slope of the function
p39_establish_a(land) = (i39_cost_establish(land,"up")-i39_cost_establish(land,"lo"))/(s39_max_gdp-s39_min_gdp);

* intercept of the function
p39_establish_b(land) = i39_cost_establish(land,"lo")-p39_establish_a(land)*s39_min_gdp;

p39_establish_costs(t,i,land) = p39_establish_a(land)*im_gdp_pc_mer(t,i)+p39_establish_b(land);




** Costs for land clearing of natveg (determined by vegetation carbon density)

* set the cost estimate depending on the scenario
$Ifi "%c39_cost_landclear%" == "low" i39_cost_landclear(bound39) = f39_cost_landclear("low_estimate",bound39);
$Ifi "%c39_cost_landclear%" == "medium" i39_cost_landclear(bound39) = f39_cost_landclear("medium_estimate",bound39);
$Ifi "%c39_cost_landclear%" == "high" i39_cost_landclear(bound39) = f39_cost_landclear("high_estimate",bound39);

* minimum and maximum spatially explicit carbon density in 1995
s39_min_carbon = smin(j,fm_carbon_density("y1995",j,"primforest","vegc"));
s39_max_carbon = smax(j,fm_carbon_density("y1995",j,"primforest","vegc"));

* slope of the function
p39_landclear_a$(s39_max_carbon-s39_min_carbon > 0) = (i39_cost_landclear("up")-i39_cost_landclear("lo"))/(s39_max_carbon-s39_min_carbon);

* intercept of the function
p39_landclear_b = i39_cost_landclear("lo")-p39_landclear_a*s39_min_carbon;

* Costs for land clearing
p39_landclear_costs(t,j,land_natveg) = p39_landclear_a*fm_carbon_density(t,j,"primforest","vegc")+p39_landclear_b;
