*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


** set the cost estimate depending on the scenario
$Ifi "%c39_cost_scenario%" == "low" i39_landclear_gdp(bound39) = f39_landclear_gdp("low_estimate",bound39);
$Ifi "%c39_cost_scenario%" == "medium" i39_landclear_gdp(bound39) = f39_landclear_gdp("medium_estimate",bound39);
$Ifi "%c39_cost_scenario%" == "high" i39_landclear_gdp(bound39) = f39_landclear_gdp("high_estimate",bound39);

$Ifi "%c39_cost_scenario%" == "low" i39_establish_gdp(land,bound39) = f39_establish_gdp(land,"low_estimate",bound39);
$Ifi "%c39_cost_scenario%" == "medium" i39_establish_gdp(land,bound39) = f39_establish_gdp(land,"medium_estimate",bound39);
$Ifi "%c39_cost_scenario%" == "high" i39_establish_gdp(land,bound39) = f39_establish_gdp(land,"high_estimate",bound39);


** Minimal and maximal GDP values in 1995
s39_min_gdp = smin(i,im_gdp_pc_mer("y1995",i));
s39_max_gdp = smax(i,im_gdp_pc_mer("y1995",i));

** Costs of establishment (determined by GDP)

* slope of the gdp function
p39_establish_a(land) = (i39_establish_gdp(land,"high_gdp")-i39_establish_gdp(land,"low_gdp"))/(s39_max_gdp-s39_min_gdp);

* intercept of the gdp function
p39_establish_b(land) = i39_establish_gdp(land,"low_gdp")-p39_establish_a(land)*s39_min_gdp;

p39_establish_costs(t,i,land) = p39_establish_a(land)*im_gdp_pc_mer(t,i)+p39_establish_b(land);