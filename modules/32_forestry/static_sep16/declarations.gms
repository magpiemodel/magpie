*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_cost_fore(i)                 Afforestation costs (mio. USD04MER per yr)
 vm_landdiff_forestry            Aggregated difference in forestry land compared to previous timestep (mio. ha)
 vm_land_fore(j,type32,ac)           Forestry land pools (mio. ha)
 vm_cdr_aff(j,ac)   	         Expected CDR from afforestation depending on planning horizon (mio. tC)
;

parameters
 pc32_carbon_density(j,ag_pools) Above ground carbon density in optimization (tC per ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_fore(t,i,type)           Afforestation costs (mio. USD04MER per yr)
 ov_landdiff_forestry(t,type)     Aggregated difference in forestry land compared to previous timestep (mio. ha)
 ov_land_fore(t,j,type32,ac,type) Forestry land pools (mio. ha)
 ov_cdr_aff(t,j,ac,type)          Expected CDR from afforestation depending on planning horizon (mio. tC)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
