*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

scalars
  s33_save_ifft share of FRA2010 forest protection share applicable to ifft    / 0.75 /
  s33_deforest_policy Switch for upper limit on deforestation based on historic deforestation rates    / 0 /
;

table f33_ifft(j,si) ifft forest area [mio. ha]
$ondelim
$include "./modules/33_forest/input/avl_land_ifft.cs2"
$offdelim;

parameter f33_save_fore_prod(i) Share of total forest area designated for production [1] (FRA2010)
/
$ondelim
$include "./modules/33_forest/input/f33_save_fore_prod.cs4"
$offdelim
/;

parameter f33_deforest_policy(t_all) relative reduction in annual deforestation rate [baseyear 2010]
/
$ondelim
$include "./modules/33_forest/endo_threshold_aug15/input/f33_deforest_policy.csv"
$offdelim
/;

$setglobal c33_forest_protection  medium

table f33_fore_protect(t_all,i,scen33) Share of total forest area designated for protection [1]
$ondelim
$include "./modules/33_forest/input/f33_save_fore_protect.cs3"
$offdelim
;

table f33_fore_protect_scen(t_all,scen33) relative forest protection target in 2100 wrt to 2010 [1]
$ondelim
$include "./modules/33_forest/input/f33_fore_protect_scen.cs3"
$offdelim
;

table fm_forest_change(t_all,i) annual historic deforestation rate (constant after 2010) [Mha per year] (FRA2010)
$ondelim
$include "./modules/33_forest/input/fm_forest_change.csv"
$offdelim
;
