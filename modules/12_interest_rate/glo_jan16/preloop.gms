*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*******Income Country Grouping based on World Bank definitions
t_to_i_to_dev(t_all,i,dev) = no;
t_to_i_to_dev(t_all,i,"lic") = yes$(im_gdp_pc_ppp(t_all,i) <= 1045);
t_to_i_to_dev(t_all,i,"mic") = yes$(im_gdp_pc_ppp(t_all,i) > 1045 AND im_gdp_pc_ppp(t_all,i) < 12746);
t_to_i_to_dev(t_all,i,"hic") = yes$(im_gdp_pc_ppp(t_all,i) >= 12746);

* Country switch to determine countries for which chosen interest rate scenario
* shall be applied.
* In the default case, the interest rate scenario affects all countries when
* activated.
p12_country_dummy(iso) = 0;
p12_country_dummy(gdp_countries12) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p12_reg_shr(t_all,i) = sum(i_to_iso(i,iso), p12_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));


$ifthen "%c12_interest_rate%" == "coupling"
 p12_interest(t_all,i) = f12_interest_coupling(t_all)
 ;
$elseif "%c12_interest_rate%" == "mixed"
 p12_interest(t_all,i) = sum(t_to_i_to_dev("y1995",i,dev), sum(scen12_to_dev(scen12,dev), f12_interest(t_all,scen12))) * p12_reg_shr(t_all,i)
                      + f12_interest(t_all,"medium") * (1-p12_reg_shr(t_all,i))
 ;
$else
 p12_interest(t_all,i) =  f12_interest(t_all,"%c12_interest_rate%") * p12_reg_shr(t_all,i)
                      + f12_interest(t_all,"medium") * (1-p12_reg_shr(t_all,i))
 ;
$endif
