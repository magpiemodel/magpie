*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Interest rate regional policy fader:
p12_interest_reg_policy(t_all)$(m_year(t_all)<2025)=0;
p12_interest_reg_policy("y2025")=0.1;
p12_interest_reg_policy("y2030")=0.2;
p12_interest_reg_policy("y2035")=0.4;
p12_interest_reg_policy("y2040")=0.6;
p12_interest_reg_policy("y2045")=0.8;
p12_interest_reg_policy(t_all)$(m_year(t_all)>=2050)=1;

* Country dummy to determine countries for which gdp-dependent interest rate
* is applied.
p12_country_dummy(iso) = 0;
p12_country_dummy(gdp_countries12) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p12_reg_shr(t_all,i) = sum(i_to_iso(i,iso), p12_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));


*******Income Country Grouping based on World Bank definitions

*' @code
s12_min_dev = smin(i,im_development_state("y1995",i));
s12_max_dev = smax(i,im_development_state("y1995",i));
s12_slope_a = (f12_interest_bound("y1995","high")-f12_interest_bound("y1995","low"))/(s12_min_dev-s12_max_dev);
s12_intercept_b = f12_interest_bound("y1995","high")-s12_slope_a*s12_min_dev;

*' @stop

$ifthen "%c12_interest_rate%" == "coupling"
 p12_interest(t,i) = f12_interest_coupling(t);
$else
* For the countries selected in gdp_countries12 the interest rate is dependent on
* their development state. (By default, all iso countries are selected.)
* For all other countries the scalar s12_interest_noselect applies.
 p12_interest(t,i) = (s12_slope_a * im_development_state(t,i) + s12_intercept_b) * p12_reg_shr(t,i)
                    + s12_interest_noselect * p12_interest_reg_policy(t) * (1-p12_reg_shr(t,i));
$endif
