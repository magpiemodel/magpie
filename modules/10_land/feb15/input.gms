*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

scalars
  s10_lu_miti_shr  share of each grid-cell that can be used for land-based mitigation  / 1 /
;

table f10_land(j,land,si) Different land type areas (si0 and nsi0) [mio. ha]
$ondelim
$include "./modules/10_land/input/avl_land.cs3"
$offdelim
;
