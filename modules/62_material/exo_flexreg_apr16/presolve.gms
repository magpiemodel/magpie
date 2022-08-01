*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' For the time period beloning to the historical time period (y1965 to y2010
*' in this version of the model), the scalar `s62_historical` is set to 1 and
*' for the non-historical time periods, `s62_historical` is set to 0.
*' How this switch affects the material demand calculations is explained in the
*' equation(s) accompanying this module.

if (sum(sameas(t_past,t),1) = 1,
  s62_historical=1;
else
 s62_historical=0;
);

p62_scaling_factor(i) = 1;
p62_scaling_factor(i)$(p62_dem_food_lh(i) > 0) = sum(kfo, vm_dem_food.l(i,kfo)) / p62_dem_food_lh(i);

*' @stop

* In t_past, biomass demand for bioplastic is already included in the general material demand, which is 
* scaled for future years. Therefore we set bioplastic demand for t_past to zero, and subtract scaled 
* bioplastic demand from the last year of t_past from all future bioplastic demand
if (sum(sameas(t_past,t),1) = 1,
  p62_dem_bioplastic_lh(i) = p62_dem_bioplastic(t,i);
  p62_dem_bioplastic(t,i) = 0;
else
  p62_dem_bioplastic(t,i) = p62_dem_bioplastic(t,i) - p62_dem_bioplastic_lh(i) * p62_scaling_factor(i);
);

* if max. bioplastic demand is set to zero, overwrite calculations with zero
if (s62_max_dem_bioplastic = 0,
 p62_dem_bioplastic(t,i) = 0
);

* translate bioplastic demand to biomass demand using conversion factors between bioplastic and the different biomass sources
p62_biomass4bioplastic(t,i,kall) = p62_dem_bioplastic(t,i) * f62_bioplastic2biomass(kall);