*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_maccs_costs(t,i,"marginal") = vm_maccs_costs.m(i);
 ov_maccs_costs(t,i,"level")    = vm_maccs_costs.l(i);
 ov_maccs_costs(t,i,"upper")    = vm_maccs_costs.up(i);
 ov_maccs_costs(t,i,"lower")    = vm_maccs_costs.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
