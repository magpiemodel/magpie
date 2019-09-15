*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_prod(t,j,k,"marginal")                       = vm_prod.m(j,k);
 ov_prod_reg(t,i,kall,"marginal")                = vm_prod_reg.m(i,kall);
 ov_prod_heaven_timber(t,j,kforestry,"marginal") = vm_prod_heaven_timber.m(j,kforestry);
 oq17_prod_reg(t,i,k,"marginal")                 = q17_prod_reg.m(i,k);
 oq17_prod_glo_timber(t,j,kforestry,"marginal")  = q17_prod_glo_timber.m(j,kforestry);
 ov_prod(t,j,k,"level")                          = vm_prod.l(j,k);
 ov_prod_reg(t,i,kall,"level")                   = vm_prod_reg.l(i,kall);
 ov_prod_heaven_timber(t,j,kforestry,"level")    = vm_prod_heaven_timber.l(j,kforestry);
 oq17_prod_reg(t,i,k,"level")                    = q17_prod_reg.l(i,k);
 oq17_prod_glo_timber(t,j,kforestry,"level")     = q17_prod_glo_timber.l(j,kforestry);
 ov_prod(t,j,k,"upper")                          = vm_prod.up(j,k);
 ov_prod_reg(t,i,kall,"upper")                   = vm_prod_reg.up(i,kall);
 ov_prod_heaven_timber(t,j,kforestry,"upper")    = vm_prod_heaven_timber.up(j,kforestry);
 oq17_prod_reg(t,i,k,"upper")                    = q17_prod_reg.up(i,k);
 oq17_prod_glo_timber(t,j,kforestry,"upper")     = q17_prod_glo_timber.up(j,kforestry);
 ov_prod(t,j,k,"lower")                          = vm_prod.lo(j,k);
 ov_prod_reg(t,i,kall,"lower")                   = vm_prod_reg.lo(i,kall);
 ov_prod_heaven_timber(t,j,kforestry,"lower")    = vm_prod_heaven_timber.lo(j,kforestry);
 oq17_prod_reg(t,i,k,"lower")                    = q17_prod_reg.lo(i,k);
 oq17_prod_glo_timber(t,j,kforestry,"lower")     = q17_prod_glo_timber.lo(j,kforestry);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
