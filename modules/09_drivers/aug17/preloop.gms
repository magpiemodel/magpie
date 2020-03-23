*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* get the scenario GDP & Populaiton data for iso countries

im_physical_inactivity(t,iso,sex,age) = f09_physical_inactivity(t,iso,"%c09_gdp_scenario%",sex,age);
im_demography(t,iso,sex,age) = f09_demography(t,iso,"%c09_gdp_scenario%",sex,age)+0.000001;

i09_gdp_ppp_iso(t,iso) = f09_gdp_ppp_iso(t,iso,"%c09_gdp_scenario%");
i09_gdp_mer_iso(t,iso) = f09_gdp_mer_iso(t,iso,"%c09_gdp_scenario%");
im_pop_iso(t_all,iso) = f09_pop_iso(t_all,iso,"%c09_pop_scenario%");
* get the scenario GDP & Populaiton data for MAgPIE regions
i09_gdp_mer(t,i) = sum(i_to_iso(i,iso),i09_gdp_mer_iso(t,iso));
i09_gdp_ppp(t,i) = sum(i_to_iso(i,iso),i09_gdp_ppp_iso(t,iso));
im_pop(t,i) = sum(i_to_iso(i,iso),im_pop_iso(t,iso));

* Status of countries' development
im_development_state(t_all,i) = f09_development_state(t_all,i,"%c09_gdp_scenario%");

* GPD per capita for MAgPIE regions
 im_gdp_pc_mer(t,i)$(
     sum(i_to_iso(i,iso),
       im_pop_iso(t,iso)
     ) >0 ) =
                             sum(i_to_iso(i,iso),
                               i09_gdp_mer_iso(t,iso)
                             ) / sum(i_to_iso(i,iso),
                                 im_pop_iso(t,iso)
                             );

 im_gdp_pc_ppp(t,i)$(
     sum(i_to_iso(i,iso),
       im_pop_iso(t,iso)
     ) >0 ) =
                             sum(i_to_iso(i,iso),
                                i09_gdp_ppp_iso(t,iso)
                             ) / sum(i_to_iso(i,iso),
                                 im_pop_iso(t,iso)
                             );

* GDP per capita for ISO countries
im_gdp_pc_ppp_iso(t,iso)=0;
im_gdp_pc_ppp_iso(t,iso)$(i09_gdp_ppp_iso(t,iso)*im_pop_iso(t,iso)>0)  = i09_gdp_ppp_iso(t,iso)/im_pop_iso(t,iso);
im_gdp_pc_ppp_iso(t,iso)$(im_gdp_pc_ppp_iso(t,iso)=0) = sum(i_to_iso(i,iso), im_gdp_pc_ppp(t,i));
