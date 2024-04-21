*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 p29_avl_cropland(t,j)              Total available land for crop cultivation (mio. ha)
;

positive variables
 vm_cost_cropland(j)                Cost for total cropland (mio. USD05MER per yr)
 vm_fallow(j)                       Fallow land is temporarily fallow cropland (mio. ha)
;

equations
 q29_cropland(j)                   Total cropland calculation (mio. ha)
 q29_avl_cropland(j)               Available cropland constraint (mio. ha)
 q29_carbon(j,ag_pools,stockType)  Cropland above ground carbon content calculation (mio. tC)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_cropland(t,j,type)               Cost for total cropland (mio. USD05MER per yr)
 ov_fallow(t,j,type)                      Fallow land is temporarily fallow cropland (mio. ha)
 oq29_cropland(t,j,type)                  Total cropland calculation (mio. ha)
 oq29_avl_cropland(t,j,type)              Available cropland constraint (mio. ha)
 oq29_carbon(t,j,ag_pools,stockType,type) Cropland above ground carbon content calculation (mio. tC)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

