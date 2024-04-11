*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
 s29_shift number of 5-year age-classes corresponding to current time step length (1)
;


parameters
 p29_avl_cropland(t,j)              Total available land for crop cultivation (mio. ha)
 p29_country_snv_weight(i)          SNV policy country weight per region (1)
 p29_snv_shr(t,j)                   Share of semi-natural vegetation in cropland areas (1)
 i29_snv_relocation_target(j)       Overall cropland area that requires relocation due to SNV policy (mio. ha)
 p29_snv_relocation(t,j)            Cropland area that is actually relocated during time step (mio. ha)
 p29_max_snv_relocation(t,j)        Maximum cropland relocation during time step (mio. ha)
 p29_country_dummy(iso)             Dummy parameter indicating whether country is affected by selected cropland policy (1)
 i29_avl_cropland_iso(iso)          Available land area for cropland at ISO level (mio. ha)
 p29_snv_scenario_fader(t_all)      SNV scenario fader (1)
 p29_rotation_scenario_fader(t_all) Crop rotation scenario fader (1)


 p29_treecover_min_shr(t,j)           Minimum share of treecover on cropland (1)
 p29_betr_min_shr(t,j)                Minimum share of bioenergy trees on cropland (1)
 p29_treecover_scenario_fader(t_all)  Cropland treecover scenario fader (1)
 p29_betr_scenario_fader(t_all)       Bioenergy trees scenario fader (1)
 p29_treecover_bii_coeff(bii_class_secd,potnatveg)  BII coefficient for cropland treecover (1)
 p29_carbon_density_ac(t,j,ac,ag_pools) Carbon density for ac and ag_pools (tC per ha)
 p29_treecover(t,j,ac)                  Cropland tree cover per age class (mio. ha)
 pc29_treecover(j,ac)                   Cropland tree cover per age class in current time step (mio. ha)
;

positive variables
 vm_fallow(j)                       Fallow land is temporarily fallow cropland (mio. ha)
 v29_treecover(j,ac)                Cropland tree cover per age class (mio. ha)
;

equations
 q29_cropland(j)                    Total cropland calculation (mio. ha)
 q29_avl_cropland(j)                Available cropland constraint (mio. ha)
 q29_rotation_max(j,crp29,w)        Local maximum rotational constraints (mio. ha)
 q29_rotation_min(j,crp29,w)        Local minimum rotational constraints (mio. ha)
 q29_prod(j,kcr)                    Production of cropped products (mio. tDM)
 q29_carbon(j,ag_pools,stockType)   Cropland above ground carbon content calculation (mio. tC)
 q29_bv_ann(j,potnatveg)            Biodiversity value of annual cropland (mio. ha)
 q29_bv_per(j,potnatveg)            Biodiversity value of perennial cropland (mio. ha)
 q29_land_snv(j)                    Land constraint for the SNV policy in cropland areas (mio. ha)
 q29_land_snv_trans(j)              Land transition constraint for SNV policy in cropland areas (mio. ha)
;
