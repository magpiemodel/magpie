*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc59_som_pool(j,land) = v59_som_pool.l(j,land);
pc59_land_before(j,land) = vm_land.l(j,land);
pc59_carbon_density(j,land)$(pc59_land_before(j,land) > 1e-10) = pc59_som_pool(j,land) / pc59_land_before(j,land);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov59_som_target(t,j,land,"marginal")                      = v59_som_target.m(j,land);
 ov59_som_pool(t,j,land,"marginal")                        = v59_som_pool.m(j,land);
 ov_cost_scm(t,j,"marginal")                               = vm_cost_scm.m(j);
 ov59_area_scm(t,j,kcr,w,scmtype59,"marginal")             = v59_area_scm.m(j,kcr,w,scmtype59);
 ov_nr_som(t,j,"marginal")                                 = vm_nr_som.m(j);
 ov_nr_som_fertilizer(t,j,"marginal")                      = vm_nr_som_fertilizer.m(j);
 oq59_som_target_cropland(t,j,"marginal")                  = q59_som_target_cropland.m(j);
 oq59_som_target_noncropland(t,j,noncropland59,"marginal") = q59_som_target_noncropland.m(j,noncropland59);
 oq59_som_pool(t,j,land,"marginal")                        = q59_som_pool.m(j,land);
 oq59_nr_som(t,j,"marginal")                               = q59_nr_som.m(j);
 oq59_nr_som_fertilizer(t,j,"marginal")                    = q59_nr_som_fertilizer.m(j);
 oq59_nr_som_fertilizer2(t,j,"marginal")                   = q59_nr_som_fertilizer2.m(j);
 oq59_carbon_soil(t,j,land,stockType,"marginal")           = q59_carbon_soil.m(j,land,stockType);
 oq59_cost_scm(t,j,"marginal")                             = q59_cost_scm.m(j);
 oq59_area_scm_tot(t,j,kcr,w,"marginal")                   = q59_area_scm_tot.m(j,kcr,w);
 oq59_scm_target_constraint(t,i,"marginal")                = q59_scm_target_constraint.m(i);
 oq59_scm_max_per_cell(t,j,"marginal")                     = q59_scm_max_per_cell.m(j);
 ov59_som_target(t,j,land,"level")                         = v59_som_target.l(j,land);
 ov59_som_pool(t,j,land,"level")                           = v59_som_pool.l(j,land);
 ov_cost_scm(t,j,"level")                                  = vm_cost_scm.l(j);
 ov59_area_scm(t,j,kcr,w,scmtype59,"level")                = v59_area_scm.l(j,kcr,w,scmtype59);
 ov_nr_som(t,j,"level")                                    = vm_nr_som.l(j);
 ov_nr_som_fertilizer(t,j,"level")                         = vm_nr_som_fertilizer.l(j);
 oq59_som_target_cropland(t,j,"level")                     = q59_som_target_cropland.l(j);
 oq59_som_target_noncropland(t,j,noncropland59,"level")    = q59_som_target_noncropland.l(j,noncropland59);
 oq59_som_pool(t,j,land,"level")                           = q59_som_pool.l(j,land);
 oq59_nr_som(t,j,"level")                                  = q59_nr_som.l(j);
 oq59_nr_som_fertilizer(t,j,"level")                       = q59_nr_som_fertilizer.l(j);
 oq59_nr_som_fertilizer2(t,j,"level")                      = q59_nr_som_fertilizer2.l(j);
 oq59_carbon_soil(t,j,land,stockType,"level")              = q59_carbon_soil.l(j,land,stockType);
 oq59_cost_scm(t,j,"level")                                = q59_cost_scm.l(j);
 oq59_area_scm_tot(t,j,kcr,w,"level")                      = q59_area_scm_tot.l(j,kcr,w);
 oq59_scm_target_constraint(t,i,"level")                   = q59_scm_target_constraint.l(i);
 oq59_scm_max_per_cell(t,j,"level")                        = q59_scm_max_per_cell.l(j);
 ov59_som_target(t,j,land,"upper")                         = v59_som_target.up(j,land);
 ov59_som_pool(t,j,land,"upper")                           = v59_som_pool.up(j,land);
 ov_cost_scm(t,j,"upper")                                  = vm_cost_scm.up(j);
 ov59_area_scm(t,j,kcr,w,scmtype59,"upper")                = v59_area_scm.up(j,kcr,w,scmtype59);
 ov_nr_som(t,j,"upper")                                    = vm_nr_som.up(j);
 ov_nr_som_fertilizer(t,j,"upper")                         = vm_nr_som_fertilizer.up(j);
 oq59_som_target_cropland(t,j,"upper")                     = q59_som_target_cropland.up(j);
 oq59_som_target_noncropland(t,j,noncropland59,"upper")    = q59_som_target_noncropland.up(j,noncropland59);
 oq59_som_pool(t,j,land,"upper")                           = q59_som_pool.up(j,land);
 oq59_nr_som(t,j,"upper")                                  = q59_nr_som.up(j);
 oq59_nr_som_fertilizer(t,j,"upper")                       = q59_nr_som_fertilizer.up(j);
 oq59_nr_som_fertilizer2(t,j,"upper")                      = q59_nr_som_fertilizer2.up(j);
 oq59_carbon_soil(t,j,land,stockType,"upper")              = q59_carbon_soil.up(j,land,stockType);
 oq59_cost_scm(t,j,"upper")                                = q59_cost_scm.up(j);
 oq59_area_scm_tot(t,j,kcr,w,"upper")                      = q59_area_scm_tot.up(j,kcr,w);
 oq59_scm_target_constraint(t,i,"upper")                   = q59_scm_target_constraint.up(i);
 oq59_scm_max_per_cell(t,j,"upper")                        = q59_scm_max_per_cell.up(j);
 ov59_som_target(t,j,land,"lower")                         = v59_som_target.lo(j,land);
 ov59_som_pool(t,j,land,"lower")                           = v59_som_pool.lo(j,land);
 ov_cost_scm(t,j,"lower")                                  = vm_cost_scm.lo(j);
 ov59_area_scm(t,j,kcr,w,scmtype59,"lower")                = v59_area_scm.lo(j,kcr,w,scmtype59);
 ov_nr_som(t,j,"lower")                                    = vm_nr_som.lo(j);
 ov_nr_som_fertilizer(t,j,"lower")                         = vm_nr_som_fertilizer.lo(j);
 oq59_som_target_cropland(t,j,"lower")                     = q59_som_target_cropland.lo(j);
 oq59_som_target_noncropland(t,j,noncropland59,"lower")    = q59_som_target_noncropland.lo(j,noncropland59);
 oq59_som_pool(t,j,land,"lower")                           = q59_som_pool.lo(j,land);
 oq59_nr_som(t,j,"lower")                                  = q59_nr_som.lo(j);
 oq59_nr_som_fertilizer(t,j,"lower")                       = q59_nr_som_fertilizer.lo(j);
 oq59_nr_som_fertilizer2(t,j,"lower")                      = q59_nr_som_fertilizer2.lo(j);
 oq59_carbon_soil(t,j,land,stockType,"lower")              = q59_carbon_soil.lo(j,land,stockType);
 oq59_cost_scm(t,j,"lower")                                = q59_cost_scm.lo(j);
 oq59_area_scm_tot(t,j,kcr,w,"lower")                      = q59_area_scm_tot.lo(j,kcr,w);
 oq59_scm_target_constraint(t,i,"lower")                   = q59_scm_target_constraint.lo(i);
 oq59_scm_max_per_cell(t,j,"lower")                        = q59_scm_max_per_cell.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
