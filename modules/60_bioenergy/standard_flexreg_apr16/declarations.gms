*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


parameters
 i60_bioenergy_dem(t,i)   bioenergy demand (regional) (10^6 GJ per year)
;

variables
 vm_cost_bioen(i)                   negative bioenergy production costs = revenue (mio. US$)
;

positive variables
 vm_dem_bioen(i,kall)               regional bioenergy demand  (mio. ton DM)
;

equations
 q60_bioenergy_glo                 global bioenergy demand
 q60_bioenergy_reg(i)              regional bioenergy demand
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_bioen(t,i,type)      negative bioenergy production costs = revenue (mio. US$)
 ov_dem_bioen(t,i,kall,type)  regional bioenergy demand  (mio. ton DM)
 oq60_bioenergy_glo(t,type)   global bioenergy demand
 oq60_bioenergy_reg(t,i,type) regional bioenergy demand
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
