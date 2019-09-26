*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
 q27_prod_timber(j,kforestry)             Cellular timber production constraint (mio. m3 per yr)
* q27_prod_timber_reg(i,kforestry)         Regional timber production constraint (mio. m3 per yr)
* q27_prod_forestry_ratio                  Global forestry production constraint (mio. m3 per yr)
* q27_prod_natveg_ratio                    Global natveg production constraint (mio. m3 per yr)
;


positive variables
 vm_prod_heaven_timber(j,kforestry)          Production from heaven in each cell (mio. m3 per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_prod_heaven_timber(t,j,kforestry,type) Production from heaven in each cell (mio. m3 per yr)
 oq27_prod_timber(t,j,kforestry,type)      Cellular timber production constraint (mio. m3 per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
