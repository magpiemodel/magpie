*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

table f33_ifft(j,si) ifft forest area [mio. ha]
$ondelim
$include "./modules/33_forest/input/avl_land_ifft.cs2"
$offdelim;

table fm_forest_change(t_all,i) annual historic deforestation rate (constant after 2010) [Mha per year] (FRA2010)
$ondelim
$include "./modules/33_forest/input/fm_forest_change.csv"
$offdelim
;
