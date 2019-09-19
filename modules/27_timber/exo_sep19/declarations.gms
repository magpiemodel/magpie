*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
 q27_prod_timber(j,kforestry)             Cellular timber production constraint (mio. m3 per yr)
 q27_prod_timber_forestry(j,kforestry)    Cellular forestry production constraint (mio. m3 per yr)
 q27_prod_timber_natveg(j,kforestry)      Cellular natveg production constraint (mio. m3 per yr)
 q27_prod_woodfuel_forestry(i)  Regional woodfuel production from plantations (mio. m3 per yr)
;

positive variables
 v27_prod_timber(j,timber_source,kforestry)  Production of timber in each cell (mio. m3 per yr)
 vm_prod_heaven_timber(j,kforestry)          Production from heaven in each cell (mio. m3 per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov27_prod_timber(t,j,timber_source,kforestry,type) Production of timber in each cell (mio. m3 per yr)
 ov_prod_heaven_timber(t,j,kforestry,type)          Production from heaven in each cell (mio. m3 per yr)
 oq27_prod_timber(t,j,kforestry,type)               Cellular timber production constraint (mio. m3 per yr)
 oq27_prod_timber_forestry(t,j,kforestry,type)      Cellular forestry production constraint (mio. m3 per yr)
 oq27_prod_timber_natveg(t,j,kforestry,type)        Cellular natveg production constraint (mio. m3 per yr)
 oq27_prod_woodfuel_forestry(t,i,type)              Regional woodfuel production from plantations (mio. m3 per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
