*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

table f10_land(t_ini10,j,land) Different land type areas (mio. ha)
$ondelim
$include "./modules/10_land/input/avl_land_t.cs3"
$offdelim
;

table fm_luh2_side_layers(j,luh2_side_layers10) luh2 side layers (grid cell share)
$ondelim
$include "./modules/10_land/input/luh2_side_layers.cs3"
$offdelim
;

table f10_LUH2v2(t_all,j,f10_luh) Different land type areas (mio. ha)
$ondelim
$include "./modules/10_land/input/fm_LUH2v2.cs3"
$offdelim
;
