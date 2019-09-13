*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

p59_som_pool(j,pools59) = v59_som_pool.l(j,pools59);
                 

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov59_som_target(t,j,pools59,"marginal")                     = v59_som_target.m(j,pools59);
 ov59_som_pool(t,j,pools59,"marginal")                       = v59_som_pool.m(j,pools59);
 ov59_som_transfer_to_cropland(t,j,noncropland59,"marginal") = v59_som_transfer_to_cropland.m(j,noncropland59);
 ov_nr_som(t,j,"marginal")                                   = vm_nr_som.m(j);
 ov_nr_som_fertilizer(t,j,"marginal")                        = vm_nr_som_fertilizer.m(j);
 oq59_som_target_cropland(t,j,"marginal")                    = q59_som_target_cropland.m(j);
 oq59_som_target_noncropland(t,j,noncropland59,"marginal")   = q59_som_target_noncropland.m(j,noncropland59);
 oq59_som_transfer_to_cropland(t,j,noncropland59,"marginal") = q59_som_transfer_to_cropland.m(j,noncropland59);
 oq59_som_pool_cropland(t,j,"marginal")                      = q59_som_pool_cropland.m(j);
 oq59_som_pool_noncropland(t,j,noncropland59,"marginal")     = q59_som_pool_noncropland.m(j,noncropland59);
 oq59_nr_som(t,j,"marginal")                                 = q59_nr_som.m(j);
 oq59_nr_som_fertilizer(t,j,"marginal")                      = q59_nr_som_fertilizer.m(j);
 oq59_nr_som_fertilizer2(t,j,"marginal")                     = q59_nr_som_fertilizer2.m(j);
 oq59_carbon_soil(t,j,pools59,"marginal")                    = q59_carbon_soil.m(j,pools59);
 ov59_som_target(t,j,pools59,"level")                        = v59_som_target.l(j,pools59);
 ov59_som_pool(t,j,pools59,"level")                          = v59_som_pool.l(j,pools59);
 ov59_som_transfer_to_cropland(t,j,noncropland59,"level")    = v59_som_transfer_to_cropland.l(j,noncropland59);
 ov_nr_som(t,j,"level")                                      = vm_nr_som.l(j);
 ov_nr_som_fertilizer(t,j,"level")                           = vm_nr_som_fertilizer.l(j);
 oq59_som_target_cropland(t,j,"level")                       = q59_som_target_cropland.l(j);
 oq59_som_target_noncropland(t,j,noncropland59,"level")      = q59_som_target_noncropland.l(j,noncropland59);
 oq59_som_transfer_to_cropland(t,j,noncropland59,"level")    = q59_som_transfer_to_cropland.l(j,noncropland59);
 oq59_som_pool_cropland(t,j,"level")                         = q59_som_pool_cropland.l(j);
 oq59_som_pool_noncropland(t,j,noncropland59,"level")        = q59_som_pool_noncropland.l(j,noncropland59);
 oq59_nr_som(t,j,"level")                                    = q59_nr_som.l(j);
 oq59_nr_som_fertilizer(t,j,"level")                         = q59_nr_som_fertilizer.l(j);
 oq59_nr_som_fertilizer2(t,j,"level")                        = q59_nr_som_fertilizer2.l(j);
 oq59_carbon_soil(t,j,pools59,"level")                       = q59_carbon_soil.l(j,pools59);
 ov59_som_target(t,j,pools59,"upper")                        = v59_som_target.up(j,pools59);
 ov59_som_pool(t,j,pools59,"upper")                          = v59_som_pool.up(j,pools59);
 ov59_som_transfer_to_cropland(t,j,noncropland59,"upper")    = v59_som_transfer_to_cropland.up(j,noncropland59);
 ov_nr_som(t,j,"upper")                                      = vm_nr_som.up(j);
 ov_nr_som_fertilizer(t,j,"upper")                           = vm_nr_som_fertilizer.up(j);
 oq59_som_target_cropland(t,j,"upper")                       = q59_som_target_cropland.up(j);
 oq59_som_target_noncropland(t,j,noncropland59,"upper")      = q59_som_target_noncropland.up(j,noncropland59);
 oq59_som_transfer_to_cropland(t,j,noncropland59,"upper")    = q59_som_transfer_to_cropland.up(j,noncropland59);
 oq59_som_pool_cropland(t,j,"upper")                         = q59_som_pool_cropland.up(j);
 oq59_som_pool_noncropland(t,j,noncropland59,"upper")        = q59_som_pool_noncropland.up(j,noncropland59);
 oq59_nr_som(t,j,"upper")                                    = q59_nr_som.up(j);
 oq59_nr_som_fertilizer(t,j,"upper")                         = q59_nr_som_fertilizer.up(j);
 oq59_nr_som_fertilizer2(t,j,"upper")                        = q59_nr_som_fertilizer2.up(j);
 oq59_carbon_soil(t,j,pools59,"upper")                       = q59_carbon_soil.up(j,pools59);
 ov59_som_target(t,j,pools59,"lower")                        = v59_som_target.lo(j,pools59);
 ov59_som_pool(t,j,pools59,"lower")                          = v59_som_pool.lo(j,pools59);
 ov59_som_transfer_to_cropland(t,j,noncropland59,"lower")    = v59_som_transfer_to_cropland.lo(j,noncropland59);
 ov_nr_som(t,j,"lower")                                      = vm_nr_som.lo(j);
 ov_nr_som_fertilizer(t,j,"lower")                           = vm_nr_som_fertilizer.lo(j);
 oq59_som_target_cropland(t,j,"lower")                       = q59_som_target_cropland.lo(j);
 oq59_som_target_noncropland(t,j,noncropland59,"lower")      = q59_som_target_noncropland.lo(j,noncropland59);
 oq59_som_transfer_to_cropland(t,j,noncropland59,"lower")    = q59_som_transfer_to_cropland.lo(j,noncropland59);
 oq59_som_pool_cropland(t,j,"lower")                         = q59_som_pool_cropland.lo(j);
 oq59_som_pool_noncropland(t,j,noncropland59,"lower")        = q59_som_pool_noncropland.lo(j,noncropland59);
 oq59_nr_som(t,j,"lower")                                    = q59_nr_som.lo(j);
 oq59_nr_som_fertilizer(t,j,"lower")                         = q59_nr_som_fertilizer.lo(j);
 oq59_nr_som_fertilizer2(t,j,"lower")                        = q59_nr_som_fertilizer2.lo(j);
 oq59_carbon_soil(t,j,pools59,"lower")                       = q59_carbon_soil.lo(j,pools59);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

