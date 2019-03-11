*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

* Here you can put your additional declarations
parameters
 pm_carbon_density_ac(t,j,ac,c_pools)  Carbon density for ac and c_pools (tC per ha)
 pcm_carbon_stock(j,land,c_pools)     Current carbon in vegetation soil and litter for different land types (mio tC)
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
