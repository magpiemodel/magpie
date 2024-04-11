*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
 s61_cost_treecover_est          Tree cover establishment cost (USD per ha) / 2000 /
 s61_cost_treecover_recur        Tree cover recurring cost (USD per ha) / 500 /
 s61_treecover_plantation        Growth curve switch for tree cover on cropland 0=natveg 1=plantations (1) / 0 /
 s61_treecover_bii_coeff         BII coefficent to be used for tree cover on cropland 0=secondary vegetation 1=timber plantations (1) / 0 /
 s61_treecover_decrease          Cropland treecover can decrease (1) or not (0) / 0 /
 s61_treecover_scenario_start    Cropland treecover scenario start year       / 2020 /
 s61_treecover_scenario_target   Cropland treecover scenario target year      / 2050 /
 s61_treecover_min_shr           Share of treecover on cropland (1) / 0.2 /
 s61_betr_scenario_start         Bioenergy trees scenario start year       / 2020 /
 s61_betr_scenario_target        Bioenergy trees scenario target year      / 2050 /
 s61_betr_min_shr                Minimum share of bioenergy trees on cropland (1) / 0 /
;

********* AVAILABLE CROPLAND *******************************************

table f29_avl_cropland(j,marginal_land29) Available land area for cropland (mio. ha)
$ondelim
$include "./modules/29_cropland/input/avl_cropland.cs3"
$offdelim
;

table f29_avl_cropland_iso(iso,marginal_land29) Available land area for cropland at ISO level (mio. ha)
$ondelim
$include "./modules/29_cropland/input/avl_cropland_iso.cs3"
$offdelim
;

********* SNV TARGET CROPLAND *******************************************

table f29_snv_target_cropland(j,relocation_target29) Cropland in 2019 requiring relocation due to SNV policy (mio. ha)
$ondelim
$include "./modules/29_cropland/input/SNVTargetCropland.cs3"
$offdelim
;

********* Cropland tree cover *******************************************

parameter f29_treecover(j) Tree cover on cropland in 2019 (mio. ha)
/
$ondelim
$include "./modules/29_cropland/input/CroplandTreecover.cs2"
$offdelim
/
;
