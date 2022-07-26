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

# calculate bioplastic demand according to logistic curve for future years
if (m_year(t)>2020,
 p62_bioplastic_demand(t) = s62_max_demand_bioplastics / (1 + exp(-s62_growth_rate_bioplastic*(m_year(t)-2050)))
);

* subtract bioplastic demand in 2010 from all years, as this is already included in biomass demand
if (m_year(t)>=2010,
 p62_bioplastic_demand(t) = p62_bioplastic_demand(t) - p62_bioplastic_demand("y2010")
);

* if max. bioplastic demand is set to zero, overwrite calculations with zero
if (s62_max_demand_bioplastics == 0,
 p62_bioplastic_demand(t) = 0
);

* translate bioplastic demand to biomass demand using conversion factors between bioplastic and the different biomass sources
* and population for spatial disaggregation
p62_biomass4bioplastic(t, i, kall) = p62_bioplastic_demand(t) * f62_bioplastic2biomass(kall) * (im_pop(t, i) / sum(i2, im_pop(t, i2)));