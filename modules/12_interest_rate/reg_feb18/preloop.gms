*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
