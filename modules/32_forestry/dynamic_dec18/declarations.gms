scalars
 s32_shift number of 5-year age-classes corresponding to current time step length
;

parameters
 p32_carbon_density(t,j,type32,ac,c_pools)        Carbon density for ac and c_pools (tC per ha)
 p32_land(t,j,type32,ac)                          Forestry land for each cell wood type and age class before and after optimization (mio. ha)
 pc32_land(j,type32,ac)                           Forestry land per forestry land type initialization of the optimization (mio. ha)
 p32_aff_pot(t,j)                                 Potential afforestation area (Mha)
 p32_aff_pol_timestep(t,j)                        INDC afforestation per time step (Mha)
 p32_aff_pol(t,j)                                 INDC forest stock (Mha)
 p32_demand_ext(t_ext,i,kforestry)                Extended demand for timber beyound simulation (mio. m3)
 pc32_demand_forestry_future(i,kforestry)         Future timber demand (mio. m3)
 pc32_yield_forestry_future(j)                    Cellular timber yield expected in the future (m3 per ha per year)
 p32_yield_forestry_ac(t,j,ac)                    Age class specific yield of plantation forests (m3 per ha per yr)
 p32_hvcost_ha(i)                                 Timber harvesting cost per ha (USD)
 p32_rot_length(i)                                Regional rotation length of plantations (yr)
 p32_rotation_reg(i)                              Regional rotation length of plantations translated to age class equivalent for future (1)
 p32_rotation_cellular(j)                         Rotation length translated to age classes on cellular level (1)
 p32_forestry_management(i)                       Plantation forest management factors on world region levels (1)
 pc32_timestep                                    Timestep (1)
 p32_selfsuff_ext(t_ext,i,kforestry)              Self sufficiency for timber products in extended time frame (1)
 pc32_selfsuff_forestry_future(i,kforestry)       Future self sufficiency ratio for timber products (1)
 p32_trade_balanceflow_ext(t_ext,kforestry)       Extended trade balance flow numbers (1)
 p32_exp_shr_ext(t_ext,i,kforestry)               Extended export share (1)

 i32_trade_bal_reduction(t_ext_forestry)          Trade balance reduction (1)
 i32_trade_bal_reduction_annual(t_ext_forestry)   Annual trade balance reduction (1)
 i32_trade_margin(i,kforestry)                    Trade margins (1)
 i32_trade_tariff(i,kforestry)                    Trade tariffs (1)
 pc32_trade_bal_reduction_future                  Future trade balance reduction (1)
 pc32_trade_balanceflow_future(kforestry)         Future trade balanceflow (1)
 pc32_exp_shr_future(i,kforestry)                 Future export share (1)

 p32_production_ratio_ext(i,t_ext)                Extened production ratio (1)
 pc32_production_ratio_future(i)                  Future production ratio (1s)
 pc32_yield_forestry_mature_future(j)             Future yield of matured tree after rotation period (m3 per ha per yr)
 p32_protect_avail(t,j)                           Mature trees which are protected (mio. ha)

 p32_plant_ini_ac(j)                              Initialization of plantation area (mio. ha)
 p32_yield_natveg(t,j,ac)                         Yield of natural forest (m3 per ha per yr)
 p32_yield_primforest(t,j)                        Yield of primary forest (m3 per ha per yr)
;

