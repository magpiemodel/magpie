*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_prod(j,k)                    Production in each cell (mio. tDM per yr)
 vm_prod_reg(i,kall)             Regional aggregated production (mio. tDM per yr)
;

equations
 q17_prod_reg(i,k)               Regional production (mio. tDM per yr)
;

parameters
pm_prod_init(j,kcr)               Production initialization for year 1995 (tDM per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_prod(t,j,k,type)        Production in each cell (mio. tDM per yr)
 ov_prod_reg(t,i,kall,type) Regional aggregated production (mio. tDM per yr)
 oq17_prod_reg(t,i,k,type)  Regional production (mio. tDM per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
