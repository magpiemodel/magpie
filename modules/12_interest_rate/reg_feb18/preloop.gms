*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
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
p12_country_dummy(interest_rate_policy_countries) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p12_interestscen_region_shr(t_all,i) = sum(i_to_iso(i,iso), p12_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));



*******Income Country Grouping based on World Bank definitions

*' @code
s12_min_dev = smin(i,im_development_state("y1995",i));
s12_max_dev = smax(i,im_development_state("y1995",i));
s12_slope_a = (f12_interest_bound("y1995","high")-f12_interest_bound("y1995","low"))/(s12_min_dev-s12_max_dev);
s12_intercept_b = f12_interest_bound("y1995","high")-s12_slope_a*s12_min_dev;
p12_interest(t,i) = (s12_slope_a *im_development_state(t,i) + s12_intercept_b) * p12_interestscen_region_shr(t,i)
                    + f12_interest(t,"medium") * (1-p12_interestscen_region_shr(t,i));

*' @stop

$ifthen "%c12_interest_rate%" == "coupling" p12_interest(t,i) = f12_interest_coupling(t);
$endif
