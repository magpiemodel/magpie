*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_transp(t,j,k,"marginal")      = vm_cost_transp.m(j,k);
 oq40_cost_transport(t,j,k,"marginal") = q40_cost_transport.m(j,k);
 ov_cost_transp(t,j,k,"level")         = vm_cost_transp.l(j,k);
 oq40_cost_transport(t,j,k,"level")    = q40_cost_transport.l(j,k);
 ov_cost_transp(t,j,k,"upper")         = vm_cost_transp.up(j,k);
 oq40_cost_transport(t,j,k,"upper")    = q40_cost_transport.up(j,k);
 ov_cost_transp(t,j,k,"lower")         = vm_cost_transp.lo(j,k);
 oq40_cost_transport(t,j,k,"lower")    = q40_cost_transport.lo(j,k);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
