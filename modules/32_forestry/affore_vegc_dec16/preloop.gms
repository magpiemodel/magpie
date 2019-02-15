*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

* Select afforestation policy depending on `c32_aff_policy`.
p32_aff_pol(t,j) = f32_aff_pol(t,j,"%c32_aff_policy%");

* Calculate the remaining exogenous afforestation with respect to the maximum exogenous target over time.
* `p32_aff_togo` is used to adjust `s32_max_aff_area` in the constraint `q32_max_aff`.
p32_aff_togo(t) = sum(j, smax(t2, p32_aff_pol(t2,j)) - p32_aff_pol(t,j));

*initialize parameter
p32_land(t,j,ac,when) = 0;

* Fix production related parameters to 0
pm_production_ratio_ext(i,t_ext) = 0;
pm_rot_length(i) = 0;

* Fix future trade related variables to 0
vm_prod_future_reg_ff.fx(i2,kforestry) = 0;
fm_forestry_demand(t_all,i,kforestry) = 0;
