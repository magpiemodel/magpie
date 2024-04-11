*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_peatland_cost(t,j,"marginal") = vm_peatland_cost.m(j);
 ov_peatland_cost(t,j,"level")    = vm_peatland_cost.l(j);
 ov_peatland_cost(t,j,"upper")    = vm_peatland_cost.up(j);
 ov_peatland_cost(t,j,"lower")    = vm_peatland_cost.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

