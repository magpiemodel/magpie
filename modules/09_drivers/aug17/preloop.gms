*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* calculate GDP and population data for MAgPIE regions
i09_gdp_mer_raw(t_all,i,pop_gdp_scen09) = sum(i_to_iso(i,iso), f09_gdp_mer_iso(t_all,iso,pop_gdp_scen09));
i09_gdp_ppp_raw(t_all,i,pop_gdp_scen09) = sum(i_to_iso(i,iso), f09_gdp_ppp_iso(t_all,iso,pop_gdp_scen09));
i09_pop_raw(t_all,i,pop_gdp_scen09) = sum(i_to_iso(i,iso), f09_pop_iso(t_all,iso,pop_gdp_scen09));

* GPD per capita for MAgPIE regions
i09_gdp_pc_mer_raw(t_all,i,pop_gdp_scen09)$(i09_pop_raw(t_all,i,pop_gdp_scen09) > 0 ) =
                           i09_gdp_mer_raw(t_all,i,pop_gdp_scen09) / i09_pop_raw(t_all,i,pop_gdp_scen09)
;

i09_gdp_pc_ppp_raw(t_all,i,pop_gdp_scen09)$(i09_pop_raw(t_all,i,pop_gdp_scen09) > 0 ) =
                           i09_gdp_ppp_raw(t_all,i,pop_gdp_scen09) / i09_pop_raw(t_all,i,pop_gdp_scen09)
;

*' GDP per capita for ISO countries
i09_gdp_pc_ppp_iso_raw(t_all,iso,pop_gdp_scen09) = 0;
i09_gdp_pc_ppp_iso_raw(t_all,iso,pop_gdp_scen09)$(f09_gdp_ppp_iso(t_all,iso,pop_gdp_scen09) * f09_pop_iso(t_all,iso,pop_gdp_scen09) > 0) = f09_gdp_ppp_iso(t_all,iso,pop_gdp_scen09) / f09_pop_iso(t_all,iso,pop_gdp_scen09);
* Countries with no p.c. GDP information receive SSP2 average p.c. GDP
* SSP2 GDP was selected because diverging GDP and population information leads to diverging regional values
i09_gdp_pc_ppp_iso_raw(t_all,iso,pop_gdp_scen09)$(i09_gdp_pc_ppp_iso_raw(t_all,iso,pop_gdp_scen09) = 0) = sum(i_to_iso(i,iso), i09_gdp_pc_ppp_raw(t_all,i,"SSP2"));

i09_gdp_pc_mer_iso_raw(t_all,iso,pop_gdp_scen09) = 0;
i09_gdp_pc_mer_iso_raw(t_all,iso,pop_gdp_scen09)$(f09_gdp_mer_iso(t_all,iso,pop_gdp_scen09) * f09_pop_iso(t_all,iso,pop_gdp_scen09) > 0) = f09_gdp_mer_iso(t_all,iso,pop_gdp_scen09) / f09_pop_iso(t_all,iso,pop_gdp_scen09);
* Countries with no p.c. GDP information receive SSP2 average p.c. GDP
* SSP2 GDP was selected because diverging GDP and population information leads to diverging regional values
i09_gdp_pc_mer_iso_raw(t_all,iso,pop_gdp_scen09)$(i09_gdp_pc_mer_iso_raw(t_all,iso,pop_gdp_scen09) = 0) = sum(i_to_iso(i,iso), i09_gdp_pc_mer_raw(t_all,i,"SSP2"));

* select scenario for GDP, population, demography and physical inactivity
loop(t_all,
 if(m_year(t_all) <= sm_fix_SSP2,
  im_physical_inactivity(t_all,iso,sex,age) = f09_physical_inactivity(t_all,iso,"SSP2",sex,age);
  im_demography(t_all,iso,sex,age) = f09_demography(t_all,iso,"SSP2",sex,age) + 0.000001;
  im_pop_iso(t_all,iso) = f09_pop_iso(t_all,iso,"SSP2");
  im_pop(t_all,i) = i09_pop_raw(t_all,i,"SSP2");
  im_gdp_pc_mer(t_all,i) = i09_gdp_pc_mer_raw(t_all,i,"SSP2");
  im_gdp_pc_mer_iso(t_all,iso) = i09_gdp_pc_mer_iso_raw(t_all,iso,"SSP2");
  im_gdp_pc_ppp_iso(t_all,iso) = i09_gdp_pc_ppp_iso_raw(t_all,iso,"SSP2");
  im_development_state(t_all,i) = f09_development_state(t_all,i,"SSP2");
else
  im_physical_inactivity(t_all,iso,sex,age) = f09_physical_inactivity(t_all,iso,"%c09_pal_scenario%",sex,age);
  im_demography(t_all,iso,sex,age) = f09_demography(t_all,iso,"%c09_pop_scenario%",sex,age) + 0.000001;
  im_pop_iso(t_all,iso) = f09_pop_iso(t_all,iso,"%c09_pop_scenario%");
  im_pop(t_all,i) = i09_pop_raw(t_all,i,"%c09_pop_scenario%");
  im_gdp_pc_mer(t_all,i) = i09_gdp_pc_mer_raw(t_all,i,"%c09_gdp_scenario%");
  im_gdp_pc_mer_iso(t_all,iso) = i09_gdp_pc_mer_iso_raw(t_all,iso,"%c09_gdp_scenario%");
  im_gdp_pc_ppp_iso(t_all,iso) = i09_gdp_pc_ppp_iso_raw(t_all,iso,"%c09_gdp_scenario%");
  im_development_state(t_all,i) = f09_development_state(t_all,i,"%c09_gdp_scenario%");
 );
);

* Calculate GDP from p.c. GDP and population of previously selected scenarios
i09_gdp_mer_iso(t_all,iso) = im_gdp_pc_mer_iso(t_all,iso) * im_pop_iso(t_all,iso);
i09_gdp_ppp_iso(t_all,iso) = im_gdp_pc_ppp_iso(t_all,iso) * im_pop_iso(t_all,iso);
