*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_transp(t,j,k,"marginal") = vm_cost_transp.m(j,k);
 ov_cost_transp(t,j,k,"level")    = vm_cost_transp.l(j,k);
 ov_cost_transp(t,j,k,"upper")    = vm_cost_transp.up(j,k);
 ov_cost_transp(t,j,k,"lower")    = vm_cost_transp.lo(j,k);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

