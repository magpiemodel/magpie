*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
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

* Adjust the afforestation limit `s32_max_aff_area` upwards, if it is below the exogenous policy target.
s32_max_aff_area = max(s32_max_aff_area, sum(j, smax(t2, p32_aff_pol(t2,j))) );

p32_cdr_ac(t,j,ac) = 0;

*initialize parameter
p32_land(t,j,type32,ac) = 0;
p32_land(t,j,"plant","acx") = pcm_land(j,"forestry");

*fix bph effect to zero for all age classes except the ac that is chosen for the bph effect to occur after planting (e.g. canopy closure)
p32_aff_bgp(j,ac) = 0;
p32_aff_bgp(j,"%c32_bgp_ac%") = f32_aff_bgp(j,"%c32_aff_bgp%");
