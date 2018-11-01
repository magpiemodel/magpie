*****GENERAL
*****Land***************************************************
 q32_land(j2) .. vm_land(j2,"forestry") =e=
                       sum((type32,ac), v32_land(j2,type32,ac));

*****Carbon stocks**************************************************************
 q32_carbon(j2,c_pools)  .. vm_carbon_stock(j2,"forestry",c_pools) =e=
                        sum((type32,ac), v32_land(j2,type32,ac)*sum(ct, pm_carbon_density_ac(ct,j2,ac,c_pools)));

*****C-PRICE INDUCED AFFORESTATION
**negative emissions seen in maccs module
 q32_cdr_aff(j2,emis_source_co2_forestry) .. vm_cdr_aff(j2,emis_source_co2_forestry) =e=
                                        sum((ac,emis_co2_to_forestry(emis_source_co2_forestry,c_pools))$(ord(ac) > 1 AND (ord(ac)-1) <= sm_invest_horizon/5),
                                        v32_land(j2,"aff","ac0") * (sum(ct, pm_carbon_density_ac(ct,j2,ac,c_pools)) - sum(ct, pm_carbon_density_ac(ct,j2,ac-1,c_pools))));

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
								   + v32_cost_transp(i2)
								   + v32_cost_establishment(i2)
								   + sum((cell(i2,j2),kforestry), v32_prod_external(j2,kforestry) * 99999)
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
						sum((cell(i2,j2),type32), v32_land(j2,type32,"ac0") * ( c32_reESTBcost + c32_recurring_cost / pm_interest(i2) ))
						+
						sum(kforestry, v32_prod_future_reg(i2,kforestry) * c32_harvesting_cost/((1+pm_interest(i2))**p32_rot_length(i2)))
						+
						sum((cell(i2,j2),kforestry), f32_distance(j2) * f32_transport_costs(kforestry)/((1+pm_interest(i2))**p32_rot_length(i2)))
					 	* (pm_interest(i2)/(1+pm_interest(i2)))	* m_timestep_length
						+
						sum(cell(i2,j2),v32_missing_area_future(j2) * 100000)
						;

**recurring/management costs
**Only protected areas incurring recurring/monitoring costs
q32_cost_recur(i2) .. v32_cost_recur(i2) =e=
										0;
*                                   sum((cell(i2,j2),type32,fcosts32), v32_land(j2,type32,"ac0")+(v32_prod_external_future(j2)*99999) * f32_fac_req_ha(i2,fcosts32));

**harvesting costs

