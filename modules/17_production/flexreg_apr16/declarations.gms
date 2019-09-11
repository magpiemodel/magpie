*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_prod(j,k)                    Production in each cell (mio. tDM per yr)
 vm_prod_reg(i,kall)             Regional aggregated production (mio. tDM per yr)
;

equations
 q17_prod_reg(i,k)               Regional production (mio. tDM per yr)
 q17_prod_cell_timber(j,kforestry)           xx
* q17_prod_cell_woodfuel(j)       xx
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_prod(t,j,k,type)                       Production in each cell (mio. tDM per yr)
 ov_prod_reg(t,i,kall,type)                Regional aggregated production (mio. tDM per yr)
 oq17_prod_reg(t,i,k,type)                 Regional production (mio. tDM per yr)
 oq17_prod_cell_timber(t,j,kforestry,type) xx
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
