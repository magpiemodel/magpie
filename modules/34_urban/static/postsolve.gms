*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_urban(t,j,"marginal") = vm_cost_urban.m(j);
 ov_cost_urban(t,j,"level")    = vm_cost_urban.l(j);
 ov_cost_urban(t,j,"upper")    = vm_cost_urban.up(j);
 ov_cost_urban(t,j,"lower")    = vm_cost_urban.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

