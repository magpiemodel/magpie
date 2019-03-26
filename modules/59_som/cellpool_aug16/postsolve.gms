*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

p59_som_pool(j,pools59) = v59_som_pool.l(j,pools59);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov59_som_target(t,j,pools59,"marginal")       = v59_som_target.m(j,pools59);
 ov59_som_pool(t,j,pools59,"marginal")         = v59_som_pool.m(j,pools59);
 ov59_som_transfer_to_cropland(t,j,"marginal") = v59_som_transfer_to_cropland.m(j);
 ov_nr_som(t,j,"marginal")                     = vm_nr_som.m(j);
 ov_nr_som_fertilizer(t,j,"marginal")          = vm_nr_som_fertilizer.m(j);
 oq59_som_target_cropland(t,j,"marginal")      = q59_som_target_cropland.m(j);
 oq59_som_target_noncropland(t,j,"marginal")   = q59_som_target_noncropland.m(j);
 oq59_som_transfer_to_cropland(t,j,"marginal") = q59_som_transfer_to_cropland.m(j);
 oq59_som_pool_cropland(t,j,"marginal")        = q59_som_pool_cropland.m(j);
 oq59_som_pool_noncropland(t,j,"marginal")     = q59_som_pool_noncropland.m(j);
 oq59_nr_som(t,j,"marginal")                   = q59_nr_som.m(j);
 oq59_nr_som_fertilizer(t,j,"marginal")        = q59_nr_som_fertilizer.m(j);
 oq59_nr_som_fertilizer2(t,j,"marginal")       = q59_nr_som_fertilizer2.m(j);
 oq59_carbon_soil(t,j,"marginal")              = q59_carbon_soil.m(j);
 ov59_som_target(t,j,pools59,"level")          = v59_som_target.l(j,pools59);
 ov59_som_pool(t,j,pools59,"level")            = v59_som_pool.l(j,pools59);
 ov59_som_transfer_to_cropland(t,j,"level")    = v59_som_transfer_to_cropland.l(j);
 ov_nr_som(t,j,"level")                        = vm_nr_som.l(j);
 ov_nr_som_fertilizer(t,j,"level")             = vm_nr_som_fertilizer.l(j);
 oq59_som_target_cropland(t,j,"level")         = q59_som_target_cropland.l(j);
 oq59_som_target_noncropland(t,j,"level")      = q59_som_target_noncropland.l(j);
 oq59_som_transfer_to_cropland(t,j,"level")    = q59_som_transfer_to_cropland.l(j);
 oq59_som_pool_cropland(t,j,"level")           = q59_som_pool_cropland.l(j);
 oq59_som_pool_noncropland(t,j,"level")        = q59_som_pool_noncropland.l(j);
 oq59_nr_som(t,j,"level")                      = q59_nr_som.l(j);
 oq59_nr_som_fertilizer(t,j,"level")           = q59_nr_som_fertilizer.l(j);
 oq59_nr_som_fertilizer2(t,j,"level")          = q59_nr_som_fertilizer2.l(j);
 oq59_carbon_soil(t,j,"level")                 = q59_carbon_soil.l(j);
 ov59_som_target(t,j,pools59,"upper")          = v59_som_target.up(j,pools59);
 ov59_som_pool(t,j,pools59,"upper")            = v59_som_pool.up(j,pools59);
 ov59_som_transfer_to_cropland(t,j,"upper")    = v59_som_transfer_to_cropland.up(j);
 ov_nr_som(t,j,"upper")                        = vm_nr_som.up(j);
 ov_nr_som_fertilizer(t,j,"upper")             = vm_nr_som_fertilizer.up(j);
 oq59_som_target_cropland(t,j,"upper")         = q59_som_target_cropland.up(j);
 oq59_som_target_noncropland(t,j,"upper")      = q59_som_target_noncropland.up(j);
 oq59_som_transfer_to_cropland(t,j,"upper")    = q59_som_transfer_to_cropland.up(j);
 oq59_som_pool_cropland(t,j,"upper")           = q59_som_pool_cropland.up(j);
 oq59_som_pool_noncropland(t,j,"upper")        = q59_som_pool_noncropland.up(j);
 oq59_nr_som(t,j,"upper")                      = q59_nr_som.up(j);
 oq59_nr_som_fertilizer(t,j,"upper")           = q59_nr_som_fertilizer.up(j);
 oq59_nr_som_fertilizer2(t,j,"upper")          = q59_nr_som_fertilizer2.up(j);
 oq59_carbon_soil(t,j,"upper")                 = q59_carbon_soil.up(j);
 ov59_som_target(t,j,pools59,"lower")          = v59_som_target.lo(j,pools59);
 ov59_som_pool(t,j,pools59,"lower")            = v59_som_pool.lo(j,pools59);
 ov59_som_transfer_to_cropland(t,j,"lower")    = v59_som_transfer_to_cropland.lo(j);
 ov_nr_som(t,j,"lower")                        = vm_nr_som.lo(j);
 ov_nr_som_fertilizer(t,j,"lower")             = vm_nr_som_fertilizer.lo(j);
 oq59_som_target_cropland(t,j,"lower")         = q59_som_target_cropland.lo(j);
 oq59_som_target_noncropland(t,j,"lower")      = q59_som_target_noncropland.lo(j);
 oq59_som_transfer_to_cropland(t,j,"lower")    = q59_som_transfer_to_cropland.lo(j);
 oq59_som_pool_cropland(t,j,"lower")           = q59_som_pool_cropland.lo(j);
 oq59_som_pool_noncropland(t,j,"lower")        = q59_som_pool_noncropland.lo(j);
 oq59_nr_som(t,j,"lower")                      = q59_nr_som.lo(j);
 oq59_nr_som_fertilizer(t,j,"lower")           = q59_nr_som_fertilizer.lo(j);
 oq59_nr_som_fertilizer2(t,j,"lower")          = q59_nr_som_fertilizer2.lo(j);
 oq59_carbon_soil(t,j,"lower")                 = q59_carbon_soil.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
