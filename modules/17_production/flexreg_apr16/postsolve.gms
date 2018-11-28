*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_prod(t,j,k,"marginal")                  = vm_prod.m(j,k);
 ov_prod_reg(t,i,kall,"marginal")           = vm_prod_reg.m(i,kall);
 ov_prod_forestry(t,j,kforestry,"marginal") = vm_prod_forestry.m(j,kforestry);
 ov_prod_natveg(t,j,kforestry,"marginal")   = vm_prod_natveg.m(j,kforestry);
 oq17_prod_reg(t,i,k,"marginal")            = q17_prod_reg.m(i,k);
 oq17_prod_timber(t,j,"marginal")           = q17_prod_timber.m(j);
 ov_prod(t,j,k,"level")                     = vm_prod.l(j,k);
 ov_prod_reg(t,i,kall,"level")              = vm_prod_reg.l(i,kall);
 ov_prod_forestry(t,j,kforestry,"level")    = vm_prod_forestry.l(j,kforestry);
 ov_prod_natveg(t,j,kforestry,"level")      = vm_prod_natveg.l(j,kforestry);
 oq17_prod_reg(t,i,k,"level")               = q17_prod_reg.l(i,k);
 oq17_prod_timber(t,j,"level")              = q17_prod_timber.l(j);
 ov_prod(t,j,k,"upper")                     = vm_prod.up(j,k);
 ov_prod_reg(t,i,kall,"upper")              = vm_prod_reg.up(i,kall);
 ov_prod_forestry(t,j,kforestry,"upper")    = vm_prod_forestry.up(j,kforestry);
 ov_prod_natveg(t,j,kforestry,"upper")      = vm_prod_natveg.up(j,kforestry);
 oq17_prod_reg(t,i,k,"upper")               = q17_prod_reg.up(i,k);
 oq17_prod_timber(t,j,"upper")              = q17_prod_timber.up(j);
 ov_prod(t,j,k,"lower")                     = vm_prod.lo(j,k);
 ov_prod_reg(t,i,kall,"lower")              = vm_prod_reg.lo(i,kall);
 ov_prod_forestry(t,j,kforestry,"lower")    = vm_prod_forestry.lo(j,kforestry);
 ov_prod_natveg(t,j,kforestry,"lower")      = vm_prod_natveg.lo(j,kforestry);
 oq17_prod_reg(t,i,k,"lower")               = q17_prod_reg.lo(i,k);
 oq17_prod_timber(t,j,"lower")              = q17_prod_timber.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

