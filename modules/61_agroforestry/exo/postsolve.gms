*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc61_treecover(j,ac) = v61_treecover.l(j,ac);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_agroforestry(t,j,"marginal")                     = vm_cost_agroforestry.m(j);
 ov61_cost_treecover_est(t,j,"marginal")                  = v61_cost_treecover_est.m(j);
 ov61_cost_treecover_recur(t,j,"marginal")                = v61_cost_treecover_recur.m(j);
 ov_treecover_area(t,j,"marginal")                        = vm_treecover_area.m(j);
 ov61_treecover(t,j,ac,"marginal")                        = v61_treecover.m(j,ac);
 ov_treecover_carbon(t,j,ag_pools,stockType,"marginal")   = vm_treecover_carbon.m(j,ag_pools,stockType);
 oq61_cost_agroforestry(t,j,"marginal")                   = q61_cost_agroforestry.m(j);
 oq61_cost_treecover_est(t,j,"marginal")                  = q61_cost_treecover_est.m(j);
 oq61_cost_treecover_recur(t,j,"marginal")                = q61_cost_treecover_recur.m(j);
 oq61_treecover_area(t,j,"marginal")                      = q61_treecover_area.m(j);
 oq61_treecover_shr(t,j,"marginal")                       = q61_treecover_shr.m(j);
 oq61_betr_shr(t,j,"marginal")                            = q61_betr_shr.m(j);
 oq61_treecover_est(t,j,ac,"marginal")                    = q61_treecover_est.m(j,ac);
 oq61_treecover_carbon(t,j,ag_pools,stockType,"marginal") = q61_treecover_carbon.m(j,ag_pools,stockType);
 oq61_treecover_bv(t,j,potnatveg,"marginal")              = q61_treecover_bv.m(j,potnatveg);
 ov_cost_agroforestry(t,j,"level")                        = vm_cost_agroforestry.l(j);
 ov61_cost_treecover_est(t,j,"level")                     = v61_cost_treecover_est.l(j);
 ov61_cost_treecover_recur(t,j,"level")                   = v61_cost_treecover_recur.l(j);
 ov_treecover_area(t,j,"level")                           = vm_treecover_area.l(j);
 ov61_treecover(t,j,ac,"level")                           = v61_treecover.l(j,ac);
 ov_treecover_carbon(t,j,ag_pools,stockType,"level")      = vm_treecover_carbon.l(j,ag_pools,stockType);
 oq61_cost_agroforestry(t,j,"level")                      = q61_cost_agroforestry.l(j);
 oq61_cost_treecover_est(t,j,"level")                     = q61_cost_treecover_est.l(j);
 oq61_cost_treecover_recur(t,j,"level")                   = q61_cost_treecover_recur.l(j);
 oq61_treecover_area(t,j,"level")                         = q61_treecover_area.l(j);
 oq61_treecover_shr(t,j,"level")                          = q61_treecover_shr.l(j);
 oq61_betr_shr(t,j,"level")                               = q61_betr_shr.l(j);
 oq61_treecover_est(t,j,ac,"level")                       = q61_treecover_est.l(j,ac);
 oq61_treecover_carbon(t,j,ag_pools,stockType,"level")    = q61_treecover_carbon.l(j,ag_pools,stockType);
 oq61_treecover_bv(t,j,potnatveg,"level")                 = q61_treecover_bv.l(j,potnatveg);
 ov_cost_agroforestry(t,j,"upper")                        = vm_cost_agroforestry.up(j);
 ov61_cost_treecover_est(t,j,"upper")                     = v61_cost_treecover_est.up(j);
 ov61_cost_treecover_recur(t,j,"upper")                   = v61_cost_treecover_recur.up(j);
 ov_treecover_area(t,j,"upper")                           = vm_treecover_area.up(j);
 ov61_treecover(t,j,ac,"upper")                           = v61_treecover.up(j,ac);
 ov_treecover_carbon(t,j,ag_pools,stockType,"upper")      = vm_treecover_carbon.up(j,ag_pools,stockType);
 oq61_cost_agroforestry(t,j,"upper")                      = q61_cost_agroforestry.up(j);
 oq61_cost_treecover_est(t,j,"upper")                     = q61_cost_treecover_est.up(j);
 oq61_cost_treecover_recur(t,j,"upper")                   = q61_cost_treecover_recur.up(j);
 oq61_treecover_area(t,j,"upper")                         = q61_treecover_area.up(j);
 oq61_treecover_shr(t,j,"upper")                          = q61_treecover_shr.up(j);
 oq61_betr_shr(t,j,"upper")                               = q61_betr_shr.up(j);
 oq61_treecover_est(t,j,ac,"upper")                       = q61_treecover_est.up(j,ac);
 oq61_treecover_carbon(t,j,ag_pools,stockType,"upper")    = q61_treecover_carbon.up(j,ag_pools,stockType);
 oq61_treecover_bv(t,j,potnatveg,"upper")                 = q61_treecover_bv.up(j,potnatveg);
 ov_cost_agroforestry(t,j,"lower")                        = vm_cost_agroforestry.lo(j);
 ov61_cost_treecover_est(t,j,"lower")                     = v61_cost_treecover_est.lo(j);
 ov61_cost_treecover_recur(t,j,"lower")                   = v61_cost_treecover_recur.lo(j);
 ov_treecover_area(t,j,"lower")                           = vm_treecover_area.lo(j);
 ov61_treecover(t,j,ac,"lower")                           = v61_treecover.lo(j,ac);
 ov_treecover_carbon(t,j,ag_pools,stockType,"lower")      = vm_treecover_carbon.lo(j,ag_pools,stockType);
 oq61_cost_agroforestry(t,j,"lower")                      = q61_cost_agroforestry.lo(j);
 oq61_cost_treecover_est(t,j,"lower")                     = q61_cost_treecover_est.lo(j);
 oq61_cost_treecover_recur(t,j,"lower")                   = q61_cost_treecover_recur.lo(j);
 oq61_treecover_area(t,j,"lower")                         = q61_treecover_area.lo(j);
 oq61_treecover_shr(t,j,"lower")                          = q61_treecover_shr.lo(j);
 oq61_betr_shr(t,j,"lower")                               = q61_betr_shr.lo(j);
 oq61_treecover_est(t,j,ac,"lower")                       = q61_treecover_est.lo(j,ac);
 oq61_treecover_carbon(t,j,ag_pools,stockType,"lower")    = q61_treecover_carbon.lo(j,ag_pools,stockType);
 oq61_treecover_bv(t,j,potnatveg,"lower")                 = q61_treecover_bv.lo(j,potnatveg);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
