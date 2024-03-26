*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

variables
 vm_cost_agroforestry(j) Cost and rewards related to agroforestry (mio. USD05MER per yr)
;

positive variables
 vm_treecover_area(j)             Cropland tree cover (mio. ha)
 vm_treecover_carbon(j,ag_pools,stockType) Cropland tree cover above ground carbon content (mio. tC)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_agroforestry(t,j,type)                   Cost and rewards related to agroforestry (mio. USD05MER per yr)
 ov_treecover_area(t,j,type)                      Cropland tree cover (mio. ha)
 ov_treecover_carbon(t,j,ag_pools,stockType,type) Cropland tree cover above ground carbon content (mio. tC)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

