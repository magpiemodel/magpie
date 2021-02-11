*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_timber(t,i,"marginal") = vm_cost_timber.m(i);
 ov_cost_timber(t,i,"level")    = vm_cost_timber.l(i);
 ov_cost_timber(t,i,"upper")    = vm_cost_timber.up(i);
 ov_cost_timber(t,i,"lower")    = vm_cost_timber.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
