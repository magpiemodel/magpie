*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_prod(j,k)                    production in each cell (mio. tDM)
 vm_prod_reg(i,kall)                regional aggregated production (mio. tDM)
;

equations
 q17_prod_reg(i,k)               regional production
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_prod(t,j,k,type)        production in each cell (mio. tDM)
 ov_prod_reg(t,i,kall,type) regional aggregated production (mio. tDM)
 oq17_prod_reg(t,i,k,type)  regional production
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

