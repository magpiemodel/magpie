*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_glo(t,"marginal")     = vm_cost_glo.m;
 ov_cost_reg(t,i,"marginal")   = vm_cost_reg.m(i);
 oq11_cost_glo(t,"marginal")   = q11_cost_glo.m;
 oq11_cost_reg(t,i,"marginal") = q11_cost_reg.m(i);
 ov_cost_glo(t,"level")        = vm_cost_glo.l;
 ov_cost_reg(t,i,"level")      = vm_cost_reg.l(i);
 oq11_cost_glo(t,"level")      = q11_cost_glo.l;
 oq11_cost_reg(t,i,"level")    = q11_cost_reg.l(i);
 ov_cost_glo(t,"upper")        = vm_cost_glo.up;
 ov_cost_reg(t,i,"upper")      = vm_cost_reg.up(i);
 oq11_cost_glo(t,"upper")      = q11_cost_glo.up;
 oq11_cost_reg(t,i,"upper")    = q11_cost_reg.up(i);
 ov_cost_glo(t,"lower")        = vm_cost_glo.lo;
 ov_cost_reg(t,i,"lower")      = vm_cost_reg.lo(i);
 oq11_cost_glo(t,"lower")      = q11_cost_glo.lo;
 oq11_cost_reg(t,i,"lower")    = q11_cost_reg.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

