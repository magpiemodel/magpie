*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

 p62_dem_material_lh(i,kall) =0;
 p62_dem_food_lh(i)=1;

s62_growth_rate_bioplastic = log(s62_max_demand_bioplastics/f62_hist_bioplastic_demand("y2020") - 1)/(s62_midpoint_bioplastics_dem-2020);
p62_bioplastic_demand(t,i) = f62_hist_bioplastic_demand(t) * (im_pop(t,i) / sum(i2, im_pop(t,i2)));
p62_bioplastic_demand(t,i)$(myear(t)>2020) = s62_max_demand_bioplastics / (1 + exp(-s62_growth_rate_bioplastic*(m_year(t)-s62_midpoint_bioplastics_dem))) * (im_pop(t,i) / sum(i2, im_pop(t,i2)));
p62_dem_bioplastic_lh(i) = sum(t_past$(ord(t_past) eq card(t_past)), p62_bioplastic_demand(t_past, i);