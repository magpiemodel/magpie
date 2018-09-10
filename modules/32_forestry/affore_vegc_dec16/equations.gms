*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*****Costs**********************************************************************

*' Costs of an afforestation activity are represented by the product of annual costs for
*' carrying out maintainence of forestry land (except for old forests) and annual factor
*' requirement costs.

q32_cost_fore_ac(i2) ..
vm_cost_fore(i2) =e= sum((cell(i2,j2),land32,fcosts32)$(not sameas(land32,"old")),
                v32_land(j2,land32)*f32_fac_req_ha(i2,fcosts32));

*' Interface `vm_cost_fore` is then used in costs ([11_costs]) module as a part of global
*' production costs calculation.

*****forestry emissions seen in maccs module************************************
*' Interface `vm_cdr_aff` calculates carbon dioxide removal from afforestation by (new and
*' existing forest areas) between t+1 and t =`s32_planing_horizon` time frame.

q32_cdr_aff(j2,co2_forestry) ..
vm_cdr_aff(j2,co2_forestry)
=e=
sum((ac,emis_co2_to_forestry(co2_forestry,c_pools))$(ord(ac) > 1
AND (ord(ac)-1) <= s32_planing_horizon/5),
v32_land(j2,"new") *
(sum(ct, pm_carbon_density_ac(ct,j2,ac,c_pools)) -
sum(ct, pm_carbon_density_ac(ct,j2,ac-1,c_pools))));

*' This is calculated from the forestry land CO2 emissions of the "newly" planted trees
*' multiplied by the difference between the age-class and carbon pool dependent carbon
*' density of consecutive age classes. This calculation is however only carried out for
*' forest age-classes which have non-zero carbon density till the point where the forest
*' belongs to age-classes less than the planning horizon specified in `s32_planing_horizon`.

*****Land***************************************************
*' Forestry component of `vm_land` (calculated in [10_land]) interface is set equal to the
*' sum of all kinds of existing forestry land over each cell.

 q32_land(j2) ..
 vm_land(j2,"forestry") =e= sum(land32, v32_land(j2,land32));

*' Afforestation targets promised in NDC documents belonging to the forestry land pool are
*' assigned the value of afforestation carried out according to NDCs for each time step.

 q32_aff_pol(j2) ..
 v32_land(j2,"new_ndc")
                    =e=
                    sum(ct, p32_aff_pol_timestep(ct,j2));

*' Maximum area allowed to be dedicated for afforestation is calculated using difference
*' between the area of forestry land type and exogenous forestry land initialization area.

 q32_max_aff .. sum((j2), vm_land(j2,"forestry")-pm_land_start(j2,"forestry"))
                =l=
				s32_max_aff_area - sum(ct, p32_aff_togo(ct));

*' This difference is restricted to be less than or equal to a fixed value provided by
*' `s32_max_aff_area`.

*****Carbon stocks**************************************************************
*' Forestry carbon stocks are calculated as the product of forestry land with the area
*' weighted mean of carbon density for forest land and carbon pools (in tC per ha)
*' (i.e `p32_carbon_density`).

 q32_carbon(j2,c_pools)  .. vm_carbon_stock(j2,"forestry",c_pools)
                         =e=
                         sum(land32, v32_land(j2,land32)*
                         sum(ct, p32_carbon_density(ct,j2,land32,c_pools)));

*' `p32_carbon_density_ac` is defined as age-class and carbon pool dependent carbon
*' density and is calculated as the weighted mean of the carbon density for age-classes
*' and carbon pools (in tC per ha) as defined in the Carbon module ([52_carbon]) of this model.


*' The aggregated difference in forestry land compared to previous timestep is
*' calculated as a sum of area available in protected, grown and old forests
*' subtracted from the sum of area allocated to new forests, forests planted in
*' accordance to the NDC promises and forestry land initialization area.
*' This difference is in total summed over the cells.

 q32_land_diff .. vm_landdiff_forestry =e= sum((j2,land32),
 					  v32_land_expansion(j2,land32)
 					+ v32_land_reduction(j2,land32));

 q32_land_expansion(j2,land32) ..
 	v32_land_expansion(j2,land32) =g= v32_land(j2,land32) - pc32_land(j2,land32);

 q32_land_reduction(j2,land32) ..
 	v32_land_reduction(j2,land32) =g= pc32_land(j2,land32) - v32_land(j2,land32);

*' The interface `vm_landdiff_forestry` is a component of `vm_landdiff` ([10_land])
*' interface which is the aggregated difference in land between current and
*' previous timestep i.e.,"land use change"

*** EOF equations.gms ***
