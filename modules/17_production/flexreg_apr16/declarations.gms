*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_prod(j,k)                    Production in each cell (mio. tDM per yr)
 vm_prod_reg(i,kall)             Regional aggregated production (mio. tDM per yr)
 vm_prod_forestry(j,kforestry)	xx
 vm_prod_natveg(j,kforestry)   	xx
;

equations
 q17_prod_reg(i,k)               Regional production (mio. tDM per yr)
 
q17_prod_timber(j)				 Production of timber (xx)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_prod(t,j,k,type)                  Production in each cell (mio. tDM per yr)
 ov_prod_reg(t,i,kall,type)           Regional aggregated production (mio. tDM per yr)
 ov_prod_forestry(t,j,kforestry,type) xx
 ov_prod_natveg(t,j,kforestry,type)   xx
 oq17_prod_reg(t,i,k,type)            Regional production (mio. tDM per yr)
 oq17_prod_timber(t,j,type)           Production of timber (xx)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