positive variables
 vm_cost_fore(i)                                  Forestry costs (Mio USD)
 v32_land(j,type32,ac)                            Forestry land pools (mio. ha)
 vm_landdiff_forestry                             Aggregated difference in forestry land compared to previous timestep (mio. ha)
 vm_cdr_aff(j,emis_source_co2_forestry)           Total CDR from afforestation (new and existing areas) between t+1 and t=sm_invest_horizon (Tg CO2-C)
 v32_prod(j,hvarea_timber,kforestry)                   Timber production (mio. m3)
 v32_cost_harvest(i)                              Cost of timber harvesting (USD per ha)
 v32_cost_recur(i)                                Recurring forest management costs (USD per ha)
 v32_cost_transp(i)                               Transportation costs (USD per m3)
 v32_hvarea_forestry(j,kforestry,ac_sub)          Area harvested for timber production (mio. ha)
 v32_hvarea_secdforest(j,kforestry,ac_sub)        Harvested secondary forest area (mio. ha)
 v32_hvarea_primforest(j,kforestry)               Primary forest harvested (mio. ha)

 v32_excess_dem(kforestry)                        Global excess demand (mio. ton DM)
 v32_excess_prod(i,kforestry)                     Regional excess production (mio. ton DM)
 vm_cost_trade_forestry(i)                        Transport costs and taxes for the bilateral trade (Mio USD)
 v32_cost_trade_reg(i,kforestry)                  Interregional trade costs (mio. USD)

 v32_prod_future_reg(i,kforestry)                 Future regional production (mio. m3)

 v32_prod_external(j,kforestry)                   Production balance flow from heaven (mio. m3)

 v32_land_expansion(j,type32,ac)                  Land expansion (mio. ha)
 v32_land_reduction(j,type32,ac)                  land reduction (mio. ha)
 v32_avail_reuse(j)                               Defunct (1)

 v32_hvarea_other(j,kforestry,ac_sub)             Harvested area of other land (mio. ha)
 v32_cost_establishment(i)                        Cost of establishment calculated at the current time step (mio. USD)
 v32_missing_area_future(j)                       Defunct (1)
;

equations
 q32_cost_total(i)                                total forestry costs constraint (mio. USD)
 q32_land(j)                                      land constraint (mio. ha)
 q32_cdr_aff(j,emis_source_co2_forestry)          calculation of CDR from afforestation
 q32_carbon(j,c_pools)                            forestry carbon stock calculation
 q32_diff                                         aggregated difference in forestry land compared to previous timestep (mio. ha)
 q32_max_aff                                      maximum total global afforestation
 q32_aff_pol(j)                                   afforestation policy constraint
 q32_prod_forestry_wood(j)        	              wood production from forestry
 q32_prod_secdforest_wood(j)                      wood production from secdforest
 q32_prod_primforest_wood(j)                      wood production from primforest
 q32_prod_forestry_woodfuel(j)     	              woodfuel production from forestry
 q32_prod_secdforest_woodfuel(j)   	              woodfuel production from secdforest
 q32_prod_primforest_woodfuel(j)                  woodfuel production from primforest

 q32_hvarea_forestry(j,ac_sub)
 q32_hvarea_secdforest(j,ac_sub)
 q32_hvarea_primforest(j)
 q32_cost_recur(i)
 q32_cost_harvest(i)
 q32_cost_transport(i)
 q32_production_timber(j)

 q32_trade_reg(i,kforestry)                regional trade balances i.e. minimum self-suff ratio
 q32_excess_dem(kforestry)                 global excess demand
 q32_excess_supply(i,kforestry)            regional excess production
 q32_cost_trade(i)                         trade costs
 q32_cost_trade_reg(i,kforestry)           interregional trade cost calculation (mio. USD)

 q32_prod_future(i)
* q32_prod_future_reg(i,kforestry)

 q32_land_expansion(j,type32,ac)
 q32_land_reduction(j,type32,ac)

 q32_avail_reuse(j)

