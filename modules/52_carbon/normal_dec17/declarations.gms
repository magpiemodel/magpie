*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

variables
 vm_carbon_stock_change(j,land,c_pools)	Change in carbon stocks compared to previous time step (mio. tC per time step)
;

positive variables
 vm_carbon_stock(j,land,c_pools)        	Carbon stock in vegetation soil and litter for different land types (mio. tC)
;

parameters
 pm_carbon_density_ac(t_all,j,ac,ag_pools)    		Above ground natveg carbon density for age classes and carbon pools (tC per ha)
 pm_carbon_density_ac_forestry(t_all,j,ac,ag_pools)    Above ground plantation carbon density for age classes and carbon pools (tC per ha)
 pc52_carbon_density_start(t_all,j,ag_pools)  Above ground carbon density for new land in other land pool (tC per ha)
 pcm_carbon_stock(j,land,c_pools)         Current carbon in vegetation soil and litter for different land types (mio. tC)
;

equations
 q52_carbon_stock_change(j,land,c_pools) Calculation carbon stock reduction (mio. tC per time step)
 q52_co2c_emis(j,emis_co2)             		 Calculation of annual CO2 emissions (mio. tC per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_carbon_stock_change(t,j,land,c_pools,type)   Change in carbon stocks compared to previous time step (mio. tC per time step)
 ov_carbon_stock(t,j,land,c_pools,type)          Carbon stock in vegetation soil and litter for different land types (mio. tC)
 oq52_carbon_stock_change(t,j,land,c_pools,type) Calculation carbon stock reduction (mio. tC per time step)
 oq52_co2c_emis(t,j,emis_co2,type)               Calculation of annual CO2 emissions (mio. tC per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
