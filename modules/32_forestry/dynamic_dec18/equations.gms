*****GENERAL
*****Land***************************************************
 q32_land(j2) .. vm_land(j2,"forestry") =e=
                       sum((type32,ac), v32_land(j2,type32,ac));

*****Carbon stocks**************************************************************
 q32_carbon(j2,c_pools)  .. vm_carbon_stock(j2,"forestry",c_pools) =e=
                        sum((type32,ac), v32_land(j2,type32,ac)*sum(ct, p32_carbon_density_ac(ct,j2,type32,ac,c_pools)));

*****C-PRICE INDUCED AFFORESTATION
**negative emissions seen in maccs module

q32_cdr_aff(j2) ..
vm_cdr_aff(j2) =e=
sum(ac$(ord(ac) > 1
AND (ord(ac)-1) <= s32_planing_horizon/5),
v32_land(j2,"aff","ac0") *
(sum(ct, pm_carbon_density_ac(ct,j2,ac,"vegc")) -
sum(ct, pm_carbon_density_ac(ct,j2,ac-1,"vegc"))));

**Upper bound for C-price induced afforestation area
 q32_max_aff .. sum((j2,ac), v32_land(j2,"aff",ac)) =l= s32_max_aff_area;


*****PRESCRIBED INDC AFFORESTATION
 q32_aff_pol(j2) ..
					v32_land(j2,"indc","ac0") =e= sum(ct, p32_aff_pol_timestep(ct,j2));

**--------------------------------------------------------------------

*****FORESTRY SECTOR

***COSTS
**total costs
q32_cost_total(i2) .. vm_cost_fore(i2) =e=
                     v32_cost_harvest(i2)
								   + v32_cost_recur(i2)
								   + v32_cost_establishment(i2)
                   + v32_management_incr_cost(i2)
*								   + sum((cell(i2,j2),kforestry), v32_prod_external(j2,kforestry) * 99999)
								   ;
$ontext
re-establishment costs in t0
recurring costs * rotation length (thinning, monitigotr) (1/i)
harvesting costs in t30
transports in t30

PV of establishment decision cost
PV * annuity factor * time step length
$offtext


q32_cost_establishment(i2)..
						v32_cost_establishment(i2)
						=e=
            (sum((cell(i2,j2),type32), v32_land(j2,type32,"ac0") * c32_reESTBcost)
            +
              (sum((ct,kforestry), vm_prod_future_reg_ff(i2,kforestry) * c32_harvesting_cost/((1+pm_interest(i2))**30))
              +
              sum((cell(i2,j2),ct,kforestry), f32_distance(j2) * f32_transport_costs(kforestry)) * sum(kforestry,vm_prod_future_reg_ff(i2,kforestry))
              +
              sum(ct,vm_cost_trade_forestry_ff(i2)/((1+pm_interest(i2))**30))
*************************** ((1+pm_interest(i2))**p32_rot_length(ct,i2)) to calculate present value of future costs
              )
            )
            * (pm_interest(i2)/(1+pm_interest(i2)))
*************************** (pm_interest(i2)/(1+pm_interest(i2))) to annuituze the values. Similar to averaging over time
						;


**Only protected areas incurring recurring/monitoring costs
q32_cost_recur(i2) .. v32_cost_recur(i2) =e=
                    sum((cell(i2,j2),type32,ac_sub), v32_land(j2,type32,ac_sub)$(sum(ct,protect32(ct,j2,ac_sub)))) * f32_fac_req_ha(i2,"recur");

**harvesting costs
q32_cost_harvest(i2)..
                    v32_cost_harvest(i2)
                    =e=
                    sum((cell(i2,j2), kforestry),
                    sum(ac_sub, v32_hvarea_forestry(j2,kforestry,ac_sub))) * fm_harvest_cost_ha(i2)
                    ;

*** YIELDS
q32_yield_forestry_ac(j2,ac_sub)..
  v32_yield_forestry_ac(j2,ac_sub)
  =e=
   (2)
   *
   sum(ct, pm_carbon_density_ac(ct,j2,ac_sub,"vegc")) * v32_management_factor(j2)
   *
   0.85
   /
   sum(clcl,pm_climate_class(j2,clcl) * pm_bcef(ac_sub,clcl))
   ;

***PRODUCTION
q32_prod_forestry_wood(j2)..
                          v32_prod(j2,"wood")
                          =e=
                         sum(ac_sub, v32_hvarea_forestry(j2,"wood",ac_sub) * v32_yield_forestry_ac(j2,ac_sub));

q32_prod_forestry_woodfuel(j2)..
                          v32_prod(j2,"woodfuel")
                          =e=
                        sum(ac_sub, v32_hvarea_forestry(j2,"woodfuel",ac_sub)  * v32_yield_forestry_ac(j2,ac_sub));

***AREA

**harvesting area ((0.6*0.975**(pc32_timestep-m_timdestep_length/2)))
q32_hvarea_forestry(j2,ac_sub) ..
                          sum(kforestry, v32_hvarea_forestry(j2,kforestry,ac_sub))
                          =e=
                          (pc32_land(j2,"plant",ac_sub) - v32_land(j2,"plant",ac_sub));

*********************************************************

 q32_management_incr_cost(i2) ..
                              v32_management_incr_cost(i2)
                              =e=
                              sum(cell(i2,j2),(10**(4+(v32_management_factor(j2)/20))) - (10**(4+(1/20)))) * (pm_interest(i2)/(1+pm_interest(i2)))
                              ;

*********************************************************

q32_prod_cell_forestry(j2,kforestry)..
                          vm_prod_cell_forestry(j2,kforestry)
                          =e=
                          v32_prod(j2,kforestry)
                          ;

q32_production_timber(i2,kforestry)..
                          sum(cell(i2,j2),v32_prod(j2,kforestry))
                          =n=
                          vm_prod_reg(i2,kforestry) * sum(ct, fm_production_ratio(i2,ct))
                          ;

** Establishment in current time step already accounts for a certain percentage of production to be fulfilled by plantations in future.
q32_prod_future(i2) ..
              sum((cell(i2,j2),ct),(v32_land(j2,"plant","ac0")) * pc32_yield_forestry_future(ct,j2))
              =g=
              sum(kforestry, vm_prod_future_reg_ff(i2,kforestry)) * pcm_production_ratio_future(i2)
              ;

q32_avail_reuse(j2) ..      v32_avail_reuse(j2)	=e=	0;

**TECHNICAL STUFF
q32_diff .. vm_landdiff_forestry =e= sum((j2,type32,ac),
                       v32_land_expansion(j2,type32,ac)
                     + v32_land_reduction(j2,type32,ac));

q32_land_expansion(j2,type32,ac) ..
     v32_land_expansion(j2,type32,ac) =g= v32_land(j2,type32,ac) - pc32_land(j2,type32,ac);

q32_land_reduction(j2,type32,ac) ..
     v32_land_reduction(j2,type32,ac) =g= pc32_land(j2,type32,ac) - v32_land(j2,type32,ac);

*** EOF equations.gms ***
