*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov44_bii_weighted_diff(t,"marginal")        = v44_bii_weighted_diff.m;
 ov_cost_bv_loss(t,j,"marginal")             = vm_cost_bv_loss.m(j);
 ov_bv(t,j,landcover44,potnatveg,"marginal") = vm_bv.m(j,landcover44,potnatveg);
 ov44_bii_weighted(t,"marginal")             = v44_bii_weighted.m;
 oq44_bii_weighted(t,"marginal")             = q44_bii_weighted.m;
 oq44_bii_weighted_diff(t,"marginal")        = q44_bii_weighted_diff.m;
 oq44_cost_bv_loss(t,"marginal")             = q44_cost_bv_loss.m;
 ov44_bii_weighted_diff(t,"level")           = v44_bii_weighted_diff.l;
 ov_cost_bv_loss(t,j,"level")                = vm_cost_bv_loss.l(j);
 ov_bv(t,j,landcover44,potnatveg,"level")    = vm_bv.l(j,landcover44,potnatveg);
 ov44_bii_weighted(t,"level")                = v44_bii_weighted.l;
 oq44_bii_weighted(t,"level")                = q44_bii_weighted.l;
 oq44_bii_weighted_diff(t,"level")           = q44_bii_weighted_diff.l;
 oq44_cost_bv_loss(t,"level")                = q44_cost_bv_loss.l;
 ov44_bii_weighted_diff(t,"upper")           = v44_bii_weighted_diff.up;
 ov_cost_bv_loss(t,j,"upper")                = vm_cost_bv_loss.up(j);
 ov_bv(t,j,landcover44,potnatveg,"upper")    = vm_bv.up(j,landcover44,potnatveg);
 ov44_bii_weighted(t,"upper")                = v44_bii_weighted.up;
 oq44_bii_weighted(t,"upper")                = q44_bii_weighted.up;
 oq44_bii_weighted_diff(t,"upper")           = q44_bii_weighted_diff.up;
 oq44_cost_bv_loss(t,"upper")                = q44_cost_bv_loss.up;
 ov44_bii_weighted_diff(t,"lower")           = v44_bii_weighted_diff.lo;
 ov_cost_bv_loss(t,j,"lower")                = vm_cost_bv_loss.lo(j);
 ov_bv(t,j,landcover44,potnatveg,"lower")    = vm_bv.lo(j,landcover44,potnatveg);
 ov44_bii_weighted(t,"lower")                = v44_bii_weighted.lo;
 oq44_bii_weighted(t,"lower")                = q44_bii_weighted.lo;
 oq44_bii_weighted_diff(t,"lower")           = q44_bii_weighted_diff.lo;
 oq44_cost_bv_loss(t,"lower")                = q44_cost_bv_loss.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

