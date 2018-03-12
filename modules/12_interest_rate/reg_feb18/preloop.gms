*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*******Income Country Grouping based on World Bank definitions
s12_min_dev = smin(i,f09_development_state("y1995",i,gdp_scen09));
s12_max_dev = smax(i,f09_development_state("y1995",i,gdp_scen09));
s12_slope_a = (f12_interest_bound("high")-f12_interest_rate_bound("low"))/(s12_min_dev-s12_max_dev);
s12_intercept_b = f12_interest_bound("high")-s12_slope_a*s12_min_dev;
p12_interest(t,i) = s12_slope_a *f09_development_state(t,i,gdp_scen09) + s12_intercept_b;

$ifthen "%c12_interest_rate%" == "coupling" p12_interest(t,i) = f12_interest_coupling(t);
$endif

p12_annuity_due(t,i) = m_annuity_due(p12_interest(t,i),sm_invest_horizon);