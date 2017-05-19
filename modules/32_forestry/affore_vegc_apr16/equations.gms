*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*****Costs**********************************************************************
 q32_cost_fore_ac(i2) .. vm_cost_fore(i2) =e=
                                   sum((cell(i2,j2),si,land32,fcosts32)$(not sameas(land32,"old")), v32_land(j2,land32,si)*f32_fac_req_ha(i2,fcosts32));

*****forestry emissions seen in maccs module****************************************
 q32_cdr_aff(j2,emis_source_co2_forestry) .. vm_cdr_aff(j2,emis_source_co2_forestry) =e=
                                        sum((ac,si,emis_co2_to_forestry(emis_source_co2_forestry,c_pools))$(ord(ac) > 1 AND (ord(ac)-1) <= sm_invest_horizon/5),
                                        v32_land(j2,"new",si) * (pc32_carbon_density_ac(j2,ac,c_pools) - pc32_carbon_density_ac(j2,ac-1,c_pools)));

*****Land***************************************************
 q32_land(j2,si) .. vm_land(j2,"forestry",si) =e=
                       sum(land32, v32_land(j2,land32,si));

 q32_min_aff(i2) .. sum((cell(i2,j2),si), vm_land(j2,"forestry",si)-pcm_land(j2,"forestry",si)) =g= 
					sum(ct,	p32_min_afforest(ct,i2));

 q32_max_aff .. sum((j2,si), vm_land(j2,"forestry",si)-pm_land_start(j2,"forestry",si)) =l= 
					s32_max_aff_area;

*****Carbon stocks**************************************************************
 q32_carbon(j2,c_pools)  .. vm_carbon_stock(j2,"forestry",c_pools) =e=
                        sum(land32, sum(si, v32_land(j2,land32,si))*pc32_carbon_density(j2,land32,c_pools));


 q32_diff .. vm_landdiff_forestry =e= sum((j2,si),v32_land(j2,"new",si)
                                          + pcm_land(j2,"forestry",si)
                                          - v32_land(j2,"prot",si)
                                          - v32_land(j2,"grow",si)
                                          - v32_land(j2,"old",si));
*** EOF equations.gms ***
