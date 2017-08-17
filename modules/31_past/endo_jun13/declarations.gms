*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


equations
 q31_prod(j)              cellular pasture production constraint
 q31_carbon(j,c_pools)    carbon content calculation for pasture
 q31_cost_prod_past(i) costs for putting animals on pastures
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq31_prod(t,j,type)              cellular pasture production constraint
 oq31_carbon(t,j,c_pools,type)    carbon content calculation for pasture
 oq31_cost_prod_pasture(t,i,type) costs for putting animals on pastures
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
