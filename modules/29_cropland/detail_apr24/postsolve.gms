*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc29_treecover(j,ac) = v29_treecover.l(j,ac);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_cropland(t,j,"marginal")               = vm_cost_cropland.m(j);
 ov_treecover(t,j,"marginal")                   = vm_treecover.m(j);
 ov29_treecover(t,j,ac,"marginal")              = v29_treecover.m(j,ac);
 ov29_treecover_missing(t,j,"marginal")         = v29_treecover_missing.m(j);
 ov29_cost_treecover_est(t,j,"marginal")        = v29_cost_treecover_est.m(j);
 ov29_cost_treecover_recur(t,j,"marginal")      = v29_cost_treecover_recur.m(j);
 ov_fallow(t,j,"marginal")                      = vm_fallow.m(j);
 ov29_fallow_missing(t,j,"marginal")            = v29_fallow_missing.m(j);
 oq29_cropland(t,j,"marginal")                  = q29_cropland.m(j);
 oq29_avl_cropland(t,j,"marginal")              = q29_avl_cropland.m(j);
 oq29_cost_cropland(t,j,"marginal")             = q29_cost_cropland.m(j);
 oq29_carbon(t,j,ag_pools,stockType,"marginal") = q29_carbon.m(j,ag_pools,stockType);
 oq29_land_snv(t,j,"marginal")                  = q29_land_snv.m(j);
 oq29_land_snv_trans(t,j,"marginal")            = q29_land_snv_trans.m(j);
 oq29_fallow_min(t,j,"marginal")                = q29_fallow_min.m(j);
 oq29_fallow_max(t,j,"marginal")                = q29_fallow_max.m(j);
 oq29_fallow_bv(t,j,potnatveg,"marginal")       = q29_fallow_bv.m(j,potnatveg);
 oq29_treecover(t,j,"marginal")                 = q29_treecover.m(j);
 oq29_treecover_min(t,j,"marginal")             = q29_treecover_min.m(j);
 oq29_treecover_max(t,j,"marginal")             = q29_treecover_max.m(j);
 oq29_treecover_bv(t,j,potnatveg,"marginal")    = q29_treecover_bv.m(j,potnatveg);
 oq29_cost_treecover_est(t,j,"marginal")        = q29_cost_treecover_est.m(j);
 oq29_cost_treecover_recur(t,j,"marginal")      = q29_cost_treecover_recur.m(j);
 oq29_treecover_est(t,j,ac,"marginal")          = q29_treecover_est.m(j,ac);
 ov_cost_cropland(t,j,"level")                  = vm_cost_cropland.l(j);
 ov_treecover(t,j,"level")                      = vm_treecover.l(j);
 ov29_treecover(t,j,ac,"level")                 = v29_treecover.l(j,ac);
 ov29_treecover_missing(t,j,"level")            = v29_treecover_missing.l(j);
 ov29_cost_treecover_est(t,j,"level")           = v29_cost_treecover_est.l(j);
 ov29_cost_treecover_recur(t,j,"level")         = v29_cost_treecover_recur.l(j);
 ov_fallow(t,j,"level")                         = vm_fallow.l(j);
 ov29_fallow_missing(t,j,"level")               = v29_fallow_missing.l(j);
 oq29_cropland(t,j,"level")                     = q29_cropland.l(j);
 oq29_avl_cropland(t,j,"level")                 = q29_avl_cropland.l(j);
 oq29_cost_cropland(t,j,"level")                = q29_cost_cropland.l(j);
 oq29_carbon(t,j,ag_pools,stockType,"level")    = q29_carbon.l(j,ag_pools,stockType);
 oq29_land_snv(t,j,"level")                     = q29_land_snv.l(j);
 oq29_land_snv_trans(t,j,"level")               = q29_land_snv_trans.l(j);
 oq29_fallow_min(t,j,"level")                   = q29_fallow_min.l(j);
 oq29_fallow_max(t,j,"level")                   = q29_fallow_max.l(j);
 oq29_fallow_bv(t,j,potnatveg,"level")          = q29_fallow_bv.l(j,potnatveg);
 oq29_treecover(t,j,"level")                    = q29_treecover.l(j);
 oq29_treecover_min(t,j,"level")                = q29_treecover_min.l(j);
 oq29_treecover_max(t,j,"level")                = q29_treecover_max.l(j);
 oq29_treecover_bv(t,j,potnatveg,"level")       = q29_treecover_bv.l(j,potnatveg);
 oq29_cost_treecover_est(t,j,"level")           = q29_cost_treecover_est.l(j);
 oq29_cost_treecover_recur(t,j,"level")         = q29_cost_treecover_recur.l(j);
 oq29_treecover_est(t,j,ac,"level")             = q29_treecover_est.l(j,ac);
 ov_cost_cropland(t,j,"upper")                  = vm_cost_cropland.up(j);
 ov_treecover(t,j,"upper")                      = vm_treecover.up(j);
 ov29_treecover(t,j,ac,"upper")                 = v29_treecover.up(j,ac);
 ov29_treecover_missing(t,j,"upper")            = v29_treecover_missing.up(j);
 ov29_cost_treecover_est(t,j,"upper")           = v29_cost_treecover_est.up(j);
 ov29_cost_treecover_recur(t,j,"upper")         = v29_cost_treecover_recur.up(j);
 ov_fallow(t,j,"upper")                         = vm_fallow.up(j);
 ov29_fallow_missing(t,j,"upper")               = v29_fallow_missing.up(j);
 oq29_cropland(t,j,"upper")                     = q29_cropland.up(j);
 oq29_avl_cropland(t,j,"upper")                 = q29_avl_cropland.up(j);
 oq29_cost_cropland(t,j,"upper")                = q29_cost_cropland.up(j);
 oq29_carbon(t,j,ag_pools,stockType,"upper")    = q29_carbon.up(j,ag_pools,stockType);
 oq29_land_snv(t,j,"upper")                     = q29_land_snv.up(j);
 oq29_land_snv_trans(t,j,"upper")               = q29_land_snv_trans.up(j);
 oq29_fallow_min(t,j,"upper")                   = q29_fallow_min.up(j);
 oq29_fallow_max(t,j,"upper")                   = q29_fallow_max.up(j);
 oq29_fallow_bv(t,j,potnatveg,"upper")          = q29_fallow_bv.up(j,potnatveg);
 oq29_treecover(t,j,"upper")                    = q29_treecover.up(j);
 oq29_treecover_min(t,j,"upper")                = q29_treecover_min.up(j);
 oq29_treecover_max(t,j,"upper")                = q29_treecover_max.up(j);
 oq29_treecover_bv(t,j,potnatveg,"upper")       = q29_treecover_bv.up(j,potnatveg);
 oq29_cost_treecover_est(t,j,"upper")           = q29_cost_treecover_est.up(j);
 oq29_cost_treecover_recur(t,j,"upper")         = q29_cost_treecover_recur.up(j);
 oq29_treecover_est(t,j,ac,"upper")             = q29_treecover_est.up(j,ac);
 ov_cost_cropland(t,j,"lower")                  = vm_cost_cropland.lo(j);
 ov_treecover(t,j,"lower")                      = vm_treecover.lo(j);
 ov29_treecover(t,j,ac,"lower")                 = v29_treecover.lo(j,ac);
 ov29_treecover_missing(t,j,"lower")            = v29_treecover_missing.lo(j);
 ov29_cost_treecover_est(t,j,"lower")           = v29_cost_treecover_est.lo(j);
 ov29_cost_treecover_recur(t,j,"lower")         = v29_cost_treecover_recur.lo(j);
 ov_fallow(t,j,"lower")                         = vm_fallow.lo(j);
 ov29_fallow_missing(t,j,"lower")               = v29_fallow_missing.lo(j);
 oq29_cropland(t,j,"lower")                     = q29_cropland.lo(j);
 oq29_avl_cropland(t,j,"lower")                 = q29_avl_cropland.lo(j);
 oq29_cost_cropland(t,j,"lower")                = q29_cost_cropland.lo(j);
 oq29_carbon(t,j,ag_pools,stockType,"lower")    = q29_carbon.lo(j,ag_pools,stockType);
 oq29_land_snv(t,j,"lower")                     = q29_land_snv.lo(j);
 oq29_land_snv_trans(t,j,"lower")               = q29_land_snv_trans.lo(j);
 oq29_fallow_min(t,j,"lower")                   = q29_fallow_min.lo(j);
 oq29_fallow_max(t,j,"lower")                   = q29_fallow_max.lo(j);
 oq29_fallow_bv(t,j,potnatveg,"lower")          = q29_fallow_bv.lo(j,potnatveg);
 oq29_treecover(t,j,"lower")                    = q29_treecover.lo(j);
 oq29_treecover_min(t,j,"lower")                = q29_treecover_min.lo(j);
 oq29_treecover_max(t,j,"lower")                = q29_treecover_max.lo(j);
 oq29_treecover_bv(t,j,potnatveg,"lower")       = q29_treecover_bv.lo(j,potnatveg);
 oq29_cost_treecover_est(t,j,"lower")           = q29_cost_treecover_est.lo(j);
 oq29_cost_treecover_recur(t,j,"lower")         = q29_cost_treecover_recur.lo(j);
 oq29_treecover_est(t,j,ac,"lower")             = q29_treecover_est.lo(j,ac);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

