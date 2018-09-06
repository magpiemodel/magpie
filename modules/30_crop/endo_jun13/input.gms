*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

********* CROP-ROTATIONAL CONSTRAINT *******************************************

parameter f30_rotation_max_shr(crp30) Max allowed shares for each crop demand type (1)
/
$ondelim
$include "./modules/30_crop/endo_jun13/input/f30_rotation_max.csv"
$offdelim
/;

parameter f30_rotation_min_shr(crp30) Min allowed shares for each crop demand type (1)
/
$ondelim
$include "./modules/30_crop/endo_jun13/input/f30_rotation_min.csv"
$offdelim
/;


********* SUITABILITY CONSTRAINT *******************************************

table f30_land_si(j,si) suitable and non-suitable land (mio. ha)
$ondelim
$include "./modules/30_crop/endo_jun13/input/avl_land_si.cs3"
$offdelim
;


********* CROPAREA INITIALISATION *******************************************


table f30_croparea_initialisation(t_all,j,kcr) Initial croparea (Mha)
$ondelim
$include "./modules/38_factor_costs/sticky_feb18/input/f30_croparea_initialisation.cs3"
$offdelim
;
