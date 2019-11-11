*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_prod_heaven_timber(t,j,kforestry,"marginal")        = vm_prod_heaven_timber.m(j,kforestry);
 oq27_prod_timber(t,j,kforestry,"marginal")             = q27_prod_timber.m(j,kforestry);
 oq27_prod_timber_plantations(t,i,kforestry,"marginal") = q27_prod_timber_plantations.m(i,kforestry);
 oq27_prod_timber_natveg(t,i,kforestry,"marginal")      = q27_prod_timber_natveg.m(i,kforestry);
 ov_prod_heaven_timber(t,j,kforestry,"level")           = vm_prod_heaven_timber.l(j,kforestry);
 oq27_prod_timber(t,j,kforestry,"level")                = q27_prod_timber.l(j,kforestry);
 oq27_prod_timber_plantations(t,i,kforestry,"level")    = q27_prod_timber_plantations.l(i,kforestry);
 oq27_prod_timber_natveg(t,i,kforestry,"level")         = q27_prod_timber_natveg.l(i,kforestry);
 ov_prod_heaven_timber(t,j,kforestry,"upper")           = vm_prod_heaven_timber.up(j,kforestry);
 oq27_prod_timber(t,j,kforestry,"upper")                = q27_prod_timber.up(j,kforestry);
 oq27_prod_timber_plantations(t,i,kforestry,"upper")    = q27_prod_timber_plantations.up(i,kforestry);
 oq27_prod_timber_natveg(t,i,kforestry,"upper")         = q27_prod_timber_natveg.up(i,kforestry);
 ov_prod_heaven_timber(t,j,kforestry,"lower")           = vm_prod_heaven_timber.lo(j,kforestry);
 oq27_prod_timber(t,j,kforestry,"lower")                = q27_prod_timber.lo(j,kforestry);
 oq27_prod_timber_plantations(t,i,kforestry,"lower")    = q27_prod_timber_plantations.lo(i,kforestry);
 oq27_prod_timber_natveg(t,i,kforestry,"lower")         = q27_prod_timber_natveg.lo(i,kforestry);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

*** EOF postsolve.gms ***
