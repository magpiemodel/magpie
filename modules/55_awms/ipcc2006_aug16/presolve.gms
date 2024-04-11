*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

****** Region price share for awm scenario of selective countries:
* Country switch to determine countries for which awm scenario shall be applied.
* In the default case, the awm scenario affects all countries when activated.
p55_country_dummy(iso) = 0;
p55_country_dummy(scen_countries55) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p55_region_shr(t_all,i) = sum(i_to_iso(i,iso), p55_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));


if(m_year(t) <= sm_fix_SSP2,
 ic55_awms_shr(i,kli,awms_conf) = f55_awms_shr(t,i,"ssp2",kli,awms_conf);
 ic55_manure_fuel_shr(i,kli)=f55_manure_fuel_shr(t,i,kli,"SSP2");
else
 ic55_awms_shr(i,kli,awms_conf) = f55_awms_shr(t,i,"%c55_scen_conf%",kli,awms_conf) * p55_region_shr(t,i)
                                + f55_awms_shr(t,i,"%c55_scen_conf_noselect%",kli,awms_conf) * (1-p55_region_shr(t,i));
 ic55_manure_fuel_shr(i,kli)=f55_manure_fuel_shr(t,i,kli,"%c09_gdp_scenario%");
);