q32_cost_harvest(i2)..
                    v32_cost_harvest(i2)
                    =e=
                    sum((cell(i2,j2), kforestry),
                    sum(ac_sub, v32_hvarea_forestry(j2,kforestry,ac_sub)) * f32_harvest_cost_ha(i2,"harv")
                    ;
*** THIS CAN BE MOVED TO TRANSPORT MODULE
*** Instead of v32_prod we can use vm_prod interface and add wood/woodfuel transport costs to input file.

q32_cost_transport(i2) ..     v32_cost_transp(i2)
                              =e=
                              sum((hvarea_timber,kforestry,cell(i2,j2)), v32_prod(j2,hvarea_timber,kforestry) * f32_distance(j2) * f32_transport_costs(kforestry));

**--------------------------------------------------------------------

***PRODUCTION New Production routine 20180727

**** FROM PLANTATIONS
q32_prod_forestry_wood(j2)..
                          v32_prod(j2,"forestry","wood")
                          =e=
                         sum(ac_sub, v32_hvarea_forestry(j2,"wood",ac_sub) * sum(ct, p32_yield_forestry_ac(ct,j2,ac_sub)))* 0.88;

q32_prod_forestry_woodfuel(j2)..
                          v32_prod(j2,"forestry","woodfuel")
                          =e=
                         sum(ac_sub, v32_hvarea_forestry(j2,"wood",ac_sub)      * sum(ct, p32_yield_forestry_ac(ct,j2,ac_sub)))* (1-0.88)
						            +sum(ac_sub, v32_hvarea_forestry(j2,"woodfuel",ac_sub)  * sum(ct, p32_yield_forestry_ac(ct,j2,ac_sub)));

**--------------------------------------------------------------------

***AREA


*q32_land_fix(j2) ..       sum(ac, v32_land(j2,"plant",ac))
*                          =e=
*						  sum(ac, pc32_land(j2,"plant",ac));


**harvesting area ((0.6*0.975**(pc32_timestep-m_timdestep_length/2)))
q32_hvarea_forestry(j2,ac_sub) ..
                          sum(kforestry, v32_hvarea_forestry(j2,kforestry,ac_sub))
                          =e=
                          (pc32_land(j2,"plant",ac_sub) - v32_land(j2,"plant",ac_sub));

*********************************************************

q32_production_timber(i2)..
                          sum((kforestry,cell(i2,j2)),vm_prod(j2,kforestry)) * sum(ct,f32_production_ratio(i2,ct))
                          =e=
                          sum((kforestry,cell(i2,j2)),sum(hvarea_timber, v32_prod(j2,hvarea_timber,kforestry)) + v32_prod_external(j2,kforestry))
                          ;

**--------------------------------------------------------------------

** Establishment in current time step already accounts for a certain percentage of production to be fulfilled by plantations in future.
** 20percent buffer and 88 percent efficiency 12 percent loss factor

q32_prod_future(i2) ..          sum(kforestry, v32_prod_future_reg(i2,kforestry)) * pc32_production_ratio_future(i2)
                                =e=
                                sum(cell(i2,j2), (v32_land(j2,"plant","ac0") + v32_missing_area_future(j2)) * pc32_yield_forestry_future(j2) * 0.88);
*    							+
*    							sum(cell(i2,j2), v32_avail_reuse(j2) * pc32_yield_forestry_mature_future(j2)) * 0.80

q32_avail_reuse(j2) ..      v32_avail_reuse(j2)
							=e=
							0;
*************************** This has to be changed into paramaeter later
*							sum(ac,v32_land(j2,"plant",ac) - v32_land.lo(j2,"plant",ac));
$ontext
q32_prod_future_reg(i2,kforestry) ..  v32_prod_future_reg(i2,kforestry)
									=e=
									sum(cell(i2,j2),v32_prod_future(j2,kforestry));
$offtext
**--------------------------------------------------------------------

**TECHNICAL STUFF
q32_diff .. vm_landdiff_forestry =e= sum((j2,type32,ac),
                       v32_land_expansion(j2,type32,ac)
                     + v32_land_reduction(j2,type32,ac));

q32_land_expansion(j2,type32,ac) ..
     v32_land_expansion(j2,type32,ac) =g= v32_land(j2,type32,ac) - pc32_land(j2,type32,ac);

q32_land_reduction(j2,type32,ac) ..
     v32_land_reduction(j2,type32,ac) =g= pc32_land(j2,type32,ac) - v32_land(j2,type32,ac);


**---------------------------------------------------------------------

** FUTURE TRADE EQUATIONS (Analogous to trade module)

q32_trade_reg(i2,kforestry)..     v32_prod_future_reg(i2,kforestry)
                                  =g=
                  (pc32_demand_forestry_future(i2,kforestry) + v32_excess_prod(i2,kforestry))
                 * pc32_trade_bal_reduction_future$(pc32_selfsuff_forestry_future(i2,kforestry) >= 1)
                 + pc32_demand_forestry_future(i2,kforestry)
                 * pc32_selfsuff_forestry_future(i2,kforestry)
                 * pc32_trade_bal_reduction_future$(pc32_selfsuff_forestry_future(i2,kforestry) < 1);

q32_excess_dem(kforestry).. v32_excess_dem(kforestry)
                            =g=
                            sum(i2, pc32_demand_forestry_future(i2,kforestry)*(1 - pc32_selfsuff_forestry_future(i2,kforestry))$(pc32_selfsuff_forestry_future(i2,kforestry) < 1))
                            + pc32_trade_balanceflow_future(kforestry);

q32_excess_supply(i2,kforestry)..   v32_excess_prod(i2,kforestry)
                                    =e=
                                    v32_excess_dem(kforestry)*pc32_exp_shr_future(i2,kforestry);

q32_cost_trade_reg(i2,kforestry)..  v32_cost_trade_reg(i2,kforestry)
                                    =g=
                                   (i32_trade_margin(i2,kforestry) + i32_trade_tariff(i2,kforestry))*(v32_prod_future_reg(i2,kforestry)-pc32_demand_forestry_future(i2,kforestry));

q32_cost_trade(i2)..          vm_cost_trade_forestry(i2) =e= sum(kforestry,v32_cost_trade_reg(i2,kforestry));

*** EOF equations.gms ***
