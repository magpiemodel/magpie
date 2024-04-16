*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c30_bioen_type  all
* options: begr, betr, all

$setglobal c30_bioen_water  rainfed
* options: rainfed, irrigated, all

$setglobal c30_rotation_constraints  on
*options: on, off

scalars
 s30_rotation_scenario_start     Rotation scenario start year      / 2020 /
 s30_rotation_scenario_target    Rotation scenario target year     / 2050 /
 s30_betr_min_shr                Minimum share of bioenergy trees on cropland (1) / 0 /
 s30_betr_scenario_start         Bioenergy trees scenario start year       / 2020 /
 s30_betr_scenario_target        Bioenergy trees scenario target year      / 2050 /
;

$ifthen "%c30_bioen_type%" == "all" bioen_type_30(kbe30) = yes;
$else bioen_type_30("%c30_bioen_type%") = yes;
$endif

$ifthen "%c30_bioen_water%" == "all" bioen_water_30(w) = yes;
$else bioen_water_30("%c30_bioen_water%") = yes;
$endif

********* CROPAREA INITIALISATION **********************************************

table fm_croparea(t_all,j,w,kcr) Different croparea type areas (mio. ha)
$ondelim
$include "./modules/30_crop/endo_apr21/input/f30_croparea_w_initialisation.cs3"
$offdelim
;
m_fillmissingyears(fm_croparea,"j,w,kcr");

********* CROP-ROTATIONAL CONSTRAINT *******************************************

parameter f30_rotation_max_shr(crp30) Maximum allowed area shares for each crop type (1)
/
$ondelim
$include "./modules/30_crop/endo_apr21/input/f30_rotation_max.csv"
$offdelim
/;
$if "%c30_rotation_constraints%" == "off" f30_rotation_max_shr(crp30) = 1;


parameter f30_rotation_min_shr(crp30) Minimum allowed area shares for each crop type (1)
/
$ondelim
$include "./modules/30_crop/endo_apr21/input/f30_rotation_min.csv"
$offdelim
/;
$if "%c30_rotation_constraints%" == "off" f30_rotation_min_shr(crp30) = 0;

