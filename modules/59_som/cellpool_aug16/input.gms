*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


table f59_cratio_landuse(climate59,kcr) ratio of soil c SOM relative to natural vegetation soilcs for different landuse
$ondelim
$include "./modules/59_som/cellpool_aug16/input/f59_ch5_F_LU.csv"
$offdelim
;

table f59_cratio_tillage(climate59,tillage59) ratio of soil c SOM relative to natural vegetation soilcs for different soil management
$ondelim
$include "./modules/59_som/cellpool_aug16/input/f59_ch5_F_MG.csv"
$offdelim
;

table f59_cratio_inputs(climate59,inputs59) ratio of soil c SOM relative to natural vegetation soilcs for different input intensity
$ondelim
$include "./modules/59_som/cellpool_aug16/input/f59_ch5_F_I.csv"
$offdelim
;
