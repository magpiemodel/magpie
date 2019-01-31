scalars
 s32_shift number of 5-year age-classes corresponding to current time step length
;

parameters
 p32_carbon_density(t,j,type32,ac,c_pools)        Carbon density for ac and c_pools (tC per ha)
 p32_carbon_density_ac(t,j,type32,ac,c_pools)     Carbon density for ac and c_pools (tC per ha)
 p32_land(t,j,type32,ac)                          Forestry land for each cell wood type and age class before and after optimization (mio. ha)
 pc32_land(j,type32,ac)                           Forestry land per forestry land type initialization of the optimization (mio. ha)
 p32_aff_pot(t,j)                                 Potential afforestation area (Mha)
 p32_aff_pol_timestep(t,j)                        INDC afforestation per time step (Mha)
 p32_aff_pol(t,j)                                 INDC forest stock (Mha)
 pc32_yield_forestry_future(t,j)                    Cellular timber yield expected in the future (m3 per ha per year)
 p32_yield_forestry_ac(t,j,ac)                    Age class specific yield of plantation forests (m3 per ha per yr)
 p32_hvcost_ha(i)                                 Timber harvesting cost per ha (USD)
 p32_rot_length(t,i)                                Regional rotation length of plantations (yr)
 pm_rot_length(t,i)                                 Regional rotation length of plantations translated to age class equivalent for future (1)
 p32_rotation_cellular(t,j)                         Rotation length translated to age classes on cellular level (1)
 p32_forestry_management(i)                       Plantation forest management factors on world region levels (1)
 pc32_timestep                                    Timestep (1)
 pm_production_ratio_ext(i,t_ext)                 Extened production ratio (1)
 pc32_yield_forestry_mature_future(j)             Future yield of matured tree after rotation period (m3 per ha per yr)
 p32_protect_avail(t,j)                           Mature trees which are protected (mio. ha)
 p32_plant_ini_ac(j)                              Initialization of plantation area (mio. ha)
 pcm_production_ratio_future(i)                  Future production ratio (1)
 pm_rotation_reg(t,i)                              Regional rotation length of plantations translated to age class equivalent for future (1)
 p32_error_check                                  X (1)
 p32_rot_length_estb(t,i)                           Rotation length for establishment (yr)
 pm_rot_length_estb(t,i)                            Regional rotation length of plantations translated to age class equivalent for future (1)
 p32_rotation_cellular_estb(t,j)                    Rotation length translated to age classes on cellular level (1)
 p32_rot_length_all(t,i)                      xx
;

positive variables
 vm_cost_fore(i)                                  Forestry costs (Mio USD)
 v32_land(j,type32,ac)                            Forestry land pools (mio. ha)
 vm_landdiff_forestry                             Aggregated difference in forestry land compared to previous timestep (mio. ha)
* vm_cdr_aff(j,co2_forestry)                       Total CDR from afforestation (new and existing areas) between t+1 and t=s32_planing_horizon (Tg CO2-C)
 vm_cdr_aff(j)                       Total CDR from afforestation (new and existing areas) between t+1 and t=s32_planing_horizon (Tg CO2-C)
 v32_prod(j,kforestry)                             Timber production (mio. m3)
 v32_cost_harvest(i)                              Cost of timber harvesting (USD per ha)
 v32_cost_recur(i)                                Recurring forest management costs (USD per ha)
 v32_hvarea_forestry(j,kforestry,ac_sub)          Area harvested for timber production (mio. ha)

 v32_prod_external(i,kforestry)                   Production balance flow from heaven (mio. m3)

 v32_land_expansion(j,type32,ac)                  Land expansion (mio. ha)
 v32_land_reduction(j,type32,ac)                  land reduction (mio. ha)
 v32_avail_reuse(j)                               Defunct (1)

 v32_cost_establishment(i)                        Cost of establishment calculated at the current time step (mio. USD)
 v32_missing_area_future(j)                       Defunct (1)
 vm_prod_forestry(j,kforestry)	                  xx
;

