*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* create crop rotation scenario

i30_rotation_max_shr(t_all,rotamax30)=
  f30_rotation_max_shr(rotamax30,"default") * (1-f30_scenario_fader(t_all,"%c30_rotation_scenario_speed%"))+
  f30_rotation_max_shr(rotamax30,"%c30_rotation_scenario%") * (f30_scenario_fader(t_all,"%c30_rotation_scenario_speed%"));

i30_rotation_min_shr(t_all,rotamin30)=
  f30_rotation_min_shr(rotamin30,"default") * (1-f30_scenario_fader(t_all,"%c30_rotation_scenario_speed%"))+
  f30_rotation_min_shr(rotamin30,"%c30_rotation_scenario%") * (f30_scenario_fader(t_all,"%c30_rotation_scenario_speed%"));


*due to some rounding errors the input data currently may contain in some cases
*very small, negative numbers. These numbers have to be set to 0 as area
*cannot be smaller than 0!
fm_croparea(t_past,j,w,kcr)$(fm_croparea(t_past,j,w,kcr)<0) = 0;

****** Regional share of semi-natural vegetation (SNV) in cropland areas for selective countries:
* Country switch to determine countries for which a SNV policy shall be applied.
* In the default case, the SNV policy affects all countries when activated.
p30_country_dummy(iso) = 0;
p30_country_dummy(policy_countries30) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by available cropland area.
i30_avl_cropland_iso(iso) = f30_avl_cropland_iso(iso,"%c30_marginal_land%");
p30_region_snv_shr(i) = sum(i_to_iso(i,iso), p30_country_dummy(iso) * i30_avl_cropland_iso(iso)) / sum(i_to_iso(i,iso), i30_avl_cropland_iso(iso));
