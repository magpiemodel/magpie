*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov27_prod_timber(t,j,timber_source,kforestry,"marginal") = v27_prod_timber.m(j,timber_source,kforestry);
 ov_prod_heaven_timber(t,j,kforestry,"marginal")          = vm_prod_heaven_timber.m(j,kforestry);
 oq27_prod_timber(t,j,kforestry,"marginal")               = q27_prod_timber.m(j,kforestry);
 oq27_prod_timber_forestry(t,j,kforestry,"marginal")      = q27_prod_timber_forestry.m(j,kforestry);
 oq27_prod_timber_natveg(t,j,kforestry,"marginal")        = q27_prod_timber_natveg.m(j,kforestry);
 oq27_prod_woodfuel_forestry(t,i,"marginal")              = q27_prod_woodfuel_forestry.m(i);
 oq27_prod_woodfuel_natveg(t,i,"marginal")                = q27_prod_woodfuel_natveg.m(i);
 ov27_prod_timber(t,j,timber_source,kforestry,"level")    = v27_prod_timber.l(j,timber_source,kforestry);
 ov_prod_heaven_timber(t,j,kforestry,"level")             = vm_prod_heaven_timber.l(j,kforestry);
 oq27_prod_timber(t,j,kforestry,"level")                  = q27_prod_timber.l(j,kforestry);
 oq27_prod_timber_forestry(t,j,kforestry,"level")         = q27_prod_timber_forestry.l(j,kforestry);
 oq27_prod_timber_natveg(t,j,kforestry,"level")           = q27_prod_timber_natveg.l(j,kforestry);
 oq27_prod_woodfuel_forestry(t,i,"level")                 = q27_prod_woodfuel_forestry.l(i);
 oq27_prod_woodfuel_natveg(t,i,"level")                   = q27_prod_woodfuel_natveg.l(i);
 ov27_prod_timber(t,j,timber_source,kforestry,"upper")    = v27_prod_timber.up(j,timber_source,kforestry);
 ov_prod_heaven_timber(t,j,kforestry,"upper")             = vm_prod_heaven_timber.up(j,kforestry);
 oq27_prod_timber(t,j,kforestry,"upper")                  = q27_prod_timber.up(j,kforestry);
 oq27_prod_timber_forestry(t,j,kforestry,"upper")         = q27_prod_timber_forestry.up(j,kforestry);
 oq27_prod_timber_natveg(t,j,kforestry,"upper")           = q27_prod_timber_natveg.up(j,kforestry);
 oq27_prod_woodfuel_forestry(t,i,"upper")                 = q27_prod_woodfuel_forestry.up(i);
 oq27_prod_woodfuel_natveg(t,i,"upper")                   = q27_prod_woodfuel_natveg.up(i);
 ov27_prod_timber(t,j,timber_source,kforestry,"lower")    = v27_prod_timber.lo(j,timber_source,kforestry);
 ov_prod_heaven_timber(t,j,kforestry,"lower")             = vm_prod_heaven_timber.lo(j,kforestry);
 oq27_prod_timber(t,j,kforestry,"lower")                  = q27_prod_timber.lo(j,kforestry);
 oq27_prod_timber_forestry(t,j,kforestry,"lower")         = q27_prod_timber_forestry.lo(j,kforestry);
 oq27_prod_timber_natveg(t,j,kforestry,"lower")           = q27_prod_timber_natveg.lo(j,kforestry);
 oq27_prod_woodfuel_forestry(t,i,"lower")                 = q27_prod_woodfuel_forestry.lo(i);
 oq27_prod_woodfuel_natveg(t,i,"lower")                   = q27_prod_woodfuel_natveg.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

*** EOF postsolve.gms ***
