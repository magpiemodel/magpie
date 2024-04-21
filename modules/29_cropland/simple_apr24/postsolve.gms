*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_cropland(t,j,"marginal")               = vm_cost_cropland.m(j);
 ov_fallow(t,j,"marginal")                      = vm_fallow.m(j);
 oq29_cropland(t,j,"marginal")                  = q29_cropland.m(j);
 oq29_avl_cropland(t,j,"marginal")              = q29_avl_cropland.m(j);
 oq29_carbon(t,j,ag_pools,stockType,"marginal") = q29_carbon.m(j,ag_pools,stockType);
 ov_cost_cropland(t,j,"level")                  = vm_cost_cropland.l(j);
 ov_fallow(t,j,"level")                         = vm_fallow.l(j);
 oq29_cropland(t,j,"level")                     = q29_cropland.l(j);
 oq29_avl_cropland(t,j,"level")                 = q29_avl_cropland.l(j);
 oq29_carbon(t,j,ag_pools,stockType,"level")    = q29_carbon.l(j,ag_pools,stockType);
 ov_cost_cropland(t,j,"upper")                  = vm_cost_cropland.up(j);
 ov_fallow(t,j,"upper")                         = vm_fallow.up(j);
 oq29_cropland(t,j,"upper")                     = q29_cropland.up(j);
 oq29_avl_cropland(t,j,"upper")                 = q29_avl_cropland.up(j);
 oq29_carbon(t,j,ag_pools,stockType,"upper")    = q29_carbon.up(j,ag_pools,stockType);
 ov_cost_cropland(t,j,"lower")                  = vm_cost_cropland.lo(j);
 ov_fallow(t,j,"lower")                         = vm_fallow.lo(j);
 oq29_cropland(t,j,"lower")                     = q29_cropland.lo(j);
 oq29_avl_cropland(t,j,"lower")                 = q29_avl_cropland.lo(j);
 oq29_carbon(t,j,ag_pools,stockType,"lower")    = q29_carbon.lo(j,ag_pools,stockType);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

