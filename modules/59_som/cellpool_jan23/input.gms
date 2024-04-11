*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
  s59_nitrogen_uptake  Maximum plant available nitrogen from soil organic matter loss (tN per ha)        / 0.2 /
;

table f59_cratio_landuse(i,climate59_2019,kcr) Ratio of soil carbon relative to potential natural vegetation soil carbon for different landuse (1)
$ondelim
$include "./modules/59_som/cellpool_jan23/input/f59_ch5_F_LU_2019reg.cs3"
$offdelim
;

table f59_cratio_tillage(climate59,tillage59) Ratio of soil carbon relative to potential natural vegetation soil carbon for different soil management (1)
$ondelim
$include "./modules/59_som/cellpool_jan23/input/f59_ch5_F_MG.csv"
$offdelim
;

table f59_cratio_inputs(climate59,inputs59) Ratio of soil carbon relative to potential natural vegetation soil carbon for different input intensity  (1)
$ondelim
$include "./modules/59_som/cellpool_jan23/input/f59_ch5_F_I.csv"
$offdelim
;

$setglobal c59_irrigation_scenario  on
*   options:   on  (higher carbon sequestration under irrigation)
*              off (no carbon sequestration under irrigation)

table f59_cratio_irrigation(climate59,w,kcr) Ratio of soil carbon relative to potential natural vegetation soil carbon for different irrigation schemes  (1)
$ondelim
$include "./modules/59_som/cellpool_jan23/input/f59_ch5_F_IRR.cs3"
$offdelim
;
$if "%c59_irrigation_scenario%" == "off" f59_cratio_irrigation(climate59,w,kcr) = 1;

$setglobal c59_som_scenario  cc
*   options:  cc        (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)

parameters f59_topsoilc_density(t_all,j) LPJ topsoil carbon density for natural vegetation (tC per ha)
/
$ondelim
$include "./modules/59_som/input/lpj_carbon_topsoil.cs2b"
$offdelim
/
;
$if "%c59_som_scenario%" == "nocc" f59_topsoilc_density(t_all,j) = f59_topsoilc_density("y1995",j);
$if "%c59_som_scenario%" == "nocc_hist" f59_topsoilc_density(t_all,j)$(m_year(t_all) > sm_fix_cc) = f59_topsoilc_density(t_all,j)$(m_year(t_all) = sm_fix_cc);
m_fillmissingyears(f59_topsoilc_density,"j");
