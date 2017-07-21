*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$setglobal c50_scen_neff  neff60_60_starty2010
*   options:   snupe55_55_starty1990,snupe60_60_starty1990,snupe65_70_starty1990,
*   snupe65_70_starty2010,snupe60_60_starty2010,snupe55_60_starty2010,
*   snupe70_75_starty2010,snupe75_80_starty2010,snupe80_85_starty2010
*   snupe75_85_starty2010

$setglobal c50_dep_scen  rcp26
*   options:   rcp26, rcp45, rcp85

parameter f50_snupe(t_all,i,scen_neff50)  selected scenario values for soil nitrogen uptake efficiency (1)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_snupe.cs4"
$offdelim
/;

parameter f50_nue_pasture(t_all,i,scen_neff50)  selected scenario values for soil nitrogen uptake efficiency (1)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_nue_pasture.cs4"
$offdelim
/;


parameter f50_nr_fix_ndfa(t_all,i,kcr) Nr fixation rates per ton production in percent of plant dm
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_ndfa.cs4"
$offdelim
/;

parameter f50_nitrogen_balanceflow(t_all,i) Balancelfow to account for unrealistically high SNUpEs on croplands in Tg Nr
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_nitrogen_balanceflow.cs4"
$offdelim
/;

parameter f50_nitrogen_balanceflow_pasture(t_all,i) Balancelfow to account for unrealistically high NUE on pastures in Tg Nr
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_nitrogen_balanceflow_pasture.cs4"
$offdelim
/;


parameter f50_nr_fix_area(kcr) Nr fixation rates per area in t per ha
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_fixation_freeliving.cs4"
$offdelim
/;

parameter f50_nr_fixation_rates_pasture(t_all,i) Nr fixation rates per area in t per ha for pastures
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_nitrogen_fixation_rates_pasture.cs4"
$offdelim
/;

parameter f50_atmospheric_deposition_rates(t_all,i,land,dep_scen50) Nr deposition rates per area in t per ha for land types
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_atmospheric_deposition_rates.cs4"
$offdelim
/;