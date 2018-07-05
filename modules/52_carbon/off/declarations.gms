*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

* Here you can put your additional declarations
parameters
 pm_carbon_density_ac(t,j,ac,c_pools)  carbon density for ac and c_pools (tC per ha)
 pc52_carbon_stock(j,land,c_pools)     current carbon in vegetation soil and litter for different land types (mio tC)
;

positive variables
 vm_carbon_stock(j,land,c_pools)             carbon in vegetation soil and litter for different land types (mio tC)
 vm_carbon_stock_reduction(j,land,c_pools)	reduction in carbon stocks compared to previous time step (mio tC per time step)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_carbon_stock(t,j,land,c_pools,type)           carbon in vegetation soil and litter for different land types (mio tC)
 ov_carbon_stock_reduction(t,j,land,c_pools,type) reduction in carbon stocks compared to previous time step (mio tC)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
