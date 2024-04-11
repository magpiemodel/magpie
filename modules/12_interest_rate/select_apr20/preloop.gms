*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Country switch to determine countries for which chosen interest rate scenario
* shall be applied.
* In the default case, the interest rate scenario affects all countries when
* activated.
p12_country_dummy(iso) = 0;
p12_country_dummy(select_countries12) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p12_reg_shr(t_all,i) = sum(i_to_iso(i,iso), p12_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));

* Interest rate in countries selected in select_countries12
$ifthen "%c12_interest_rate%" == "coupling"
  p12_interest_select(t_all,i) = f12_interest_coupling(t_all);
$elseif "%c12_interest_rate%" == "gdp_dependent"
  pm_interest(t_all,i) =  ( (s12_interest_lic - (s12_interest_lic-s12_interest_hic) * im_development_state(t_all,i)) * f12_interest_fader(t_all)
                         +   (s12_hist_interest_lic - (s12_hist_interest_lic-s12_hist_interest_hic) * im_development_state(t_all,i)) * (1-f12_interest_fader(t_all)) ) * p12_reg_shr(t_all,i)
                         + ( (s12_interest_lic_noselect - (s12_interest_lic_noselect-s12_interest_hic_noselect) * im_development_state(t_all,i)) * f12_interest_fader(t_all)
                         +   (s12_hist_interest_lic_noselect - (s12_hist_interest_lic_noselect-s12_hist_interest_hic_noselect) * im_development_state(t_all,i) ) * (1-f12_interest_fader(t_all)) ) * (1-p12_reg_shr(t_all,i));
$endif
