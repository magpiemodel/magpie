*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_cost_fore(i)                          Afforestation costs (mio. USD04MER)
 vm_landdiff_forestry                     Aggregated difference in forestry land compared to previous timestep (mio. ha)
 v32_land(j,land32)                       Forestry land pools (mio. ha)
 vm_cdr_aff(j,co2_forestry)   Total CDR from afforestation (new and existing areas) between t+1 and t=s32_planing_horizon (mio. tC)
;

parameters
 pc32_carbon_density(j,c_pools)           Carbon density in optimization (tC per ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_fore(t,i,type)            Afforestation costs (mio. USD04MER)
 ov_landdiff_forestry(t,type)      Aggregated difference in forestry land compared to previous timestep (mio. ha)
 ov32_land(t,j,land32,type)        Forestry land pools (mio. ha)
 ov_cdr_aff(t,j,co2_forestry,type) Total CDR from afforestation (new and existing areas) between t+1 and t=s32_planing_horizon (mio. tC)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
