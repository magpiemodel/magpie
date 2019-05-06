*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_maccs_costs(t,i,"marginal") = vm_maccs_costs.m(i);
 ov_maccs_costs(t,i,"level")    = vm_maccs_costs.l(i);
 ov_maccs_costs(t,i,"upper")    = vm_maccs_costs.up(i);
 ov_maccs_costs(t,i,"lower")    = vm_maccs_costs.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
