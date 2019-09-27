*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
pc32_rot_length(i) = 0;

* Fix future trade related variables to 0
*vm_prod_future_reg_ff.fx(i2,kforestry) = 0;

* Set cellular forestry production to 0
vm_prod_cell_forestry.fx(j,kforestry) = 0;
