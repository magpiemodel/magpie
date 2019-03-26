*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalars
  s59_punish_cropdiff  Punishment costs per croparea squared (USD05MER per mio. per ha^2)                / 100000000 /
  s59_nitrogen_uptake  Maximum plant available nitrogen from soil organic matter loss (tN per ha)        / 0.2 /
;

table f59_cratio_landuse(climate59,kcr) Ratio of soil carbon relative to potential natural vegetation soil carbon for different landuse (1)
$ondelim
$include "./modules/59_som/cellpool_aug16/input/f59_ch5_F_LU.csv"
$offdelim
;

table f59_cratio_tillage(climate59,tillage59) Ratio of soil carbon relative to potential natural vegetation soil carbon for different soil management (1)
$ondelim
$include "./modules/59_som/cellpool_aug16/input/f59_ch5_F_MG.csv"
$offdelim
;

table f59_cratio_inputs(climate59,inputs59) Ratio of soil carbon relative to potential natural vegetation soil carbon for different input intensity  (1)
$ondelim
$include "./modules/59_som/cellpool_aug16/input/f59_ch5_F_I.csv"
$offdelim
;

table f59_cratio_irrigation(climate59,w,kcr) Ratio of soil carbon relative to potential natural vegetation soil carbon for different irrigation schemes  (1)
$ondelim
$include "./modules/59_som/cellpool_aug16/input/f59_ch5_F_IRR.cs3"
$offdelim
;


table f59_som_initialisation_pools(t_all,j,pools59) Initialisation pools for soil organic carbon (mio. tC)
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
$include "./modules/59_som/input/lpj_carbon_topsoil.cs2"
$offdelim
/
;
$if "%c59_som_scenario%" == "nocc" f59_topsoilc_density(t_all,j) = f59_topsoilc_density("y1995",j);
m_fillmissingyears(f59_topsoilc_density,"j");
