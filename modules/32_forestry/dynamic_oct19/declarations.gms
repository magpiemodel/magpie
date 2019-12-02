*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
 s32_shift                               Number of 5-year age-classes corresponding to current time step length (1)
;

parameters
 p32_land(t,j,type32,ac)                 Forestry land for each cell wood type and age class before and after optimization (mio. ha)
 pc32_land(j,type32,ac)                  Forestry land per forestry land type initialization of the optimization (mio. ha)
 p32_aff_pot(t,j)                        Potential afforestation area on cropland and pasture land (mio. ha)
 p32_aff_pol(t,j)			             Exogenous afforestation target as stock (mio. ha)
 p32_aff_pol_timestep(t,j)			     Exogenous afforestation target as flow per time step (mio. ha per timestep)
 p32_aff_togo(t)              		     Remaining exogenous afforestation wrt to the maximum exogenous target over time (mio. ha)
;

positive variables
 vm_cost_fore(i)                         Afforestation costs (mio. USD04MER per yr)
 v32_land(j,type32,ac)                   Forestry land pools (mio. ha)
 vm_landdiff_forestry                    Aggregated difference in forestry land compared to previous timestep (mio. ha)
 v32_land_expansion(j,type32,ac) 		 Forestry land expansion compared to previous timestep (mio. ha)
 v32_land_reduction(j,type32,ac) 		 Forestry land reduction compared to previous timestep (mio. ha)
 vm_cdr_aff(j) 							 Total CDR from afforestation (new and existing areas) between t+1 and t=s32_planing_horizon CO2-C (mio. tC)
;

equations
 q32_cost_fore_ac(i)                      Total forestry costs constraint (mio. USD04MER)
 q32_land(j)                              Land constraint (mio. ha)
 q32_cdr_aff(j)  			  			  Calculation of CDR from afforestation in terms of CO2-C (mio. tC)
 q32_carbon(j,ag_pools)                   Forestry carbon stock calculation C (mio. tC)
 q32_land_diff                            Aggregated difference in forestry land compared to previous timestep (mio. ha)
 q32_land_expansion(j,type32,ac)	   	  Forestry land expansion (mio. ha)
 q32_land_reduction(j,type32,ac)	   	  Forestry land reduction (mio. ha)
 q32_max_aff					          Maximum total global afforestation (mio. ha)
 q32_aff_pol(j)					          Afforestation policy constraint (mio. ha)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_fore(t,i,type)                  Afforestation costs (mio. USD04MER per yr)
 ov32_land(t,j,type32,ac,type)           Forestry land pools (mio. ha)
 ov_landdiff_forestry(t,type)            Aggregated difference in forestry land compared to previous timestep (mio. ha)
 ov32_land_expansion(t,j,type32,ac,type) Forestry land expansion compared to previous timestep (mio. ha)
 ov32_land_reduction(t,j,type32,ac,type) Forestry land reduction compared to previous timestep (mio. ha)
 ov_cdr_aff(t,j,type)                    Total CDR from afforestation (new and existing areas) between t+1 and t=s32_planing_horizon CO2-C (mio. tC)
 oq32_cost_fore_ac(t,i,type)             Total forestry costs constraint (mio. USD04MER)
 oq32_land(t,j,type)                     Land constraint (mio. ha)
 oq32_cdr_aff(t,j,type)                  Calculation of CDR from afforestation in terms of CO2-C (mio. tC)
 oq32_carbon(t,j,ag_pools,type)          Forestry carbon stock calculation C (mio. tC)
 oq32_land_diff(t,type)                  Aggregated difference in forestry land compared to previous timestep (mio. ha)
 oq32_land_expansion(t,j,type32,ac,type) Forestry land expansion (mio. ha)
 oq32_land_reduction(t,j,type32,ac,type) Forestry land reduction (mio. ha)
 oq32_max_aff(t,type)                    Maximum total global afforestation (mio. ha)
 oq32_aff_pol(t,j,type)                  Afforestation policy constraint (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
