*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

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
