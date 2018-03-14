*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


* shifted to preloop again
*p39_max_carbon(i,foland) = smax(cell(i,j), pcm_vegc_carbon_density(j,foland));

* factor that lowers the costs depending on the carbon density of the vegetation in relation to the maximum carbon density in the region
*pc39_vegc_fact(j,foland) = sum(cell(i,j),(pcm_vegc_carbon_density(j,foland)/p39_max_carbon(i,foland)$(p39_max_carbon(i,foland)>0)));

pc39_carbon_density(j,land,c_pools)$(vm_land.l(j,land) > 0) = vm_carbon_stock.l(j,land,c_pools)/vm_land.l(j,land);

** NEW: now with global smax
pc39_vegc_fact(j,land_natveg) = pc39_carbon_density(j,land_natveg,"vegc")/p39_max_carbon_glo$(p39_max_carbon_glo>0);




* Costs for land clearing.
pc39_landclear_costs(j,land) = sum(cell(i,j),(p39_landclear_a*im_gdp_pc_mer(t,i)+p39_landclear_b))*pc39_vegc_fact(j,land);

* just to see what is happening
p39_landclear_costs(t,j,land) = pc39_landclear_costs(j,land);


pc39_establish_costs(i,land) = p39_establish_costs(t,i,land);

p39_cost_landcon_past(t,j,land)$(ord(t) = 1) = 0;
pc39_cost_landcon_past(j,land) = p39_cost_landcon_past(t,j,land);