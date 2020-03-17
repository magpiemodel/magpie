*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c30_bioen_type  all
* options: begr, betr, all

$setglobal c30_bioen_water  rainfed
* options: rainfed, irrigated, all

********* CROPAREA INITIALISATION **********************************************

table f30_croparea(t_past,j,kcr) Different croparea type areas (mio. ha)
$ondelim
$include "./modules/30_crop/endo_jun13/input/f30_croparea_initialisation.cs2"
$offdelim
;


********* CROP-ROTATIONAL CONSTRAINT *******************************************

parameter f30_rotation_max_shr(crp30) Maximum allowed area shares for each crop type (1)
/
$ondelim
$include "./modules/30_crop/endo_jun13/input/f30_rotation_max.csv"
$offdelim
/;

parameter f30_rotation_min_shr(crp30) Minimum allowed area shares for each crop type (1)
/
$ondelim
$include "./modules/30_crop/endo_jun13/input/f30_rotation_min.csv"
$offdelim
/;


********* SUITABILITY CONSTRAINT *******************************************

table f30_land_si(j,si) Land area suitable and non-suitable as cropland (mio. ha)
$ondelim
$include "./modules/30_crop/endo_jun13/input/avl_land_si.cs3"
$offdelim
;
