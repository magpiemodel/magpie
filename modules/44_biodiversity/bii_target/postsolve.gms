*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc44_bv_weighted(j,landcover44) = v44_bv_weighted.l(j,landcover44);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov44_bv_glo(t,"marginal")                    = v44_bv_glo.m;
 ov44_bv_slack(t,"marginal")                  = v44_bv_slack.m;
 ov_cost_bv_loss(t,j,"marginal")              = vm_cost_bv_loss.m(j);
 ov_bv(t,j,landcover44,potnatveg,"marginal")  = vm_bv.m(j,landcover44,potnatveg);
 ov44_bv_weighted(t,j,landcover44,"marginal") = v44_bv_weighted.m(j,landcover44);
 oq44_bv_weighted(t,j,landcover44,"marginal") = q44_bv_weighted.m(j,landcover44);
 oq44_bv_glo(t,"marginal")                    = q44_bv_glo.m;
 oq44_bv_glo2(t,"marginal")                   = q44_bv_glo2.m;
 oq44_cost_bv_loss(t,"marginal")              = q44_cost_bv_loss.m;
 ov44_bv_glo(t,"level")                       = v44_bv_glo.l;
 ov44_bv_slack(t,"level")                     = v44_bv_slack.l;
 ov_cost_bv_loss(t,j,"level")                 = vm_cost_bv_loss.l(j);
 ov_bv(t,j,landcover44,potnatveg,"level")     = vm_bv.l(j,landcover44,potnatveg);
 ov44_bv_weighted(t,j,landcover44,"level")    = v44_bv_weighted.l(j,landcover44);
 oq44_bv_weighted(t,j,landcover44,"level")    = q44_bv_weighted.l(j,landcover44);
 oq44_bv_glo(t,"level")                       = q44_bv_glo.l;
 oq44_bv_glo2(t,"level")                      = q44_bv_glo2.l;
 oq44_cost_bv_loss(t,"level")                 = q44_cost_bv_loss.l;
 ov44_bv_glo(t,"upper")                       = v44_bv_glo.up;
 ov44_bv_slack(t,"upper")                     = v44_bv_slack.up;
 ov_cost_bv_loss(t,j,"upper")                 = vm_cost_bv_loss.up(j);
 ov_bv(t,j,landcover44,potnatveg,"upper")     = vm_bv.up(j,landcover44,potnatveg);
 ov44_bv_weighted(t,j,landcover44,"upper")    = v44_bv_weighted.up(j,landcover44);
 oq44_bv_weighted(t,j,landcover44,"upper")    = q44_bv_weighted.up(j,landcover44);
 oq44_bv_glo(t,"upper")                       = q44_bv_glo.up;
 oq44_bv_glo2(t,"upper")                      = q44_bv_glo2.up;
 oq44_cost_bv_loss(t,"upper")                 = q44_cost_bv_loss.up;
 ov44_bv_glo(t,"lower")                       = v44_bv_glo.lo;
 ov44_bv_slack(t,"lower")                     = v44_bv_slack.lo;
 ov_cost_bv_loss(t,j,"lower")                 = vm_cost_bv_loss.lo(j);
 ov_bv(t,j,landcover44,potnatveg,"lower")     = vm_bv.lo(j,landcover44,potnatveg);
 ov44_bv_weighted(t,j,landcover44,"lower")    = v44_bv_weighted.lo(j,landcover44);
 oq44_bv_weighted(t,j,landcover44,"lower")    = q44_bv_weighted.lo(j,landcover44);
 oq44_bv_glo(t,"lower")                       = q44_bv_glo.lo;
 oq44_bv_glo2(t,"lower")                      = q44_bv_glo2.lo;
 oq44_cost_bv_loss(t,"lower")                 = q44_cost_bv_loss.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

