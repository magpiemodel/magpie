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

parameter f30_rotation_min_shr(crp30) Max allowed shares for each crop demand type (1)
/
$ondelim
$include "./modules/30_crop/endo_jun13/input/f30_rotation_min.csv"
$offdelim
/;

table f30_land_si(j,si) si0 and nsi0 land [mio. ha]
$ondelim
$include "./modules/30_crop/endo_jun13/input/avl_land_si.cs3"
$offdelim
;
