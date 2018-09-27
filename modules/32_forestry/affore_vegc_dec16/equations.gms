*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*****Costs**********************************************************************

*' The direct costs of afforestation `vm_cost_fore` include maintenance and monitoring 
*' costs for newly established plantations [@sathaye_ghg_2005]. Note that "old" refers 
*' to forestry plantations for wood production in 1995. 
*' In addition, afforestation may cause costs in other parts of the model such 
*' as costs for technological change [13_tc] or land expansion [39_landconversion].

q32_cost_fore_ac(i2) ..
vm_cost_fore(i2) =e= sum((cell(i2,j2),land32,fcosts32)$(not sameas(land32,"old")),
                v32_land(j2,land32)*f32_fac_req_ha(i2,fcosts32));

*****forestry emissions seen in maccs module************************************
*' The interface `vm_cdr_aff` provides the projected CDR of an afforestation 
*' activity for a planning horizon of 30 years `s32_planing_horizon` to the [56_ghg_policy] module. 

q32_cdr_aff(j2,co2_forestry) ..
vm_cdr_aff(j2,co2_forestry) =e=
sum((ac,emis_co2_to_forestry(co2_forestry,c_pools))$(ord(ac) > 1
AND (ord(ac)-1) <= s32_planing_horizon/5), 
v32_land(j2,"new") *
(sum(ct, pm_carbon_density_ac(ct,j2,ac,c_pools)) -
sum(ct, pm_carbon_density_ac(ct,j2,ac-1,c_pools))));

*****Land***************************************************
*' The interface `vm_land` provides aggregated forestry land pools (`land32`) to other modules.

 q32_land(j2) ..
 vm_land(j2,"forestry") =e= sum(land32, v32_land(j2,land32));

*' The constraint `q32_aff_pol` accounts for the exogenous afforestation prescribed by NPI/NDC policies.

 q32_aff_pol(j2) ..
 v32_land(j2,"new_ndc") =e= sum(ct, p32_aff_pol_timestep(ct,j2));

*' The constraint `q32_max_aff` accounts for the allowed maximum global endogenous 
*' afforestation defined in `s32_max_aff_area`. 
*' Note that NPI/NDC afforestation policies are not counted towards the 
*' maximum defined in `s32_max_aff_area`. Therefore, the constraint is 
*' relaxed by the value of exogenously prescribed afforestation (`p32_aff_togo`).

 q32_max_aff .. sum((j2), vm_land(j2,"forestry")-pm_land_start(j2,"forestry"))
                =l= s32_max_aff_area - sum(ct, p32_aff_togo(ct));

*****Carbon stocks**************************************************************
*' Forestry carbon stocks are calculated as the product of forestry land (`v32_land`) and the area
*' weighted mean of carbon density for carbon pools (`p32_carbon_density`).

 q32_carbon(j2,c_pools)  .. vm_carbon_stock(j2,"forestry",c_pools) =e=
                         sum(land32, v32_land(j2,land32)*
                         sum(ct, p32_carbon_density(ct,j2,land32,c_pools)));

*' Forestry land expansion and reduction is calculated as follows:

 q32_land_diff .. vm_landdiff_forestry =e= sum((j2,land32),
 					  v32_land_expansion(j2,land32)
 					+ v32_land_reduction(j2,land32));

 q32_land_expansion(j2,land32) ..
 	v32_land_expansion(j2,land32) =g= v32_land(j2,land32) - pc32_land(j2,land32);

 q32_land_reduction(j2,land32) ..
 	v32_land_reduction(j2,land32) =g= pc32_land(j2,land32) - v32_land(j2,land32);


*** EOF equations.gms ***
