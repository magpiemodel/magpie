*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

p59_som_pool(j,pools59) = v59_som_pool.l(j,pools59);
                 

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov59_som_target(t,j,pools59,"marginal")       = v59_som_target.m(j,pools59);
 ov59_som_pool(t,j,pools59,"marginal")         = v59_som_pool.m(j,pools59);
 ov59_crop_expansion(t,j,"marginal")           = v59_crop_expansion.m(j);
 ov59_crop_reduction(t,j,"marginal")           = v59_crop_reduction.m(j);
 ov59_som_transfer_to_cropland(t,j,"marginal") = v59_som_transfer_to_cropland.m(j);
 ov_nr_som(t,j,"marginal")                     = vm_nr_som.m(j);
 ov_costs_overrate_cropdiff(t,i,"marginal")    = vm_costs_overrate_cropdiff.m(i);
 oq59_som_target_cropland(t,j,"marginal")      = q59_som_target_cropland.m(j);
 oq59_som_target_noncropland(t,j,"marginal")   = q59_som_target_noncropland.m(j);
 oq59_som_transfer_to_cropland(t,j,"marginal") = q59_som_transfer_to_cropland.m(j);
 oq59_som_pool_cropland(t,j,"marginal")        = q59_som_pool_cropland.m(j);
 oq59_som_pool_noncropland(t,j,"marginal")     = q59_som_pool_noncropland.m(j);
 oq59_nr_som(t,j,"marginal")                   = q59_nr_som.m(j);
 oq59_crop_diff(t,j,"marginal")                = q59_crop_diff.m(j);
 oq59_crop_diff_constraint(t,i,"marginal")     = q59_crop_diff_constraint.m(i);
 ov59_som_target(t,j,pools59,"level")          = v59_som_target.l(j,pools59);
 ov59_som_pool(t,j,pools59,"level")            = v59_som_pool.l(j,pools59);
 ov59_crop_expansion(t,j,"level")              = v59_crop_expansion.l(j);
 ov59_crop_reduction(t,j,"level")              = v59_crop_reduction.l(j);
 ov59_som_transfer_to_cropland(t,j,"level")    = v59_som_transfer_to_cropland.l(j);
 ov_nr_som(t,j,"level")                        = vm_nr_som.l(j);
 ov_costs_overrate_cropdiff(t,i,"level")       = vm_costs_overrate_cropdiff.l(i);
 oq59_som_target_cropland(t,j,"level")         = q59_som_target_cropland.l(j);
 oq59_som_target_noncropland(t,j,"level")      = q59_som_target_noncropland.l(j);
 oq59_som_transfer_to_cropland(t,j,"level")    = q59_som_transfer_to_cropland.l(j);
 oq59_som_pool_cropland(t,j,"level")           = q59_som_pool_cropland.l(j);
 oq59_som_pool_noncropland(t,j,"level")        = q59_som_pool_noncropland.l(j);
 oq59_nr_som(t,j,"level")                      = q59_nr_som.l(j);
 oq59_crop_diff(t,j,"level")                   = q59_crop_diff.l(j);
 oq59_crop_diff_constraint(t,i,"level")        = q59_crop_diff_constraint.l(i);
 ov59_som_target(t,j,pools59,"upper")          = v59_som_target.up(j,pools59);
 ov59_som_pool(t,j,pools59,"upper")            = v59_som_pool.up(j,pools59);
 ov59_crop_expansion(t,j,"upper")              = v59_crop_expansion.up(j);
 ov59_crop_reduction(t,j,"upper")              = v59_crop_reduction.up(j);
 ov59_som_transfer_to_cropland(t,j,"upper")    = v59_som_transfer_to_cropland.up(j);
 ov_nr_som(t,j,"upper")                        = vm_nr_som.up(j);
 ov_costs_overrate_cropdiff(t,i,"upper")       = vm_costs_overrate_cropdiff.up(i);
 oq59_som_target_cropland(t,j,"upper")         = q59_som_target_cropland.up(j);
 oq59_som_target_noncropland(t,j,"upper")      = q59_som_target_noncropland.up(j);
 oq59_som_transfer_to_cropland(t,j,"upper")    = q59_som_transfer_to_cropland.up(j);
 oq59_som_pool_cropland(t,j,"upper")           = q59_som_pool_cropland.up(j);
 oq59_som_pool_noncropland(t,j,"upper")        = q59_som_pool_noncropland.up(j);
 oq59_nr_som(t,j,"upper")                      = q59_nr_som.up(j);
 oq59_crop_diff(t,j,"upper")                   = q59_crop_diff.up(j);
 oq59_crop_diff_constraint(t,i,"upper")        = q59_crop_diff_constraint.up(i);
 ov59_som_target(t,j,pools59,"lower")          = v59_som_target.lo(j,pools59);
 ov59_som_pool(t,j,pools59,"lower")            = v59_som_pool.lo(j,pools59);
 ov59_crop_expansion(t,j,"lower")              = v59_crop_expansion.lo(j);
 ov59_crop_reduction(t,j,"lower")              = v59_crop_reduction.lo(j);
 ov59_som_transfer_to_cropland(t,j,"lower")    = v59_som_transfer_to_cropland.lo(j);
 ov_nr_som(t,j,"lower")                        = vm_nr_som.lo(j);
 ov_costs_overrate_cropdiff(t,i,"lower")       = vm_costs_overrate_cropdiff.lo(i);
 oq59_som_target_cropland(t,j,"lower")         = q59_som_target_cropland.lo(j);
 oq59_som_target_noncropland(t,j,"lower")      = q59_som_target_noncropland.lo(j);
 oq59_som_transfer_to_cropland(t,j,"lower")    = q59_som_transfer_to_cropland.lo(j);
 oq59_som_pool_cropland(t,j,"lower")           = q59_som_pool_cropland.lo(j);
 oq59_som_pool_noncropland(t,j,"lower")        = q59_som_pool_noncropland.lo(j);
 oq59_nr_som(t,j,"lower")                      = q59_nr_som.lo(j);
 oq59_crop_diff(t,j,"lower")                   = q59_crop_diff.lo(j);
 oq59_crop_diff_constraint(t,i,"lower")        = q59_crop_diff_constraint.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

