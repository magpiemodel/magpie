*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_agroforestry(t,j,"marginal")                   = vm_cost_agroforestry.m(j);
 ov_treecover_area(t,j,"marginal")                      = vm_treecover_area.m(j);
 ov_treecover_carbon(t,j,ag_pools,stockType,"marginal") = vm_treecover_carbon.m(j,ag_pools,stockType);
 ov_cost_agroforestry(t,j,"level")                      = vm_cost_agroforestry.l(j);
 ov_treecover_area(t,j,"level")                         = vm_treecover_area.l(j);
 ov_treecover_carbon(t,j,ag_pools,stockType,"level")    = vm_treecover_carbon.l(j,ag_pools,stockType);
 ov_cost_agroforestry(t,j,"upper")                      = vm_cost_agroforestry.up(j);
 ov_treecover_area(t,j,"upper")                         = vm_treecover_area.up(j);
 ov_treecover_carbon(t,j,ag_pools,stockType,"upper")    = vm_treecover_carbon.up(j,ag_pools,stockType);
 ov_cost_agroforestry(t,j,"lower")                      = vm_cost_agroforestry.lo(j);
 ov_treecover_area(t,j,"lower")                         = vm_treecover_area.lo(j);
 ov_treecover_carbon(t,j,ag_pools,stockType,"lower")    = vm_treecover_carbon.lo(j,ag_pools,stockType);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

