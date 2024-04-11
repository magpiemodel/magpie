*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

 p62_dem_material_lastcalibyear(i,kall) = 0;
 p62_dem_food_lastcalibyear(i) = 1;
 p62_dem_bioplastic(t,i) = 0;

* Bioplastic demand is based on historic values up to 2020, and either kept constant for
* future years, or following a logistic function with given midpoint and maximum if a 
* bioplastic production target is exogenously set. 
* Global bioplastic demand is distributed to regions proportional to population due to lack of better data.

p62_dem_bioplastic(t,i) = f62_hist_dem_bioplastic(t) * (im_pop(t,i) / sum(i2, im_pop(t,i2)));
p62_dem_bioplastic(t,i)$(m_year(t)>2020) = f62_hist_dem_bioplastic("y2020") * (im_pop("y2020",i) / sum(i2, im_pop("y2020",i2)));

if (s62_max_dem_bioplastic <> 0,
  s62_growth_rate_bioplastic = log((s62_max_dem_bioplastic/f62_hist_dem_bioplastic("y2020")) - 1)/(s62_midpoint_dem_bioplastic-2020);
  p62_dem_bioplastic(t,i)$(m_year(t)>2020) = s62_max_dem_bioplastic / (1 + exp(-s62_growth_rate_bioplastic*(m_year(t)-s62_midpoint_dem_bioplastic))) * (im_pop(t,i) / sum(i2, im_pop(t,i2)));
);

* translate bioplastic demand to biomass demand using conversion factors between bioplastic and the different biomass sources
p62_bioplastic_substrate(t,i,kall) = p62_dem_bioplastic(t,i) * f62_biomass2bioplastic_conversion_ratio(kall);
