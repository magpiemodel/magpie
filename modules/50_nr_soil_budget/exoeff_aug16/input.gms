*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c50_scen_neff  neff55_60_starty2010
*   options: constant,
*   neff55_55_starty1990,neff60_60_starty1990,neff65_70_starty1990,
*   neff65_70_starty2010,neff60_60_starty2010,neff55_60_starty2010,
*   neff70_75_starty2010,neff75_80_starty2010,neff80_85_starty2010
*   neff75_85_starty2010,neff85_85_starty2010

$setglobal c50_scen_neff_pasture  constant
*   options: constant,
*   neff55_55_starty1990,neff60_60_starty1990,neff65_70_starty1990,
*   neff65_70_starty2010,neff60_60_starty2010,neff55_60_starty2010,
*   neff70_75_starty2010,neff75_80_starty2010,neff80_85_starty2010
*   neff75_85_starty2010,neff85_85_starty2010

$setglobal c50_dep_scen  history
*   options:   history

scalar
      s50_fertilizer_costs Costs of fertilizer (USD05MER per tN)            / 600 /
;


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


parameter f50_nr_fix_ndfa(t_all,i,kcr) Nr fixation rates per Nr in plant biomass (tNr per tNr)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_ndfa.cs4"
$offdelim
/;

parameter f50_nitrogen_balanceflow(t_all,i) Balancelfow to account for unrealistically high SNUpEs on croplands (mio. tNr per yr)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_nitrogen_balanceflow.cs4"
$offdelim
/;

parameter f50_nitrogen_balanceflow_pasture(t_all,i) Balancelfow to account for unrealistically high NUE on pastures (mio. tNr per yr)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_nitrogen_balanceflow_pasture.cs4"
$offdelim
/;


parameter f50_nr_fix_area(kcr) Nr fixation rates per area (tNr per ha)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_fixation_freeliving.cs4"
$offdelim
/;

parameter f50_nr_fixation_rates_pasture(t_all,i) Nr fixation rates per pasture area (tNr per ha)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_nitrogen_fixation_rates_pasture.cs4"
$offdelim
/;

table f50_atmospheric_deposition_rates(t_all,j,land,dep_scen50) Nr deposition rates per area (tNr per ha)
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_AtmosphericDepositionRates.cs3"
$offdelim
;
