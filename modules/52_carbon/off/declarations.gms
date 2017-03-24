*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

* Here you can put your additional declarations
parameters
 pm_carbon_density_ac(t,j,ac,c_pools)  carbon density for ac and c_pools (tC per ha)
 pcm_carbon_stock(j,land,c_pools)     current carbon in vegetation soil and litter for different land types (Mio tC)
;

positive variables
 vm_carbon_stock(j,land,c_pools)             carbon in vegetation soil and litter for different land types (Mio tC)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_carbon_stock(t,j,land,c_pools,type) carbon in vegetation soil and litter for different land types (Mio tC)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
