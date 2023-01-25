*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_bv_loss(t,j,"marginal")             = vm_cost_bv_loss.m(j);
 ov_bv(t,j,landcover44,potnatveg,"marginal") = vm_bv.m(j,landcover44,potnatveg);
 ov44_bii(t,j,"marginal")                    = v44_bii.m(j);
 ov44_bii_missing(t,j,"marginal")            = v44_bii_missing.m(j);
 oq44_bii(t,j,"marginal")                    = q44_bii.m(j);
 oq44_bii_target(t,j,"marginal")             = q44_bii_target.m(j);
 oq44_cost(t,"marginal")                     = q44_cost.m;
 ov_cost_bv_loss(t,j,"level")                = vm_cost_bv_loss.l(j);
 ov_bv(t,j,landcover44,potnatveg,"level")    = vm_bv.l(j,landcover44,potnatveg);
 ov44_bii(t,j,"level")                       = v44_bii.l(j);
 ov44_bii_missing(t,j,"level")               = v44_bii_missing.l(j);
 oq44_bii(t,j,"level")                       = q44_bii.l(j);
 oq44_bii_target(t,j,"level")                = q44_bii_target.l(j);
 oq44_cost(t,"level")                        = q44_cost.l;
 ov_cost_bv_loss(t,j,"upper")                = vm_cost_bv_loss.up(j);
 ov_bv(t,j,landcover44,potnatveg,"upper")    = vm_bv.up(j,landcover44,potnatveg);
 ov44_bii(t,j,"upper")                       = v44_bii.up(j);
 ov44_bii_missing(t,j,"upper")               = v44_bii_missing.up(j);
 oq44_bii(t,j,"upper")                       = q44_bii.up(j);
 oq44_bii_target(t,j,"upper")                = q44_bii_target.up(j);
 oq44_cost(t,"upper")                        = q44_cost.up;
 ov_cost_bv_loss(t,j,"lower")                = vm_cost_bv_loss.lo(j);
 ov_bv(t,j,landcover44,potnatveg,"lower")    = vm_bv.lo(j,landcover44,potnatveg);
 ov44_bii(t,j,"lower")                       = v44_bii.lo(j);
 ov44_bii_missing(t,j,"lower")               = v44_bii_missing.lo(j);
 oq44_bii(t,j,"lower")                       = q44_bii.lo(j);
 oq44_bii_target(t,j,"lower")                = q44_bii_target.lo(j);
 oq44_cost(t,"lower")                        = q44_cost.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