* q32_land_fix(j)

 q32_hvarea_other(j,ac_sub)
 q32_prod_other(j)
 q32_cost_establishment(i)
 q32_secdforest_conversion(j)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_fore(t,i,type)                            Forestry costs (Mio USD)
 ov32_land(t,j,type32,ac,type)                     Forestry land pools (mio. ha)
 ov_landdiff_forestry(t,type)                      Aggregated difference in forestry land compared to previous timestep (mio. ha)
 ov_cdr_aff(t,j,emis_source_co2_forestry,type)     Total CDR from afforestation (new and existing areas) between t+1 and t=sm_invest_horizon (Tg CO2-C)
 ov32_prod(t,j,hvarea_timber,kforestry,type)       Timber production (mio. m3)
 ov32_cost_harvest(t,i,type)                       Cost of timber harvesting (USD per ha)
 ov32_cost_recur(t,i,type)                         Recurring forest management costs (USD per ha)
 ov32_cost_transp(t,i,type)                        Transportation costs (USD per m3)
 ov32_hvarea_forestry(t,j,kforestry,ac_sub,type)   Area harvested for timber production (mio. ha)
 ov32_hvarea_secdforest(t,j,kforestry,ac_sub,type) Harvested secondary forest area (mio. ha)
 ov32_hvarea_primforest(t,j,kforestry,type)        Primary forest harvested (mio. ha)
 ov32_excess_dem(t,kforestry,type)                 Global excess demand (mio. ton DM)
 ov32_excess_prod(t,i,kforestry,type)              Regional excess production (mio. ton DM)
 ov_cost_trade_forestry(t,i,type)                  Transport costs and taxes for the bilateral trade (Mio USD)
 ov32_cost_trade_reg(t,i,kforestry,type)           Interregional trade costs (mio. USD)
 ov32_prod_future_reg(t,i,kforestry,type)          Future regional production (mio. m3)
 ov32_prod_external(t,j,kforestry,type)            Production balance flow from heaven (mio. m3)
 ov32_land_expansion(t,j,type32,ac,type)           Land expansion (mio. ha)
 ov32_land_reduction(t,j,type32,ac,type)           land reduction (mio. ha)
 ov32_avail_reuse(t,j,type)                        Defunct (1)
 ov32_hvarea_other(t,j,kforestry,ac_sub,type)      Harvested area of other land (mio. ha)
 ov32_cost_establishment(t,i,type)                 Cost of establishment calculated at the current time step (mio. USD)
 ov32_missing_area_future(t,j,type)                Defunct (1)
 oq32_cost_total(t,i,type)                         total forestry costs constraint (mio. USD)
 oq32_land(t,j,type)                               land constraint (mio. ha)
 oq32_cdr_aff(t,j,emis_source_co2_forestry,type)   calculation of CDR from afforestation
 oq32_carbon(t,j,c_pools,type)                     forestry carbon stock calculation
 oq32_diff(t,type)                                 aggregated difference in forestry land compared to previous timestep (mio. ha)
 oq32_max_aff(t,type)                              maximum total global afforestation
 oq32_aff_pol(t,j,type)                            afforestation policy constraint
 oq32_prod_forestry_wood(t,j,type)                 wood production from forestry
 oq32_prod_secdforest_wood(t,j,type)               wood production from secdforest
 oq32_prod_primforest_wood(t,j,type)               wood production from primforest
 oq32_prod_forestry_woodfuel(t,j,type)             woodfuel production from forestry
 oq32_prod_secdforest_woodfuel(t,j,type)           woodfuel production from secdforest
 oq32_prod_primforest_woodfuel(t,j,type)           woodfuel production from primforest
 oq32_hvarea_forestry(t,j,ac_sub,type)             
 oq32_hvarea_secdforest(t,j,ac_sub,type)           
 oq32_hvarea_primforest(t,j,type)                  
 oq32_cost_recur(t,i,type)                         
 oq32_cost_harvest(t,i,type)                       
 oq32_cost_transport(t,i,type)                     
 oq32_production_timber(t,j,type)                  
 oq32_trade_reg(t,i,kforestry,type)                regional trade balances i.e. minimum self-suff ratio
 oq32_excess_dem(t,kforestry,type)                 global excess demand
 oq32_excess_supply(t,i,kforestry,type)            regional excess production
 oq32_cost_trade(t,i,type)                         trade costs
 oq32_cost_trade_reg(t,i,kforestry,type)           interregional trade cost calculation (mio. USD)
 oq32_prod_future(t,i,type)                        
 oq32_land_expansion(t,j,type32,ac,type)           
 oq32_land_reduction(t,j,type32,ac,type)           
 oq32_avail_reuse(t,j,type)                        
 oq32_hvarea_other(t,j,ac_sub,type)                
 oq32_prod_other(t,j,type)                         
 oq32_cost_establishment(t,i,type)                 
 oq32_secdforest_conversion(t,j,type)              
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
