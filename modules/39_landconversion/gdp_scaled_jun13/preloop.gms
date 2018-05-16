*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

s39_min_gdp = smin(i,im_gdp_pc_mer("y1995",i));
s39_max_gdp = smax(i,im_gdp_pc_mer("y1995",i));
p39_par_a(land) = (f39_lndc_bound(land,"low")-f39_lndc_bound(land,"high"))/(s39_min_gdp-s39_max_gdp);
p39_par_b(land) = f39_lndc_bound(land,"low")-p39_par_a(land)*s39_min_gdp;
p39_lndcon_costs(t,i,land) = (p39_par_a(land)*im_gdp_pc_mer(t,i)+p39_par_b(land));

p39_cost_landcon_past(t,j,land) = 0;
