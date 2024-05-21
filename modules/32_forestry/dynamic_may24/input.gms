*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
$setglobal c32_aff_mask  noboreal
* options: unrestricted, noboreal, onlytropical
$setglobal c32_aff_policy  npi
* options: none, npi, ndc
$setglobal c32_aff_bgp  nobgp
* options: ann,nobgp
$setglobal c32_tcre_ctrl  ann_TCREmean
* options: ann_TCREmean, ann_TCREhigh, ann_TCRElow
$setglobal c32_interest_rate  regional
* options regional, global
$setglobal c32_rot_calc_type  current_annual_increment
* option  max_increment, max_npv
$setglobal c32_rot_calc_type  current_annual_increment
* options mean_annual_increment, current_annual_increment, instantaneous_growth_rate
$setglobal c32_shock_scenario  none
* options none 002lin2030 004lin2030 008lin2030 016lin2030


scalars
  s32_hvarea                      Flag for harvested area and establishemt (0=zero 1=exognous 2=endogneous) / 2 /
  s32_est_cost_plant              Establishment cost for plantations (USD per ha) / 2000 /
  s32_est_cost_natveg             Establishment cost for natural vegetation (USD per ha) / 2000 /
  s32_recurring_cost              Recurring costs (USD per ha) / 500 /
  s32_harvesting_cost             Harvesting cost (USD per ha) / 2000 /
  s32_planing_horizon             Afforestation planing horizon (years)            / 50 /
  s32_rotation_extension          Rotation extension factor 1=original rotations 2=100 percent increase in rotations etc (1) / 1 /
  s32_faustmann_rotation          Switch to activate faustmann rotations (1=on 0=off) / 0 /
  s32_initial_distribution        Switch to Activate ageclass distribution in plantations 0=off 1=equal distribution / 1 /
  s32_price                       Price for timber (USD)      / 45 /
  s32_free_land_cost              Penalty for technial area balance term (USD per ha) / 1e+06 /
  s32_max_aff_area                Maximum total global afforestation (mio. ha)    / Inf /
  s32_aff_plantation              Switch for using growth curves for afforestation 0=natveg 1=plantations (1) / 0 /
  s32_tcre_local                  Switch for local (1) or global (0) TRCE factors (1) / 1 /
  s32_forestry_int_rate           Global interest rate for plantations (percent) / 0.05 /
  s32_max_self_suff               Upper ceiling for the self sufficiency used in calculation for establishment decision (1) / 0.8 /
  s32_aff_bii_coeff               BII coefficent to be used for CO2 price driven afforestation 0=natural vegetation 1=plantation (1) / 0 /
  s32_max_aff_area_glo            Switch for global or regional afforestation constraint (1) / 1 /
  s32_aff_prot                    Switch for protection of afforested areas (0=until end of planning horizon 1=forever) / 1 /
  s32_plant_contr_growth_startyear  Start year for plantation contribution growth fader (year) / 2020 /
  s32_plant_contr_growth_endyear    End year for plantation contribution growth fader (year) / 2050 /
  s32_plant_contr_growth_startvalue Start value for plantation contribution growth fader (percent per year) / 0.05 /
  s32_plant_contr_growth_endvalue   End value for plantation contribution growth fader (percent per year) / 0 /
  s32_plant_contr_max               Maximum plantation contribution for establishment decision (percent) / 0.5 /
  s32_demand_establishment          Boolean switch for establishment demand assumption 1=forward looking 0=static (1) / 1 /
;

parameter f32_aff_mask(j) afforestation mask (binary)
/
$ondelim
$Ifi "%c32_aff_mask%" == "unrestricted" $include "./modules/32_forestry/input/aff_unrestricted.cs2"
$Ifi "%c32_aff_mask%" == "noboreal" $include "./modules/32_forestry/input/aff_noboreal.cs2"
$Ifi "%c32_aff_mask%" == "onlytropical" $include "./modules/32_forestry/input/aff_onlytropical.cs2"
$offdelim
/;

$onEmpty
parameter f32_max_aff_area(i) Maximum regional afforestation area (mio. ha)
/
$ondelim
$if exist "./modules/32_forestry/input/f32_max_aff_area.cs4" $include "./modules/32_forestry/input/f32_max_aff_area.cs4"
$offdelim
/;
$offEmpty

table f32_aff_pol(t_all,j,pol32) npi+ndc afforestation policy (Mha new forest wrt to 2010)
$ondelim
$include "./modules/32_forestry/input/npi_ndc_aff_pol.cs3"
$offdelim
;

table f32_aff_bgp(j,bgp32) Biogeophysical temperature change of afforestation (degree C)
$ondelim
$include "./modules/32_forestry/input/f32_bph_effect_noTCRE.cs3"
$ondelim
;

table f32_tcre(j,tcre32) Transient surface temperature response to CO2 emission (degree C per tC per ha)
$ondelim
$include "./modules/32_forestry/input/f32_localTCRE.cs3"
$ondelim
;

parameter f32_plantedforest(i) Share of plantation forest in planted forest (1)
/
$ondelim
$include "./modules/32_forestry/input/f32_plantedforest.cs4"
$offdelim
/;

table f32_forest_shock(t_all, shock_scen32) Forest carbon shock scenarios (area share affected per year)
$ondelim
$include "./modules/32_forestry/input/f32_forest_shock.csv"
$offdelim
;
