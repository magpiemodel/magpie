*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_bv_loss(t,j,"marginal")             = vm_cost_bv_loss.m(j);
 ov_bv(t,j,landcover44,potnatveg,"marginal") = vm_bv.m(j,landcover44,potnatveg);
 ov44_bii_glo(t,"marginal")                  = v44_bii_glo.m;
 ov44_bii_reg(t,i,"marginal")                = v44_bii_reg.m(i);
 ov44_bii_cell(t,j,"marginal")               = v44_bii_cell.m(j);
 ov44_bii_realm(t,realm,"marginal")          = v44_bii_realm.m(realm);
 ov44_bii_realm_missing(t,realm,"marginal")  = v44_bii_realm_missing.m(realm);
 oq44_bii_glo(t,"marginal")                  = q44_bii_glo.m;
 oq44_bii_reg(t,i,"marginal")                = q44_bii_reg.m(i);
 oq44_bii_cell(t,j,"marginal")               = q44_bii_cell.m(j);
 oq44_bii_realm(t,realm,"marginal")          = q44_bii_realm.m(realm);
 oq44_bii_realm2(t,realm,"marginal")         = q44_bii_realm2.m(realm);
 oq44_cost_bv_loss(t,"marginal")             = q44_cost_bv_loss.m;
 ov_cost_bv_loss(t,j,"level")                = vm_cost_bv_loss.l(j);
 ov_bv(t,j,landcover44,potnatveg,"level")    = vm_bv.l(j,landcover44,potnatveg);
 ov44_bii_glo(t,"level")                     = v44_bii_glo.l;
 ov44_bii_reg(t,i,"level")                   = v44_bii_reg.l(i);
 ov44_bii_cell(t,j,"level")                  = v44_bii_cell.l(j);
 ov44_bii_realm(t,realm,"level")             = v44_bii_realm.l(realm);
 ov44_bii_realm_missing(t,realm,"level")     = v44_bii_realm_missing.l(realm);
 oq44_bii_glo(t,"level")                     = q44_bii_glo.l;
 oq44_bii_reg(t,i,"level")                   = q44_bii_reg.l(i);
 oq44_bii_cell(t,j,"level")                  = q44_bii_cell.l(j);
 oq44_bii_realm(t,realm,"level")             = q44_bii_realm.l(realm);
 oq44_bii_realm2(t,realm,"level")            = q44_bii_realm2.l(realm);
 oq44_cost_bv_loss(t,"level")                = q44_cost_bv_loss.l;
 ov_cost_bv_loss(t,j,"upper")                = vm_cost_bv_loss.up(j);
 ov_bv(t,j,landcover44,potnatveg,"upper")    = vm_bv.up(j,landcover44,potnatveg);
 ov44_bii_glo(t,"upper")                     = v44_bii_glo.up;
 ov44_bii_reg(t,i,"upper")                   = v44_bii_reg.up(i);
 ov44_bii_cell(t,j,"upper")                  = v44_bii_cell.up(j);
 ov44_bii_realm(t,realm,"upper")             = v44_bii_realm.up(realm);
 ov44_bii_realm_missing(t,realm,"upper")     = v44_bii_realm_missing.up(realm);
 oq44_bii_glo(t,"upper")                     = q44_bii_glo.up;
 oq44_bii_reg(t,i,"upper")                   = q44_bii_reg.up(i);
 oq44_bii_cell(t,j,"upper")                  = q44_bii_cell.up(j);
 oq44_bii_realm(t,realm,"upper")             = q44_bii_realm.up(realm);
 oq44_bii_realm2(t,realm,"upper")            = q44_bii_realm2.up(realm);
 oq44_cost_bv_loss(t,"upper")                = q44_cost_bv_loss.up;
 ov_cost_bv_loss(t,j,"lower")                = vm_cost_bv_loss.lo(j);
 ov_bv(t,j,landcover44,potnatveg,"lower")    = vm_bv.lo(j,landcover44,potnatveg);
 ov44_bii_glo(t,"lower")                     = v44_bii_glo.lo;
 ov44_bii_reg(t,i,"lower")                   = v44_bii_reg.lo(i);
 ov44_bii_cell(t,j,"lower")                  = v44_bii_cell.lo(j);
 ov44_bii_realm(t,realm,"lower")             = v44_bii_realm.lo(realm);
 ov44_bii_realm_missing(t,realm,"lower")     = v44_bii_realm_missing.lo(realm);
 oq44_bii_glo(t,"lower")                     = q44_bii_glo.lo;
 oq44_bii_reg(t,i,"lower")                   = q44_bii_reg.lo(i);
 oq44_bii_cell(t,j,"lower")                  = q44_bii_cell.lo(j);
 oq44_bii_realm(t,realm,"lower")             = q44_bii_realm.lo(realm);
 oq44_bii_realm2(t,realm,"lower")            = q44_bii_realm2.lo(realm);
 oq44_cost_bv_loss(t,"lower")                = q44_cost_bv_loss.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

