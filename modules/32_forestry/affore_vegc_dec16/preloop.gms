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
