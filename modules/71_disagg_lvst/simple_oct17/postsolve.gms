*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov71_prod_in(t,j,kli_rum,"marginal")      = v71_prod_in.m(j,kli_rum);
 ov71_prod_ex(t,j,kli_rum,"marginal")      = v71_prod_ex.m(j,kli_rum);
 oq71_prod_in(t,j,kli_rum,"marginal")      = q71_prod_in.m(j,kli_rum);
 oq71_prod_ex(t,j,kli_rum,"marginal")      = q71_prod_ex.m(j,kli_rum);
 oq71_prod_reg_ex(t,i,kli_rum,"marginal")  = q71_prod_reg_ex.m(i,kli_rum);
 oq71_prod_rum_liv(t,j,kli_rum,"marginal") = q71_prod_rum_liv.m(j,kli_rum);
 oq71_prod_mon_liv(t,j,kli_mon,"marginal") = q71_prod_mon_liv.m(j,kli_mon);
 ov71_prod_in(t,j,kli_rum,"level")         = v71_prod_in.l(j,kli_rum);
 ov71_prod_ex(t,j,kli_rum,"level")         = v71_prod_ex.l(j,kli_rum);
 oq71_prod_in(t,j,kli_rum,"level")         = q71_prod_in.l(j,kli_rum);
 oq71_prod_ex(t,j,kli_rum,"level")         = q71_prod_ex.l(j,kli_rum);
 oq71_prod_reg_ex(t,i,kli_rum,"level")     = q71_prod_reg_ex.l(i,kli_rum);
 oq71_prod_rum_liv(t,j,kli_rum,"level")    = q71_prod_rum_liv.l(j,kli_rum);
 oq71_prod_mon_liv(t,j,kli_mon,"level")    = q71_prod_mon_liv.l(j,kli_mon);
 ov71_prod_in(t,j,kli_rum,"upper")         = v71_prod_in.up(j,kli_rum);
 ov71_prod_ex(t,j,kli_rum,"upper")         = v71_prod_ex.up(j,kli_rum);
 oq71_prod_in(t,j,kli_rum,"upper")         = q71_prod_in.up(j,kli_rum);
 oq71_prod_ex(t,j,kli_rum,"upper")         = q71_prod_ex.up(j,kli_rum);
 oq71_prod_reg_ex(t,i,kli_rum,"upper")     = q71_prod_reg_ex.up(i,kli_rum);
 oq71_prod_rum_liv(t,j,kli_rum,"upper")    = q71_prod_rum_liv.up(j,kli_rum);
 oq71_prod_mon_liv(t,j,kli_mon,"upper")    = q71_prod_mon_liv.up(j,kli_mon);
 ov71_prod_in(t,j,kli_rum,"lower")         = v71_prod_in.lo(j,kli_rum);
 ov71_prod_ex(t,j,kli_rum,"lower")         = v71_prod_ex.lo(j,kli_rum);
 oq71_prod_in(t,j,kli_rum,"lower")         = q71_prod_in.lo(j,kli_rum);
 oq71_prod_ex(t,j,kli_rum,"lower")         = q71_prod_ex.lo(j,kli_rum);
 oq71_prod_reg_ex(t,i,kli_rum,"lower")     = q71_prod_reg_ex.lo(i,kli_rum);
 oq71_prod_rum_liv(t,j,kli_rum,"lower")    = q71_prod_rum_liv.lo(j,kli_rum);
 oq71_prod_mon_liv(t,j,kli_mon,"lower")    = q71_prod_mon_liv.lo(j,kli_mon);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