equations
 q32_cost_total(i)                                total forestry costs constraint (mio. USD)
 q32_land(j)                                      land constraint (mio. ha)
 q32_cdr_aff(j)                      calculation of CDR from afforestation
 q32_carbon(j,c_pools)                            forestry carbon stock calculation
 q32_diff                                         aggregated difference in forestry land compared to previous timestep (mio. ha)
 q32_max_aff                                      maximum total global afforestation
 q32_aff_pol(j)                                   afforestation policy constraint
 q32_prod_forestry_wood(j)        	              wood production from forestry
 q32_prod_forestry_woodfuel(j)     	              woodfuel production from forestry
 q32_hvarea_forestry(j,ac_sub)                    Harvested area from plantations (mio. ha)
 q32_cost_recur(i)                                Recurruing costs (mio. USD)
 q32_cost_harvest(i)                              Harvesting costs (mio. USD)
 q32_production_timber(j,kforestry)                         Timber production from plantations (mio. USD)
 q32_prod_future(i)                               Establishment in current time step for future demand (mio. ha)
 q32_land_expansion(j,type32,ac)                  Land expansion (mio. ha)
 q32_land_reduction(j,type32,ac)                  Land contarction (mio. ha)
 q32_avail_reuse(j)                               Defunct (1)
 q32_cost_establishment(i)                        Present value of cost of establishment (mio. USD)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_fore(t,i,type)                          Forestry costs (Mio USD)
 ov32_land(t,j,type32,ac,type)                   Forestry land pools (mio. ha)
 ov_landdiff_forestry(t,type)                    Aggregated difference in forestry land compared to previous timestep (mio. ha)
 ov_cdr_aff(t,j,type)                            Total CDR from afforestation (new and existing areas) between t+1 and t=s32_planing_horizon (Tg CO2-C)
 ov32_prod(t,j,kforestry,type)                   Timber production (mio. m3)
 ov32_cost_harvest(t,i,type)                     Cost of timber harvesting (USD per ha)
 ov32_cost_recur(t,i,type)                       Recurring forest management costs (USD per ha)
 ov32_hvarea_forestry(t,j,kforestry,ac_sub,type) Area harvested for timber production (mio. ha)
 ov32_prod_external(t,i,kforestry,type)          Production balance flow from heaven (mio. m3)
 ov32_land_expansion(t,j,type32,ac,type)         Land expansion (mio. ha)
 ov32_land_reduction(t,j,type32,ac,type)         land reduction (mio. ha)
 ov32_avail_reuse(t,j,type)                      Defunct (1)
 ov32_cost_establishment(t,i,type)               Cost of establishment calculated at the current time step (mio. USD)
 ov32_missing_area_future(t,j,type)              Defunct (1)
 ov_prod_forestry(t,j,kforestry,type)            xx
 oq32_cost_total(t,i,type)                       total forestry costs constraint (mio. USD)
 oq32_land(t,j,type)                             land constraint (mio. ha)
 oq32_cdr_aff(t,j,type)                          calculation of CDR from afforestation
 oq32_carbon(t,j,c_pools,type)                   forestry carbon stock calculation
 oq32_diff(t,type)                               aggregated difference in forestry land compared to previous timestep (mio. ha)
 oq32_max_aff(t,type)                            maximum total global afforestation
 oq32_aff_pol(t,j,type)                          afforestation policy constraint
 oq32_prod_forestry_wood(t,j,type)               wood production from forestry
 oq32_prod_forestry_woodfuel(t,j,type)           woodfuel production from forestry
 oq32_hvarea_forestry(t,j,ac_sub,type)           Harvested area from plantations (mio. ha)
 oq32_cost_recur(t,i,type)                       Recurruing costs (mio. USD)
 oq32_cost_harvest(t,i,type)                     Harvesting costs (mio. USD)
 oq32_production_timber(t,j,kforestry,type)      Timber production from plantations (mio. USD)
 oq32_prod_future(t,i,type)                      Establishment in current time step for future demand (mio. ha)
 oq32_land_expansion(t,j,type32,ac,type)         Land expansion (mio. ha)
 oq32_land_reduction(t,j,type32,ac,type)         Land contarction (mio. ha)
 oq32_avail_reuse(t,j,type)                      Defunct (1)
 oq32_cost_establishment(t,i,type)               Present value of cost of establishment (mio. USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
