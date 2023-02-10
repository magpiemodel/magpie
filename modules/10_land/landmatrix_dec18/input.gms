*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
  s10_cost_balance Artificial cost for balance variable (USD05MER per ha) / 1e+06 /
;

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

table fm_land_iso(t_ini10,iso,land) Land area for different land pools at ISO level (mio. ha)
$ondelim
$include "./modules/10_land/input/avl_land_t_iso.cs3"
$offdelim
;
