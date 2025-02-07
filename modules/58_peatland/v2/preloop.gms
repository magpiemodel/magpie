*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* linear fader for exogenous peatland rewetting
m_linear_time_interpol(i58_peatland_rewetting_fader,s58_rewet_exo_start_year,s58_rewet_exo_target_year,s58_rewet_exo_start_value,s58_rewet_exo_target_value);

* Country switch to determine countries for which certain policies shall be applied.
* In the default case, the policy affects all countries when activated.
p58_country_switch(iso) = 0;
p58_country_switch(policy_countries58) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by total peatland area.
p58_country_weight(i) = sum(i_to_iso(i,iso), p58_country_switch(iso) * sum(land58, f58_peatland_area_iso(iso,land58))) 
  / sum(i_to_iso(i,iso), sum(land58, f58_peatland_area_iso(iso,land58)));

* construct exogenous peatland rewetting scenario
i58_rewetting_exo(t,j) = i58_peatland_rewetting_fader(t) *
  (s58_rewetting_exo * sum(cell(i,j), p58_country_weight(i))
  + s58_rewetting_exo_noselect * sum(cell(i,j), 1-p58_country_weight(i)));

i58_intact_protection_exo(j) = s58_intact_prot_exo * sum(cell(i,j), p58_country_weight(i))
                      + s58_intact_prot_exo_noselect * sum(cell(i,j), 1-p58_country_weight(i));

* fix uncontrolled pollutants to zero
vm_emissions_reg.fx(i,"peatland",pollutants) = 0;
vm_emissions_reg.lo(i,"peatland",poll58) = -Inf;
vm_emissions_reg.up(i,"peatland",poll58) = Inf;

* Mapping between detailed and simple climate classes
p58_mapping_cell_climate(j,clcl58) = sum(clcl_mapping(clcl,clcl58),pm_climate_class(j,clcl));

* Initialization of peatland area
pc58_peatland(j,land58) = 0;

* For the internal GHG emission pricing it is assumed that intact peatlands have the same GHG emission factors as rewetted peatlands.
* Without this assumption, GHG emissions of intact peatlands would be zero (no data available). This can lead to cases where intact peatland is converted to rewetted peatland.
f58_ipcc_wetland_ef(clcl58,"intact",emis58) = f58_ipcc_wetland_ef(clcl58,"rewetted",emis58);
