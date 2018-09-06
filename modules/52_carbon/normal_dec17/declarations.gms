*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

variables
 v52_carbon_stock_diff(j,land,c_pools)  change in carbon stocks compared to previous time step (mio tC per time step)
;

positive variables
 vm_carbon_stock(j,land,c_pools)        	carbon stock in vegetation soil and litter for different land types (mio tC)
 vm_carbon_stock_reduction(j,land,c_pools)	reduction in carbon stocks compared to previous time step (mio tC per time step)
;

parameters
 pm_carbon_density_ac(t,j,ac,c_pools)  carbon density for ac and c_pools (tC per ha)
 pc52_carbon_stock(j,land,c_pools)     current carbon in vegetation soil and litter for different land types (mio tC)
 pc52_carbon_density_start(t,j,c_pools)  carbon density for new land in other (tC per ha)
;

equations
 q52_carbon_stock_diff(j,land,c_pools) calculation net carbon stock change (mio tC per time step)
 q52_carbon_stock_reduction(j,land,c_pools) calculation carbon stock reduction (mio tC per time step)
 q52_co2c_emis(j,emis_co2)             		 calculation of annual CO2 emissions (mio tC per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov52_carbon_stock_diff(t,j,land,c_pools,type)      change in carbon stocks compared to previous time step (mio tC per time step)
 ov_carbon_stock(t,j,land,c_pools,type)             carbon stock in vegetation soil and litter for different land types (mio tC)
 ov_carbon_stock_reduction(t,j,land,c_pools,type)   reduction in carbon stocks compared to previous time step (mio tC per time step)
 oq52_carbon_stock_diff(t,j,land,c_pools,type)      calculation net carbon stock change (mio tC per time step)
 oq52_carbon_stock_reduction(t,j,land,c_pools,type) calculation carbon stock reduction (mio tC per time step)
 oq52_co2c_emis(t,j,emis_co2,type)                  calculation of annual CO2 emissions (mio tC per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
