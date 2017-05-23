scalars
 s32_shift number of 5-year age-classes corresponding to current time step length
;

parameters
 pc32_carbon_density_ac(j,ac,c_pools) Current carbon density for ac and c_pools (tC per ha)
 p32_carbon_density_cc(t,j,land32,c_pools) carbon density for land32 and c_pools (tC per ha)
 p32_carbon_density_nocc(t,j,land32,c_pools) Carbon density for land32 and c_pools (tC per ha)
 pc32_carbon_density(j,land32,c_pools) Carbon density for land32 and c_pools in optimization (tC per ha)
 p32_land_fore(t,j,ac,si,when)   Forestry land for each cell wood type and age class before and after optimization (mio. ha)
 pc32_land_fore(j,land32,si)        Forestry land per forestry land type initialization of the optimization (mio. ha)
;

positive variables
 vm_cost_fore(i)                             Afforestation costs (Mio US$)
 v32_land(j,land32,si)              forestry land pools (mio. ha)
 vm_landdiff_forestry          aggregated difference in forestry land compared to previous timestep (mio. ha)
 vm_cdr_aff(j,emis_co2_forestry)   			  total CDR from afforestation (new and existing areas) between t+1 and t=sm_invest_horizon (Tg CO2-C)
;

equations
 q32_cost_fore_ac(i)             total forestry costs constraintt
 q32_land(j,si)                      land constraint
 q32_cdr_aff(j,emis_co2_forestry) 	calculation of CDR from afforestation
 q32_carbon(j,c_pools)                 forestry carbon stock calculation
 q32_diff                   aggregated difference in forestry land compared to previous timestep (mio. ha)        
 q32_max_aff					maximum total global afforestation
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_fore(t,i,type)                   Afforestation costs (Mio US$)
 ov32_land(t,j,land32,si,type)            forestry land pools (mio. ha)
 ov_landdiff_forestry(t,type)             aggregated difference in forestry land compared to previous timestep (mio. ha)
 ov_cdr_aff(t,j,emis_co2_forestry,type)   total CDR from afforestation (new and existing areas) between t+1 and t=sm_invest_horizon (Tg CO2-C)
 oq32_cost_fore_ac(t,i,type)              total forestry costs constraintt
 oq32_land(t,j,si,type)                   land constraint
 oq32_cdr_aff(t,j,emis_co2_forestry,type) calculation of CDR from afforestation
 oq32_carbon(t,j,c_pools,type)            forestry carbon stock calculation
 oq32_diff(t,type)                        aggregated difference in forestry land compared to previous timestep (mio. ha)        
 oq32_max_aff(t,type)                     maximum total global afforestation
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
