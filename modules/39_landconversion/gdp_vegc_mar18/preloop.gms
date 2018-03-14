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


** figure out which region has the highest and smalles gdp. Correct the costs likewise

reg_min_gdp(i) = im_gdp_pc_mer("y1995",i) = s39_min_gdp;
reg_max_gdp(i) = im_gdp_pc_mer("y1995",i) = s39_max_gdp;

display s39_min_gdp, reg_min_gdp, reg_max_gdp;
**


** Costs for land clearing (determined by GDP, and reduced by relation of carbon density per cell in relation to maximal carbon density per region)

* the maximum carbon density per region in 1995
p39_max_carbon_reg(i) = smax(cell(i,j), fm_carbon_density("y1995",j,"primforest","vegc"));

* absolute maximum carbon density
p39_max_carbon_glo = smax(j,fm_carbon_density("y1995",j,"primforest","vegc"));


* costs are corrected in a way that the costs in cell with the highest forest carbin density in the region with the highest gdp later on gets the high_gdp value, even though costs are related to global maximum carbon density

* there is only one element in reg_max_gdp. Taking the sum is only to avoid "Uncontrolled set entered as constant" error
i39_landclear_gdp("high_gdp") = sum(reg_max_gdp, (i39_landclear_gdp("high_gdp") * p39_max_carbon_glo / p39_max_carbon_reg(reg_max_gdp)));
i39_landclear_gdp("low_gdp") = sum(reg_min_gdp, (i39_landclear_gdp("low_gdp") * p39_max_carbon_glo / p39_max_carbon_reg(reg_min_gdp)));

display i39_landclear_gdp;

** NEW: costs are corrected so that region with the
* slope of the gdp function
p39_landclear_a =  (i39_landclear_gdp("high_gdp")-i39_landclear_gdp("low_gdp"))/(s39_max_gdp-s39_min_gdp);

* intercept of the gdp function
p39_landclear_b = i39_landclear_gdp("low_gdp")-p39_landclear_a*s39_min_gdp;


**** old
* slope of the gdp function
*p39_landclear_a =  (i39_landclear_gdp("high_gdp")-i39_landclear_gdp("low_gdp"))/(s39_max_gdp-s39_min_gdp);

* intercept of the gdp function
*p39_landclear_b = i39_landclear_gdp("low_gdp")-p39_landclear_a*s39_min_gdp;




** Costs of establishment (determined by GDP)

* slope of the gdp function
p39_establish_a(land) = (i39_establish_gdp(land,"high_gdp")-i39_establish_gdp(land,"low_gdp"))/(s39_max_gdp-s39_min_gdp);

* intercept of the gdp function
p39_establish_b(land) = i39_establish_gdp(land,"low_gdp")-p39_establish_a(land)*s39_min_gdp;

p39_establish_costs(t,i,land) = (p39_establish_a(land)*im_gdp_pc_mer(t,i)+p39_establish_b(land));