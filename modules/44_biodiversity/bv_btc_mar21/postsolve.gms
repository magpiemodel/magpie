*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov44_bv_loss(t,j,"marginal")                = v44_bv_loss.m(j);
 ov_cost_bv_loss(t,j,"marginal")             = vm_cost_bv_loss.m(j);
 ov_bv(t,j,landcover44,potnatveg,"marginal") = vm_bv.m(j,landcover44,potnatveg);
 ov44_bv_weighted(t,j,"marginal")            = v44_bv_weighted.m(j);
 oq44_bv_loss(t,j,"marginal")                = q44_bv_loss.m(j);
 oq44_bv_weighted(t,j,"marginal")            = q44_bv_weighted.m(j);
 oq44_cost_bv_loss(t,j,"marginal")           = q44_cost_bv_loss.m(j);
 ov44_bv_loss(t,j,"level")                   = v44_bv_loss.l(j);
 ov_cost_bv_loss(t,j,"level")                = vm_cost_bv_loss.l(j);
 ov_bv(t,j,landcover44,potnatveg,"level")    = vm_bv.l(j,landcover44,potnatveg);
 ov44_bv_weighted(t,j,"level")               = v44_bv_weighted.l(j);
 oq44_bv_loss(t,j,"level")                   = q44_bv_loss.l(j);
 oq44_bv_weighted(t,j,"level")               = q44_bv_weighted.l(j);
 oq44_cost_bv_loss(t,j,"level")              = q44_cost_bv_loss.l(j);
 ov44_bv_loss(t,j,"upper")                   = v44_bv_loss.up(j);
 ov_cost_bv_loss(t,j,"upper")                = vm_cost_bv_loss.up(j);
 ov_bv(t,j,landcover44,potnatveg,"upper")    = vm_bv.up(j,landcover44,potnatveg);
 ov44_bv_weighted(t,j,"upper")               = v44_bv_weighted.up(j);
 oq44_bv_loss(t,j,"upper")                   = q44_bv_loss.up(j);
 oq44_bv_weighted(t,j,"upper")               = q44_bv_weighted.up(j);
 oq44_cost_bv_loss(t,j,"upper")              = q44_cost_bv_loss.up(j);
 ov44_bv_loss(t,j,"lower")                   = v44_bv_loss.lo(j);
 ov_cost_bv_loss(t,j,"lower")                = vm_cost_bv_loss.lo(j);
 ov_bv(t,j,landcover44,potnatveg,"lower")    = vm_bv.lo(j,landcover44,potnatveg);
 ov44_bv_weighted(t,j,"lower")               = v44_bv_weighted.lo(j);
 oq44_bv_loss(t,j,"lower")                   = q44_bv_loss.lo(j);
 oq44_bv_weighted(t,j,"lower")               = q44_bv_weighted.lo(j);
 oq44_cost_bv_loss(t,j,"lower")              = q44_cost_bv_loss.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

