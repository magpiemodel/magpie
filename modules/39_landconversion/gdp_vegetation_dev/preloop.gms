*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

** set the cost estimate depending on the scenario
$Ifi "%c39_cost_scenario%" == "low" i39_landclear_gdp(bound39) = f39_landclear_gdp("low_estimate",bound39);
$Ifi "%c39_cost_scenario%" == "medium" i39_landclear_gdp(bound39) = f39_landclear_gdp("medium_estimate",bound39);
$Ifi "%c39_cost_scenario%" == "high" i39_landclear_gdp(bound39) = f39_landclear_gdp("high_estimate",bound39);

$Ifi "%c39_cost_scenario%" == "low" i39_establish_gdp(land,bound39) = f39_establish_gdp(land,"low_estimate",bound39);
$Ifi "%c39_cost_scenario%" == "medium" i39_establish_gdp(land,bound39) = f39_establish_gdp(land,"medium_estimate",bound39);
$Ifi "%c39_cost_scenario%" == "high" i39_establish_gdp(land,bound39) = f39_establish_gdp(land,"high_estimate",bound39);


** Minimal and maximal GDP values in 1995
s39_min_gdp = smin(i,im_gdp_pc("y1995",i));
s39_max_gdp = smax(i,im_gdp_pc("y1995",i));


** Costs for land clearing (determined by GDP, and reduced by relation of carbon density per cell in relation to maximal carbon density per region)

* slope of the gdp function
p39_landclear_a =  (i39_landclear_gdp("high_gdp")-i39_landclear_gdp("low_gdp"))/(s39_max_gdp-s39_min_gdp);

* intercept of the gdp function
p39_landclear_b = i39_landclear_gdp("low_gdp")-p39_landclear_a*s39_min_gdp;


p39_max_carbon(i,land) = smax(cell(i,j), fm_carbon_density("y1995",j,land,"vegc"));
p39_max_carbon(i,"urban") = 1;

* factor that lowers the costs depending on the carbon density of the vegetation in relation to the maximum carbon density in the region
p39_vegc_fact(t,j,land) = sum(cell(i,j),(fm_carbon_density(t,j,land,"vegc")/p39_max_carbon(i,land)$(p39_max_carbon(i,land)>0)));
p39_vegc_fact(t,j,"urban") = 0;

* Costs for land clearing.
p39_landclear_costs(t,j,land) = sum(cell(i,j),(p39_landclear_a*im_gdp_pc(t,i)+p39_landclear_b))*p39_vegc_fact(t,j,land);
p39_landclear_costs(t,j,"crop") = 0;
p39_landclear_costs(t,j,"past") = 0;


** Costs of establishment (determined by GDP)

* slope of the gdp function
p39_establish_a(land) = (i39_establish_gdp(land,"high_gdp")-i39_establish_gdp(land,"low_gdp"))/(s39_max_gdp-s39_min_gdp);

* intercept of the gdp function
p39_establish_b(land) = i39_establish_gdp(land,"low_gdp")-p39_establish_a(land)*s39_min_gdp;

p39_establish_costs(t,i,land) = (p39_establish_a(land)*im_gdp_pc(t,i)+p39_establish_b(land));
