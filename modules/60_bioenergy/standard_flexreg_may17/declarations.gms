*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


parameters
 i60_bioenergy_dem(t,i)   			Regional bioenergy demand per year (mio. GJ per yr)
 i60_res_2ndgenBE_dem(t,i)			Regional residue demand for 2nd generation bioenergy per year (mio. GJ per yr)
;

positive variables
 vm_dem_bioen(i,kall)               Regional bioenergy demand  (mio. tDM per yr)
;

equations
 q60_bioenergy_glo                 	Global bioenergy demand (mio. GJ per yr)
 q60_bioenergy_reg(i)              	Regional bioenergy demand (mio. GJ per yr)
 q60_res_2ndgenBE(i)       			Regional residue demand for 2nd generation bioenergy (mio. GJ per yr) 
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_bioen(t,i,kall,type)  Regional bioenergy demand  (mio. tDM per yr)
 oq60_bioenergy_glo(t,type)   Global bioenergy demand (mio. GJ per yr)
 oq60_bioenergy_reg(t,i,type) Regional bioenergy demand (mio. GJ per yr)
 oq60_res_2ndgenBE(t,i,type)  Regional residue demand for 2nd generation bioenergy (mio. GJ per yr) 
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
