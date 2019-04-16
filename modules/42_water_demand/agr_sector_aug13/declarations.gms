*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 i42_wat_req_k(t,j,k)       	     LPJmL annual water demand for irrigation per ha per year (m^3) + Livestock demand per ton (m^3)
 ic42_wat_req_k(j,k)        	     LPJmL annual water demand for irrigation per ha per year (m^3) + Livestock demand per ton (m^3)
 i42_env_flows(t,j)                  Environmental flow requirements if a protection policy is in place (mio. m^3)
 i42_env_flows_base(t,j)    	     Environmental flow requirements if no protection policy is in place  (mio. m^3)
 ic42_env_flow_policy(i)             Determines whether environmental flow protection is enforced in the current time step (1)
 i42_env_flow_policy(t,i)            Determines whether environmental flow protection is enforced (1)
;

equations
 q42_water_demand(wat_dem,j)         Water consumption in different sectors (mio. m^3 per yr)
;

positive variables
  vm_watdem(wat_dem,j)               Water demand from different sectors (mio. m^3 per yr)
  v42_irrig_eff(j)                   Irrigation efficiency (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_watdem(t,wat_dem,j,type)         Water demand from different sectors (mio. m^3 per yr)
 ov42_irrig_eff(t,j,type)            Irrigation efficiency (1)
 oq42_water_demand(t,wat_dem,j,type) Water consumption in different sectors (mio. m^3 per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
