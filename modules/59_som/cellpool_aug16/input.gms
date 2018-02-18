*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


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

table f59_som_initialisation_pools(t_all,j, pools59) Initialisation pools for soil organic carbon (Mt C)
$ondelim
$include "./modules/59_som/cellpool_aug16/input/f59_som_initialisation_pools.cs3"
$offdelim
;

$setglobal c59_som_scenario  nocc
*   options:   cc  (climate change)
*             nocc (no climate change)

parameters f59_topsoilc_density(t_all,j) LPJ topsoil carbon density for natural vegetation (tC per ha)
/
$ondelim
$include "./modules/59_som/cellpool_aug16/input/lpj_carbon_topsoil.cs2"
$offdelim
/
;
$if "%c59_som_scenario%" == "nocc" f59_topsoilc_density(t_all,j) = f59_topsoilc_density("y1995",j);
m_fillmissingyears(f59_topsoilc_density,"j");



