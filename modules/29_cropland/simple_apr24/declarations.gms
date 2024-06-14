*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 p29_avl_cropland(t,j)              Total available land for crop cultivation (mio. ha)
 p29_country_weight(i)              Policy country weight per region (1)
 p29_snv_shr(t,j)                   Share of semi-natural vegetation in cropland areas (1)
 i29_snv_relocation_target(j)       Overall cropland area that requires relocation due to SNV policy (mio. ha)
 p29_snv_relocation(t,j)            Cropland area that is actually relocated during time step (mio. ha)
 p29_max_snv_relocation(t,j)        Maximum cropland relocation during time step (mio. ha)
 p29_country_dummy(iso)             Dummy parameter indicating whether country is affected by selected cropland policy (1)
 pm_avl_cropland_iso(iso)           Available land area for cropland at ISO level (mio. ha)
 i29_snv_scenario_fader(t_all)      SNV scenario fader (1)
;

positive variables
 vm_cost_cropland(j)                Cost for total cropland (mio. USD05MER per yr)
 vm_fallow(j)                       Fallow land is temporarily fallow cropland (mio. ha)
 vm_treecover(j)                    Cropland tree cover (mio. ha)
;

equations
 q29_cropland(j)                   Total cropland calculation (mio. ha)
 q29_avl_cropland(j)               Available cropland constraint (mio. ha)
 q29_carbon(j,ag_pools,stockType)  Cropland above ground carbon content calculation (mio. tC)
 q29_land_snv(j)                   Land constraint for the SNV policy in cropland areas (mio. ha)
 q29_land_snv_trans(j)             Land transition constraint for SNV policy in cropland areas (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_cropland(t,j,type)               Cost for total cropland (mio. USD05MER per yr)
 ov_fallow(t,j,type)                      Fallow land is temporarily fallow cropland (mio. ha)
 ov_treecover(t,j,type)                   Cropland tree cover (mio. ha)
 oq29_cropland(t,j,type)                  Total cropland calculation (mio. ha)
 oq29_avl_cropland(t,j,type)              Available cropland constraint (mio. ha)
 oq29_carbon(t,j,ag_pools,stockType,type) Cropland above ground carbon content calculation (mio. tC)
 oq29_land_snv(t,j,type)                  Land constraint for the SNV policy in cropland areas (mio. ha)
 oq29_land_snv_trans(t,j,type)            Land transition constraint for SNV policy in cropland areas (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

