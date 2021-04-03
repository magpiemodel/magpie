*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c30_bioen_type  all
* options: begr, betr, all

$setglobal c30_bioen_water  rainfed
* options: rainfed, irrigated, all

$setglobal c30_marginal_land  all_marginal
* options: all_marginal, half_marginal, no_marginal

$setglobal c30_set_aside_target  none
* options: none, by2030, by2020

********* CROPAREA INITIALISATION **********************************************

table f30_croparea(t_past,j,kcr) Different croparea type areas (mio. ha)
$ondelim
$include "./modules/30_crop/endo_apr21/input/f30_croparea_initialisation.cs2"
$offdelim
;


********* CROP-ROTATIONAL CONSTRAINT *******************************************

parameter f30_rotation_max_shr(crp30) Maximum allowed area shares for each crop type (1)
/
$ondelim
$include "./modules/30_crop/endo_apr21/input/f30_rotation_max.csv"
$offdelim
/;

parameter f30_rotation_min_shr(crp30) Minimum allowed area shares for each crop type (1)
/
$ondelim
$include "./modules/30_crop/endo_apr21/input/f30_rotation_min.csv"
$offdelim
/;


********* AVAILABLE CROPLAND *******************************************

scalar
s30_set_aside_shr   Share of available cropland that is witheld for other land cover types / 0 /
;

table f30_avl_cropland(j,marginal_land30) Available land area for cropland (mio. ha)
$ondelim
$include "./modules/30_crop/endo_apr21/input/avl_cropland.cs3"
$offdelim
;

table f30_set_aside_fader(t_all,set_aside_target30) Fader for share of set aside cropland
$ondelim
$include "./modules/30_crop/endo_apr21/input/f30_set_aside_fader.csv"
$offdelim
;
