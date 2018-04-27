*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


parameters
 i60_bioenergy_dem(t,i)   			Regional bioenergy demand per year (10^6 GJ)
;

variables
 vm_cost_bioen(i)                   negative bioenergy production costs = revenue (mio. USD)
;

positive variables
 vm_dem_bioen(i,kall)               regional bioenergy demand  (mio. tDM)
;

equations
 q60_bioenergy_glo                 global bioenergy demand
 q60_bioenergy_reg(i)              regional bioenergy demand
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_bioen(t,i,type)      negative bioenergy production costs = revenue (mio. USD)
 ov_dem_bioen(t,i,kall,type)  regional bioenergy demand  (mio. tDM)
 oq60_bioenergy_glo(t,type)   global bioenergy demand
 oq60_bioenergy_reg(t,i,type) regional bioenergy demand
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
