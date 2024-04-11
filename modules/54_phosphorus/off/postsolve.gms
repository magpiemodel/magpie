*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_p_fert_costs(t,i,"marginal") = vm_p_fert_costs.m(i);
 ov_p_fert_costs(t,i,"level")    = vm_p_fert_costs.l(i);
 ov_p_fert_costs(t,i,"upper")    = vm_p_fert_costs.up(i);
 ov_p_fert_costs(t,i,"lower")    = vm_p_fert_costs.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

