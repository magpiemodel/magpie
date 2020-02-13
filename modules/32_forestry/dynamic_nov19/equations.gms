*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*****Costs**********************************************************************

*' The direct costs of Timber production and afforestation `vm_cost_fore` include
*' maintenance and monitoring costs for newly established plantations as well as
*' standing plantations '[@sathaye_ghg_2005]. In addition, this type of forest management
*' (including afforestation) may cause costs in other parts of the model such as costs
*' for technological change [13_tc] or land expansion [39_landconversion]. Also included
*' are additional costs for producing timber from extremely highly managed plantations
*' which are analogous to intensification using technological change from [13_tc] but
*' in a parametrized form.

q32_cost_total(i2) .. vm_cost_fore(i2) =e=
                     v32_cost_harvest(i2)
								   + v32_cost_recur(i2)
								   + v32_cost_establishment(i2)
                   + v32_high_mgmt_prod_cost(i2)
*                   + sum((cell(i2,j2),kforestry), vm_prod_heaven_timber(i2,kforestry) * 10e9)
								   ;

*****C-PRICE INDUCED AFFORESTATION
*****forestry emissions seen in maccs module************************************
*' The interface `vm_cdr_aff` provides the projected CDR of an afforestation
*' activity for a planning horizon of 30 years `s32_planing_horizon` to the [56_ghg_policy] module.

q32_cdr_aff(j2,ac) ..
vm_cdr_aff(j2,ac) =e=
v32_land(j2,"aff","ac0") * sum(ct, p32_cdr_ac(ct,j2,ac));

*****GENERAL
*****Land***************************************************
*' The interface `vm_land` provides aggregated forestry land pools (`type32`) to other modules.

 q32_land(j2) ..
 vm_land(j2,"forestry") =e= sum((type32,ac), v32_land(j2,type32,ac));

*' The constraint `q32_aff_pol` accounts for the exogenous afforestation prescribed by NPI/NDC policies.

 q32_aff_pol(j2) ..
 v32_land(j2,"indc","ac0") =e= sum(ct, p32_aff_pol_timestep(ct,j2));

*' The constraint `q32_max_aff` accounts for the allowed maximum global
*' carbon-price induced endogenous afforestation defined in `s32_max_aff_area`.
*' Note that NPI/NDC afforestation policies are not counted towards the
*' maximum defined in `s32_max_aff_area`. Therefore, the right-hand side of the constraint
*' is relaxed by the value of exogenously prescribed afforestation (`p32_aff_togo`).

 q32_max_aff .. sum((j2), vm_land(j2,"forestry")-pm_land_start(j2,"forestry"))
                =l= s32_max_aff_area + sum(ct, p32_aff_togo(ct));

*****Carbon stocks**************************************************************
*' Forestry above ground carbon stocks are calculated as the product of forestry land (`v32_land`) and the area
*' weighted mean of carbon density for carbon pools (`p32_carbon_density`).

 q32_carbon(j2,ag_pools)  .. vm_carbon_stock(j2,"forestry",ag_pools) =e=
                         sum((type32,ac), v32_land(j2,type32,ac)*
                         sum(ct, p32_carbon_density_ac(ct,j2,type32,ac,ag_pools)));

*' Forestry land expansion and reduction is calculated as follows:

 q32_land_diff .. vm_landdiff_forestry =e= sum((j2,type32,ac),
 					  v32_land_expansion(j2,type32,ac)
 					+ v32_land_reduction(j2,type32,ac));

 q32_land_expansion(j2,type32,ac) ..
 	v32_land_expansion(j2,type32,ac) =g= v32_land(j2,type32,ac) - pc32_land(j2,type32,ac);

 q32_land_reduction(j2,type32,ac) ..
 	v32_land_reduction(j2,type32,ac) =g= pc32_land(j2,type32,ac) - v32_land(j2,type32,ac);

**--------------------------------------------------------------------

*****FORESTRY SECTOR

***COSTS

$ontext
re-establishment costs in t0
recurring costs * rotation length (thinning, monitigotr) (1/i)
harvesting costs in t30
transports in t30

PV of establishment decision cost
PV * annuity factor * time step length
$offtext

*' Cost of new plantations establishment `v32_cost_establishment` calculated as the product of forestry land (`v32_land`) and the area
*' weighted mean of carbon density for carbon pools (`p32_carbon_density`).

q32_cost_establishment(i2)..
						v32_cost_establishment(i2)
						=e=
            (sum((cell(i2,j2),type32), v32_land(j2,type32,"ac0") * c32_reESTBcost)
            +
              (
*             sum((ct,kforestry), vm_prod_future_reg_ff(i2,kforestry) * c32_harvesting_cost/((1+pm_interest(i2))**30))
*              +
              sum((cell(i2,j2),ct,kforestry), fm_distance(j2) * fm_transport_costs(kforestry)) * sum(kforestry,vm_prod_future_reg_ff(i2,kforestry))
              +
              sum(ct,vm_cost_trade_forestry_ff(i2)/((1+pm_interest(i2))**30))
************ ((1+pm_interest(i2))**p32_rot_length(ct,i2)) to calculate present value of future costs
              )
            )
            * (pm_interest(i2)/(1+pm_interest(i2)))
*************************** (pm_interest(i2)/(1+pm_interest(i2))) to annuituze the values. Similar to averaging over time
						;


**Only protected areas incurring recurring/monitoring costs
q32_cost_recur(i2) .. v32_cost_recur(i2) =e=
                    sum((cell(i2,j2),type32,ac_sub), v32_land(j2,type32,ac_sub)) * f32_fac_req_ha(i2,"recur");

**harvesting costs
q32_cost_harvest(i2)..
                    v32_cost_harvest(i2)
                    =e=
                    sum((cell(i2,j2), kforestry, ac_sub), v32_hvarea_forestry(j2,kforestry,ac_sub,"normal")) * fm_harvest_cost_ha(i2)
                    ;

*********************************************************
***** Establishment
q32_prod_future(i2,kforestry) ..
              sum((cell(i2,j2)), v32_land(j2,"plant","ac0") * pc32_yield_forestry_future(j2,kforestry))
              =g=
              vm_prod_future_reg_ff(i2,kforestry) * pcm_production_ratio_future(i2)
              ;

*********************************************************
*** harvested AREA
q32_hvarea_forestry(j2,ac_sub) ..
                          sum((kforestry,mgmt_type), v32_hvarea_forestry(j2,kforestry,ac_sub,mgmt_type))
                          =e=
                          (pc32_land(j2,"plant",ac_sub) - v32_land(j2,"plant",ac_sub));

*********************************************************
***PRODUCTION
q32_prod_forestry(j2,kforestry)..
                          vm_prod_cell_forestry(j2,kforestry)
                          =e=
                         sum((ac_sub,ct,mgmt_type), v32_hvarea_forestry(j2,kforestry,ac_sub,mgmt_type) * p32_yield_forestry_ac(ct,j2,ac_sub,mgmt_type,kforestry))
                         ;

*********************************************************
**** Parametrised TAU for plantations
 q32_high_mgmt_prod_cost(i2) ..
                              v32_high_mgmt_prod_cost(i2)
                              =e=
                              sum((cell(i2,j2),ct,kforestry,ac_sub), v32_hvarea_forestry(j2,kforestry,ac_sub,"high") * p32_yield_forestry_ac(ct,j2,ac_sub,"high",kforestry)) * 10e4
                              ;
*** EOF equations.gms ***
