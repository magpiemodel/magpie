*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_tau(t,i,"marginal")       = vm_tau.m(i);
 ov_tech_cost(t,i,"marginal") = vm_tech_cost.m(i);
 ov_tau(t,i,"level")          = vm_tau.l(i);
 ov_tech_cost(t,i,"level")    = vm_tech_cost.l(i);
 ov_tau(t,i,"upper")          = vm_tau.up(i);
 ov_tech_cost(t,i,"upper")    = vm_tech_cost.up(i);
 ov_tau(t,i,"lower")          = vm_tau.lo(i);
 ov_tech_cost(t,i,"lower")    = vm_tech_cost.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

