*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pcm_tau(h, tautype) = vm_tau.l(h, tautype);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_tau(t,h,tautype,"marginal") = vm_tau.m(h,tautype);
 ov_tech_cost(t,i,"marginal")   = vm_tech_cost.m(i);
 ov_tau(t,h,tautype,"level")    = vm_tau.l(h,tautype);
 ov_tech_cost(t,i,"level")      = vm_tech_cost.l(i);
 ov_tau(t,h,tautype,"upper")    = vm_tau.up(h,tautype);
 ov_tech_cost(t,i,"upper")      = vm_tech_cost.up(i);
 ov_tau(t,h,tautype,"lower")    = vm_tau.lo(h,tautype);
 ov_tech_cost(t,i,"lower")      = vm_tech_cost.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
