*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

positive variables
 vm_cost_fore(i)                             Afforestation costs (Mio US$)
 vm_landdiff_forestry             aggregated difference in forestry land compared to previous timestep (mio. ha)
 v32_land(j,land32,si)              forestry land pools (mio. ha)
 vm_cdr_aff(j,emis_source_co2_forestry)                             total CDR from afforestation (new and existing areas) between t+1 and t=sm_invest_horizon (Tg CO2-C)
;

parameters
 pc32_carbon_density(j,c_pools) carbon density in optimization (tC per ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_fore(t,i,type)                        Afforestation costs (Mio US$)
 ov_landdiff_forestry(t,type)                  aggregated difference in forestry land compared to previous timestep (mio. ha)
 ov32_land(t,j,land32,si,type)                 forestry land pools (mio. ha)
 ov_cdr_aff(t,j,emis_source_co2_forestry,type) total CDR from afforestation (new and existing areas) between t+1 and t=sm_invest_horizon (Tg CO2-C)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
