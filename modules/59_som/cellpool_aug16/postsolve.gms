*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

p59_som_pool(j,land) = v59_som_pool.l(j,land);
p59_land_before(j,land) = vm_land.l(j,land);
p59_carbon_density(t,j,land)$(pcm_land(j,land) > 1e-10) = p59_som_pool(j,land) / pcm_land(j,land);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov59_som_target(t,j,land,"marginal")                      = v59_som_target.m(j,land);
 ov59_som_pool(t,j,land,"marginal")                        = v59_som_pool.m(j,land);
 ov_nr_som(t,i,"marginal")                                 = vm_nr_som.m(i);
 ov_nr_som_fertilizer(t,i,"marginal")                      = vm_nr_som_fertilizer.m(i);
 oq59_som_target_cropland(t,j,"marginal")                  = q59_som_target_cropland.m(j);
 oq59_som_target_noncropland(t,j,noncropland59,"marginal") = q59_som_target_noncropland.m(j,noncropland59);
 oq59_som_pool(t,j,land,"marginal")                        = q59_som_pool.m(j,land);
 oq59_nr_som(t,i,"marginal")                               = q59_nr_som.m(i);
 oq59_nr_som_fertilizer(t,i,"marginal")                    = q59_nr_som_fertilizer.m(i);
 oq59_nr_som_fertilizer2(t,i,"marginal")                   = q59_nr_som_fertilizer2.m(i);
 oq59_carbon_soil(t,j,land,stockType,"marginal")           = q59_carbon_soil.m(j,land,stockType);
 ov59_som_target(t,j,land,"level")                         = v59_som_target.l(j,land);
 ov59_som_pool(t,j,land,"level")                           = v59_som_pool.l(j,land);
 ov_nr_som(t,i,"level")                                    = vm_nr_som.l(i);
 ov_nr_som_fertilizer(t,i,"level")                         = vm_nr_som_fertilizer.l(i);
 oq59_som_target_cropland(t,j,"level")                     = q59_som_target_cropland.l(j);
 oq59_som_target_noncropland(t,j,noncropland59,"level")    = q59_som_target_noncropland.l(j,noncropland59);
 oq59_som_pool(t,j,land,"level")                           = q59_som_pool.l(j,land);
 oq59_nr_som(t,i,"level")                                  = q59_nr_som.l(i);
 oq59_nr_som_fertilizer(t,i,"level")                       = q59_nr_som_fertilizer.l(i);
 oq59_nr_som_fertilizer2(t,i,"level")                      = q59_nr_som_fertilizer2.l(i);
 oq59_carbon_soil(t,j,land,stockType,"level")              = q59_carbon_soil.l(j,land,stockType);
 ov59_som_target(t,j,land,"upper")                         = v59_som_target.up(j,land);
 ov59_som_pool(t,j,land,"upper")                           = v59_som_pool.up(j,land);
 ov_nr_som(t,i,"upper")                                    = vm_nr_som.up(i);
 ov_nr_som_fertilizer(t,i,"upper")                         = vm_nr_som_fertilizer.up(i);
 oq59_som_target_cropland(t,j,"upper")                     = q59_som_target_cropland.up(j);
 oq59_som_target_noncropland(t,j,noncropland59,"upper")    = q59_som_target_noncropland.up(j,noncropland59);
 oq59_som_pool(t,j,land,"upper")                           = q59_som_pool.up(j,land);
 oq59_nr_som(t,i,"upper")                                  = q59_nr_som.up(i);
 oq59_nr_som_fertilizer(t,i,"upper")                       = q59_nr_som_fertilizer.up(i);
 oq59_nr_som_fertilizer2(t,i,"upper")                      = q59_nr_som_fertilizer2.up(i);
 oq59_carbon_soil(t,j,land,stockType,"upper")              = q59_carbon_soil.up(j,land,stockType);
 ov59_som_target(t,j,land,"lower")                         = v59_som_target.lo(j,land);
 ov59_som_pool(t,j,land,"lower")                           = v59_som_pool.lo(j,land);
 ov_nr_som(t,i,"lower")                                    = vm_nr_som.lo(i);
 ov_nr_som_fertilizer(t,i,"lower")                         = vm_nr_som_fertilizer.lo(i);
 oq59_som_target_cropland(t,j,"lower")                     = q59_som_target_cropland.lo(j);
 oq59_som_target_noncropland(t,j,noncropland59,"lower")    = q59_som_target_noncropland.lo(j,noncropland59);
 oq59_som_pool(t,j,land,"lower")                           = q59_som_pool.lo(j,land);
 oq59_nr_som(t,i,"lower")                                  = q59_nr_som.lo(i);
 oq59_nr_som_fertilizer(t,i,"lower")                       = q59_nr_som_fertilizer.lo(i);
 oq59_nr_som_fertilizer2(t,i,"lower")                      = q59_nr_som_fertilizer2.lo(i);
 oq59_carbon_soil(t,j,land,stockType,"lower")              = q59_carbon_soil.lo(j,land,stockType);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
