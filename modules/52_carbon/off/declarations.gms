*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Here you can put your additional declarations
parameters
 pm_carbon_density_ac(t,j,ac,ag_pools)    		Above ground natveg carbon density for age classes and carbon pools (tC per ha)
 pm_carbon_density_ac_forestry(t,j,ac,ag_pools)    Above ground plantation carbon density for age classes and carbon pools (tC per ha)
 pcm_carbon_stock(j,land,c_pools)           Current carbon in vegetation soil and litter for different land types (mio tC)
 pm_investment_layer(t_all,j)             Difference between needed and observed LPJmL carbon densities in clusters where LPJmL values area lower than a threshold (tC per ha)
;

positive variables
 vm_carbon_stock(j,land,c_pools)            Carbon in vegetation soil and litter for different land types (mio tC)
 vm_carbon_stock_reduction(j,land,c_pools)	Reduction in carbon stocks compared to previous time step (mio tC per time step)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_carbon_stock(t,j,land,c_pools,type)           Carbon in vegetation soil and litter for different land types (mio tC)
 ov_carbon_stock_reduction(t,j,land,c_pools,type) Reduction in carbon stocks compared to previous time step (mio tC per time step)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
