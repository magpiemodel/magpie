*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_costs_additional_mon(t,i,"marginal") = vm_costs_additional_mon.m(i);
 ov_costs_additional_mon(t,i,"level")    = vm_costs_additional_mon.l(i);
 ov_costs_additional_mon(t,i,"upper")    = vm_costs_additional_mon.up(i);
 ov_costs_additional_mon(t,i,"lower")    = vm_costs_additional_mon.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

