*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_prod(t,j,k,"marginal")               = vm_prod.m(j,k);
 ov_prod_reg(t,i,kall,"marginal")        = vm_prod_reg.m(i,kall);
 oq17_prod_reg(t,i,k,"marginal")         = q17_prod_reg.m(i,k);
 oq17_prod_cell_wood(t,j,"marginal")     = q17_prod_cell_wood.m(j);
 oq17_prod_cell_woodfuel(t,j,"marginal") = q17_prod_cell_woodfuel.m(j);
 ov_prod(t,j,k,"level")                  = vm_prod.l(j,k);
 ov_prod_reg(t,i,kall,"level")           = vm_prod_reg.l(i,kall);
 oq17_prod_reg(t,i,k,"level")            = q17_prod_reg.l(i,k);
 oq17_prod_cell_wood(t,j,"level")        = q17_prod_cell_wood.l(j);
 oq17_prod_cell_woodfuel(t,j,"level")    = q17_prod_cell_woodfuel.l(j);
 ov_prod(t,j,k,"upper")                  = vm_prod.up(j,k);
 ov_prod_reg(t,i,kall,"upper")           = vm_prod_reg.up(i,kall);
 oq17_prod_reg(t,i,k,"upper")            = q17_prod_reg.up(i,k);
 oq17_prod_cell_wood(t,j,"upper")        = q17_prod_cell_wood.up(j);
 oq17_prod_cell_woodfuel(t,j,"upper")    = q17_prod_cell_woodfuel.up(j);
 ov_prod(t,j,k,"lower")                  = vm_prod.lo(j,k);
 ov_prod_reg(t,i,kall,"lower")           = vm_prod_reg.lo(i,kall);
 oq17_prod_reg(t,i,k,"lower")            = q17_prod_reg.lo(i,k);
 oq17_prod_cell_wood(t,j,"lower")        = q17_prod_cell_wood.lo(j);
 oq17_prod_cell_woodfuel(t,j,"lower")    = q17_prod_cell_woodfuel.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
