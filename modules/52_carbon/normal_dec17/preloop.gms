*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


* starting value of carbon stocks 1995 is only an estimate.
* ATTENTION: emissions in 1995 are not meaningful
vm_carbon_stock.l(j,land,c_pools) = fm_carbon_density("y1995",j,land,c_pools)*pcm_land(j,land);
pc52_carbon_stock(j,land,c_pools) = vm_carbon_stock.l(j,land,c_pools);

*age-class carbon density start values
pc52_carbon_density_start(t,j,"vegc") = 0;
pc52_carbon_density_start(t,j,"litc") = fm_carbon_density(t,j,"past","litc");
pc52_carbon_density_start(t,j,"soilc") = fm_carbon_density(t,j,"past","soilc");

*calculate vegetation age-class carbon density in current time step with chapman richards equation
pm_carbon_density_ac(t,j,ac,"vegc") = m_growth_vegc(pc52_carbon_density_start(t,j,"vegc"),fm_carbon_density(t,j,"other","vegc"),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"k")),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"m")),(ord(ac)-1));

*calculate litter and soil carbon density based on linear growth funktion: carbon_density(ac) = intercept + slope*ac (20 year time horizon taken from IPCC)
pm_carbon_density_ac(t,j,ac,"litc") = m_growth_litc_soilc(pc52_carbon_density_start(t,j,"litc"),fm_carbon_density(t,j,"other","litc"),(ord(ac)-1));
pm_carbon_density_ac(t,j,ac,"soilc") = m_growth_litc_soilc(pc52_carbon_density_start(t,j,"soilc"),fm_carbon_density(t,j,"other","soilc"),(ord(ac)-1));


*** EOF pre.gms ***
