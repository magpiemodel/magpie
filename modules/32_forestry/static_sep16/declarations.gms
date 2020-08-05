*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_cost_fore(i)                    Forestry costs (Mio USD)
 vm_landdiff_forestry            	Aggregated difference in forestry land compared to previous timestep (mio. ha)
 v32_land(j,type32,ac)           	Forestry land pools (mio. ha)
 vm_cdr_aff(j,ac,aff_effect) 		Expected bgc (CDR) and local bph effects of afforestation depending on planning horizon (mio. tC)
 vm_forestry_reduction(j,type32,ac)	Reduction of forestry land (mio. ha)
;

parameters
 pc32_carbon_density(j,ag_pools) Above ground carbon density in optimization (tC per ha)
 pm_representative_rotation(t_all,i)                Representative regional rotation (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_fore(t,i,type)                    Forestry costs (Mio USD)
 ov_landdiff_forestry(t,type)              Aggregated difference in forestry land compared to previous timestep (mio. ha)
 ov32_land(t,j,type32,ac,type)             Forestry land pools (mio. ha)
 ov_cdr_aff(t,j,ac,aff_effect,type)        Expected bgc (CDR) and local bph effects of afforestation depending on planning horizon (mio. tC)
 ov_forestry_reduction(t,j,type32,ac,type) Reduction of forestry land (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
