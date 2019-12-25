*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*****Costs**********************************************************************

*' The direct costs of afforestation `vm_cost_fore` include maintenance and monitoring
*' costs for plantations [@sathaye_ghg_2005]. 
*' In addition, afforestation may cause costs in other parts of the model such
*' as costs for technological change [13_tc] or land expansion [39_landconversion].

q32_cost_fore_ac(i2) ..
vm_cost_fore(i2) =e= sum((cell(i2,j2),type32,ac,fcosts32),
                v32_land(j2,type32,ac)*f32_fac_req_ha(i2,fcosts32));


*****C-PRICE INDUCED AFFORESTATION
*****forestry emissions seen in 56_ghg_policy module************************************
*' The interface `vm_cdr_aff` provides the projected CDR of an afforestation
*' activity for a given planning horizon `s32_planing_horizon` to the [56_ghg_policy] module.

q32_cdr_aff(j2,ac) ..
vm_cdr_aff(j2,ac) =e=
v32_land(j2,"aff","ac0") * sum(ct, p32_cdr_ac(ct,j2,ac));

*****Land***************************************************
*' The interface `vm_land` provides aggregated forestry land pools (`type32`) to other modules.

 q32_land(j2) ..
 vm_land(j2,"forestry") =e= sum((type32,ac), v32_land(j2,type32,ac));

*' The constraint `q32_aff_pol` accounts for the exogenous afforestation prescribed by NPI/NDC policies.

 q32_aff_pol(j2) ..
 v32_land(j2,"indc","ac0") =e= sum(ct, p32_aff_pol_timestep(ct,j2));

*' The constraint `q32_max_aff` accounts for the allowed maximum global
*' afforestation defined in `p32_max_aff_area`. Note that NPI/NDC afforestation 
*' policies are counted towards the maximum defined in `p32_max_aff_area`. 
*' Therefore, the right-hand side of the constraint is tightened by the value of 
*' the exogenously prescribed afforestation that has to be realized in later 
*' time steps (`p32_aff_togo`).

 q32_max_aff .. sum((j2,type32,ac)$(not sameas(type32,"plant")), v32_land(j2,type32,ac))
                =l= p32_max_aff_area - sum(ct, p32_aff_togo(ct));

*****Carbon stocks**************************************************************
*' Forestry above ground carbon stocks are calculated as the product of forestry land (`v32_land`) and the area
*' weighted mean of carbon density for carbon pools (`p32_carbon_density`).

 q32_carbon(j2,ag_pools)  .. vm_carbon_stock(j2,"forestry",ag_pools) =e=
                         sum((type32,ac), v32_land(j2,type32,ac)*
                         sum(ct, pm_carbon_density_ac(ct,j2,ac,ag_pools)));

*' Forestry land expansion and reduction is calculated as follows:

 q32_land_diff .. vm_landdiff_forestry =e= sum((j2,type32,ac),
 					  v32_land_expansion(j2,type32,ac)
 					+ v32_land_reduction(j2,type32,ac));

 q32_land_expansion(j2,type32,ac) ..
 	v32_land_expansion(j2,type32,ac) =g= v32_land(j2,type32,ac) - pc32_land(j2,type32,ac);

 q32_land_reduction(j2,type32,ac) ..
 	v32_land_reduction(j2,type32,ac) =g= pc32_land(j2,type32,ac) - v32_land(j2,type32,ac);
