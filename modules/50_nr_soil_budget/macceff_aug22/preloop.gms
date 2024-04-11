*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



* Country switches to determine countries for which chosen Neff scenario
* shall be applied.
* In the default case, the scenarios affects all countries when activated.
p50_country_dummy_cropneff(iso) = 0;
p50_country_dummy_cropneff(cropneff_countries) = 1;
p50_country_dummy_pastneff(iso) = 0;
p50_country_dummy_pastneff(pastneff_countries) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p50_cropneff_region_shr(t,i) = sum(i_to_iso(i,iso), p50_country_dummy_cropneff(iso) * im_pop_iso(t,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t,iso));
p50_pastneff_region_shr(t,i) = sum(i_to_iso(i,iso), p50_country_dummy_pastneff(iso) * im_pop_iso(t,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t,iso));

* Nitrogen use efficiency
loop(t,

  if(m_year(t) <= sm_fix_SSP2,

     i50_nr_eff_bau(t,i) = f50_snupe_base(t,i,"baseeff_add3_add5_add10_max65") * p50_cropneff_region_shr(t,i)
                      + f50_snupe_base(t,i,"baseeff_add3_add5_add10_max65") * (1-p50_cropneff_region_shr(t,i));
     i50_nr_eff_pasture_bau(t,i) = f50_nue_base_pasture(t,i,"constant_min55_min60_min65") * p50_pastneff_region_shr(t,i)
                              + f50_nue_base_pasture(t,i,"constant_min55_min60_min65") * (1-p50_pastneff_region_shr(t,i));

  else

     i50_nr_eff_bau(t,i) = f50_snupe_base(t,i,"%c50_scen_neff%") * p50_cropneff_region_shr(t,i)
                      + f50_snupe_base(t,i,"%c50_scen_neff_noselect%") * (1-p50_cropneff_region_shr(t,i));
     i50_nr_eff_pasture_bau(t,i) = f50_nue_base_pasture(t,i,"%c50_scen_neff_pasture%") * p50_pastneff_region_shr(t,i)
                              + f50_nue_base_pasture(t,i,"%c50_scen_neff_pasture_noselect%") * (1-p50_pastneff_region_shr(t,i));

  );
);

* selecting the scenario for atmospheric deposition
  i50_atmospheric_deposition_rates(t,j,land)=f50_atmospheric_deposition_rates(t,j,land,"%c50_dep_scen%");
