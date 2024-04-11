*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_landcon(t,j,land,"marginal")   = vm_cost_landcon.m(j,land);
 oq39_cost_landcon(t,j,land,"marginal") = q39_cost_landcon.m(j,land);
 ov_cost_landcon(t,j,land,"level")      = vm_cost_landcon.l(j,land);
 oq39_cost_landcon(t,j,land,"level")    = q39_cost_landcon.l(j,land);
 ov_cost_landcon(t,j,land,"upper")      = vm_cost_landcon.up(j,land);
 oq39_cost_landcon(t,j,land,"upper")    = q39_cost_landcon.up(j,land);
 ov_cost_landcon(t,j,land,"lower")      = vm_cost_landcon.lo(j,land);
 oq39_cost_landcon(t,j,land,"lower")    = q39_cost_landcon.lo(j,land);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
