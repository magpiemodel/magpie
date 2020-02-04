*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


* starting value of above ground carbon stocks 1995 is only an estimate.
* ATTENTION: emissions in 1995 are not meaningful
vm_carbon_stock.l(j,land,ag_pools) = fm_carbon_density("y1995",j,land,ag_pools)*pcm_land(j,land);
pcm_carbon_stock(j,land,ag_pools) = vm_carbon_stock.l(j,land,ag_pools);

*age-class carbon density start values
pc52_carbon_density_start(t,j,"vegc") = 0;
pc52_carbon_density_start(t,j,"litc") = fm_carbon_density(t,j,"past","litc");

*calculate vegetation age-class carbon density in current time step with chapman richards equation
pm_carbon_density_ac(t,j,ac,"vegc") = m_growth_vegc(pc52_carbon_density_start(t,j,"vegc"),fm_carbon_density(t,j,"other","vegc"),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par_image_lpjml(clcl,"k","%c52_growth_par%")),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par_image_lpjml(clcl,"m","%c52_growth_par%")),(ord(ac)-1));

*calculate litter and soil carbon density based on linear growth funktion: carbon_density(ac) = intercept + slope*ac (20 year time horizon taken from IPCC)
pm_carbon_density_ac(t,j,ac,"litc") = m_growth_litc_soilc(pc52_carbon_density_start(t,j,"litc"),fm_carbon_density(t,j,"other","litc"),(ord(ac)-1));

*** EOF pre.gms ***
