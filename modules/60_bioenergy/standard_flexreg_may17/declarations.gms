*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


parameters
 i60_bioenergy_dem(t,i)   			regional bioenergy demand per year (10^6 GJ)
 i60_res_2ndgenBE_dem(t,i)				regional residue demand for 2nd generation bioenergy per year (10^6 GJ)
;

variables
 vm_cost_bioen(i)                   regional bioenergy production costs (mio. USD)
;

positive variables
 vm_dem_bioen(i,kall)               regional bioenergy demand  (mio. tDM)
;

equations
 q60_bioenergy_glo                 global bioenergy demand (10^6 GJ)
 q60_bioenergy_reg(i)              regional bioenergy demand (10^6 GJ)
 q60_res_2ndgenBE(i)             regional residue demand for 2nd generation bioenergy (10^6 GJ) 
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_bioen(t,i,type)      regional bioenergy production costs (mio. USD)
 ov_dem_bioen(t,i,kall,type)  regional bioenergy demand  (mio. tDM)
 oq60_bioenergy_glo(t,type)   global bioenergy demand (10^6 GJ)
 oq60_bioenergy_reg(t,i,type) regional bioenergy demand (10^6 GJ)
 oq60_res_2ndgenBE(t,i,type)  regional residue demand for 2nd generation bioenergy (10^6 GJ) 
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
