*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
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
p50_cropneff_region_shr(t_all,i) = sum(i_to_iso(i,iso), p50_country_dummy_cropneff(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));
p50_pastneff_region_shr(t_all,i) = sum(i_to_iso(i,iso), p50_country_dummy_pastneff(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));

* Nitrogen use efficiency
v50_nr_eff.fx(i) = f50_snupe(t,i,"%c50_scen_neff%") * p50_cropneff_region_shr(t,i)
                    + f50_snupe(t,i,"neff60_60_starty2010") * (1-p50_cropneff_region_shr(t,i));
v50_nr_eff_pasture.fx(i) = f50_nue_pasture(t,i,"%c50_scen_neff_pasture%") * p50_pastneff_region_shr(t,i)
                            + f50_nue_pasture(t,i,"constant") * (1-p50_pastneff_region_shr(t,i));
i50_atmospheric_deposition_rates(t,j,land)=f50_atmospheric_deposition_rates(t,j,land,"%c50_dep_scen%");
