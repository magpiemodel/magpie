*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_cdr(t,i,"marginal") = vm_cost_cdr.m(i);
 ov_cost_cdr(t,i,"level")    = vm_cost_cdr.l(i);
 ov_cost_cdr(t,i,"upper")    = vm_cost_cdr.up(i);
 ov_cost_cdr(t,i,"lower")    = vm_cost_cdr.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

