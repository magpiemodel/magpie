*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
  s59_nitrogen_uptake  Maximum plant available nitrogen from soil organic matter loss (tN per ha)        / 0.2 /
;

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
$if "%c59_som_scenario%" == "nocc_hist" f59_topsoilc_density(t_all,j)$(m_year(t_all) > sm_fix_cc) = f59_topsoilc_density(t_all,j)$(m_year(t_ai) = sm_fix_cc);
m_fillmissingyears(f59_topsoilc_density,"j");


table f59_cinput_multiplier_residue(i,sPools59,kcr,tillage59) LPJ topsoil carbon density for natural vegetation (tC per ha)
$ondelim
$include "./modules/59_som/threepool_may23/input/f59_cinput_multiplier_residue.cs3"
$offdelim
;

table f59_cinput_multiplier_manure(i,sPools59,kli,tillage59) LPJ topsoil carbon density for natural vegetation (tC per ha)
$ondelim
$include "./modules/59_som/threepool_may23/input/f59_cinput_multiplier_manure.cs3"
$offdelim
;


table f59_litter_input(t_all,i,sPools59) LPJ topsoil carbon density for natural vegetation (tC per ha)
$ondelim
$include "./modules/59_som/threepool_may23/input/f59_litter_input.cs3"
$offdelim
;
$if "%c59_som_scenario%" == "nocc" 
  f59_litter_input(t_all,i,sPools59) = f59_litter_input("y1995",i,sPools59);
$if "%c59_som_scenario%" == "nocc_hist" 
  f59_litter_input(t_all,i,sPools59)$(m_year(t_all) > sm_fix_cc) = f59_litter_input(t_all,i,sPools59)$(m_year(t_ai) = sm_fix_cc);
m_fillmissingyears(f59_litter_input,"i,sPools59");


table f59_topsoilc_decay(t_all,i,sPools59,w,tillage59) Soil decay rates for all SOC sub-pools per year (1)
$ondelim
$include "./modules/59_som/threepool_may23/input/f59_topsoilc_decay.cs3"
$offdelim
;
$if "%c59_som_scenario%" == "nocc" 
  f59_topsoilc_decay(t_all,i,sPools59,w,tillage59) = f59_topsoilc_decay("y1995",i,sPools59,w,tillage59);
$if "%c59_som_scenario%" == "nocc_hist" 
  f59_topsoilc_decay(t_all,i,sPools59,w,tillage59)$(m_year(t_all) > sm_fix_cc) = f59_topsoilc_decay(t_all,i,sPools59,w,tillage59)$(m_year(t_ai) = sm_fix_cc);
m_fillmissingyears(f59_topsoilc_decay,"i,sPools59,w,tillage59");


table f59_topsoilc_actualstate(i,sPools59,lutypes59) LPJ topsoil carbon for different pools and lu types(million tC)
$ondelim 
$include "./modules/59_som/threepool_may23/input/f59_topsoilc_actualstate.cs3"
$offdelim
;
