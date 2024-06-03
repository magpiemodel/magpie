*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_bv_loss(t,j,"marginal")             = vm_cost_bv_loss.m(j);
 ov_bv(t,j,landcover44,potnatveg,"marginal") = vm_bv.m(j,landcover44,potnatveg);
 ov44_bii(t,i,biome44,"marginal")            = v44_bii.m(i,biome44);
 ov44_bii_missing(t,i,biome44,"marginal")    = v44_bii_missing.m(i,biome44);
 oq44_bii(t,i,biome44,"marginal")            = q44_bii.m(i,biome44);
 oq44_bii_target(t,i,biome44,"marginal")     = q44_bii_target.m(i,biome44);
 oq44_cost(t,i,"marginal")                   = q44_cost.m(i);
 ov_cost_bv_loss(t,j,"level")                = vm_cost_bv_loss.l(j);
 ov_bv(t,j,landcover44,potnatveg,"level")    = vm_bv.l(j,landcover44,potnatveg);
 ov44_bii(t,i,biome44,"level")               = v44_bii.l(i,biome44);
 ov44_bii_missing(t,i,biome44,"level")       = v44_bii_missing.l(i,biome44);
 oq44_bii(t,i,biome44,"level")               = q44_bii.l(i,biome44);
 oq44_bii_target(t,i,biome44,"level")        = q44_bii_target.l(i,biome44);
 oq44_cost(t,i,"level")                      = q44_cost.l(i);
 ov_cost_bv_loss(t,j,"upper")                = vm_cost_bv_loss.up(j);
 ov_bv(t,j,landcover44,potnatveg,"upper")    = vm_bv.up(j,landcover44,potnatveg);
 ov44_bii(t,i,biome44,"upper")               = v44_bii.up(i,biome44);
 ov44_bii_missing(t,i,biome44,"upper")       = v44_bii_missing.up(i,biome44);
 oq44_bii(t,i,biome44,"upper")               = q44_bii.up(i,biome44);
 oq44_bii_target(t,i,biome44,"upper")        = q44_bii_target.up(i,biome44);
 oq44_cost(t,i,"upper")                      = q44_cost.up(i);
 ov_cost_bv_loss(t,j,"lower")                = vm_cost_bv_loss.lo(j);
 ov_bv(t,j,landcover44,potnatveg,"lower")    = vm_bv.lo(j,landcover44,potnatveg);
 ov44_bii(t,i,biome44,"lower")               = v44_bii.lo(i,biome44);
 ov44_bii_missing(t,i,biome44,"lower")       = v44_bii_missing.lo(i,biome44);
 oq44_bii(t,i,biome44,"lower")               = q44_bii.lo(i,biome44);
 oq44_bii_target(t,i,biome44,"lower")        = q44_bii_target.lo(i,biome44);
 oq44_cost(t,i,"lower")                      = q44_cost.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

