*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*******Income Country Grouping based on World Bank definitions

*' @code
s12_min_dev = smin(i,im_development_state("y1995",i));
s12_max_dev = smax(i,im_development_state("y1995",i));
s12_slope_a = (f12_interest_bound("y1995","high")-f12_interest_bound("y1995","low"))/(s12_min_dev-s12_max_dev);
s12_intercept_b = f12_interest_bound("y1995","high")-s12_slope_a*s12_min_dev;
p12_interest(t,i) = s12_slope_a *im_development_state(t,i) + s12_intercept_b;
*' @stop

$ifthen "%c12_interest_rate%" == "coupling" p12_interest(t,i) = f12_interest_coupling(t);
$endif
