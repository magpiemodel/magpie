*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 i42_wat_req_k(t,j,k)       	     LPJ annual water demand for irrigation per ha per year (m^3) + Livestock demand per ton (m^3)
 ic42_wat_req_k(j,k)        	     LPJ annual water demand for irrigation per ha per year (m^3) + Livestock demand per ton (m^3)
 i42_env_flows(t,j)                  environmental flow requirements if a protection policy is in place (mio m^3)
 i42_env_flows_base(t,j)    	     environmental flow requirements if no protection policy is in place  (mio m^3)
 ic42_env_flow_policy(i)             Determines if environmental flow protection is enforced in the current time step (logical)
 i42_env_flow_policy(t,i)            Determines if environmental flow protection is enforced (logical)
;

equations
 q42_water_demand(wat_dem,j)         Water consumption in different sectors
;

positive variables
  vm_watdem(wat_dem,j)               Water needed in different sectors (mio m^3)
  v42_irrig_eff(j)                   Irrigation efficiency
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_watdem(t,wat_dem,j,type)         Water needed in different sectors (mio m^3)
 ov42_irrig_eff(t,j,type)            Irrigation efficiency
 oq42_water_demand(t,wat_dem,j,type) Water consumption in different sectors
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
