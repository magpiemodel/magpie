*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_p_fert_costs(t,i,"marginal") = vm_p_fert_costs.m(i);
 ov_p_fert_costs(t,i,"level")    = vm_p_fert_costs.l(i);
 ov_p_fert_costs(t,i,"upper")    = vm_p_fert_costs.up(i);
 ov_p_fert_costs(t,i,"lower")    = vm_p_fert_costs.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

