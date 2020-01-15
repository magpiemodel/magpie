*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


$setglobal c15_food_scenario  SSP2
*   options:   SSP: "SSP1", "SSP2", "SSP3", "SSP4", "SSP5"
*             SRES: "A1", "A2", "B1", "B2"
*            OTHER: "SSP1_boundary", "SSP2_boundary", "SSP3_boundary", "SSP4_boundary", "SSP5_boundary"

$setglobal c15_calibscen  constant
*   options:   constant, fadeout2050

$setglobal c15_rum_share  mixed
*   options:   constant, halving2050, mixed

* Food substitution scenarios including functional forms, targets and transition periods
*   options:   constant,
*              lin_zero_10_50, lin_zero_20_50, lin_zero_20_30,
*              lin_50pc_10_50_extend90, lin_75pc_10_50_extend90, lin_80pc_20_50, lin_80pc_20_50_extend95, lin_90pc_20_50_extend95,
*              lin_99-98-90pc_20_50-60-100
$setglobal c15_rumscen  constant
$setglobal c15_fishscen  constant
$setglobal c15_alcscen  constant
$setglobal c15_livescen  constant


$setglobal c15_exo_scen_targetyear  y2050
*   options:   y2030, y2050

$setglobal c15_kcal_scen  healthy_BMI
*   options:   healthy_BMI, 2100kcal, 2500kcal

$setglobal c15_EAT_scen  FLX
*   options:   BMK, FLX, PSC, VEG, VGN, FLX_hmilk, FLX_hredmeat


scalar s15_elastic_demand  Elastic demand switch (1=elastic 0=exogenous) (1) / 1 /;

scalar s15_calibrate Calibration switch (1=calibrated 0=pure regression outcomes) (1) / 1 /;
* only for per-capita calories, not for e.g. calibration of transformation parameters between per-capita calories in dm

scalar s15_maxiter Scalar defining maximum number of iterations (1) / 5 /;

scalar s15_convergence Convergence criterion (1) / 0.005 /;

scalar s15_exo_waste Switch for transition towards exogenous food waste scenario (1)  / 0 /;

scalar s15_waste_scen Scenario target for the ratio between food demand and intake (1)  / 1.2 /;

scalar s15_exo_diet Switch for transition towards exogenous diet scenario (1)  / 0 /;

scalar s15_milk_share_india milk share in India (1)  / 0.5 /;

table f15_household_balanceflow(t_all,i,kall,dm_ge_nr)   Balance flow to take account of heterogeneous products and processes (mio. tDM)
$ondelim
$include "./modules/15_food/input/f15_household_balanceflow.cs3"
$offdelim;

table f15_nutrition_attributes(t_all,kall,nutrition) Nutrition attributes of food items dedicated for fooduse (mio. kcal per tDM | t Protein per tDM)
$ondelim
$include "./modules/15_food/input/f15_nutrition_attributes.cs3"
$offdelim;


*** Food Demand Model


* Unit for `f15_demand_paras` is
* kcal/capita/day for saturation and intercept, and
* USD05/capita for halfsaturation

table f15_demand_paras(regr15,food_scen15,par15)  Food regression parameters in USD05PPP or dimensionless (X)
$ondelim
$include "./modules/15_food/input/f15_demand_regression_parameters.cs3"
$offdelim;

table f15_bmi_shr_paras(sex, agegroup15, bmi_tree15, paras_b15)  BMI share regression parameters in USD05PPP or dimensionless (X)
$ondelim
$include "./modules/15_food/input/f15_bmi_shr_regr_paras.cs3"
$offdelim;

table f15_bmi(sex,age,bmi_group15) Mean body mass index for each BMI group (kg per m2)
$ondelim
$include "./modules/15_food/input/f15_bmi.cs3"
$offdelim;

table f15_bmi_shr_past(t_all,iso,age,sex,bmi_group15) Observed share of population belonging to a BMI group in the past (1)
$ondelim
$include "./modules/15_food/input/f15_bmi_shr_past.cs3"
$offdelim;


table f15_kcal_pc_iso(t_all,iso,kfo)  Observed per capita food supply in the past (kcal per cap per day)
$ondelim
$include "./modules/15_food/input/f15_kcal_pc_iso.csv"
$offdelim;


table f15_intake_pc_observed_iso(t_all,iso,sex,age)  Observed per capita food intake in the past (kcal per captia per day)
$ondelim
$include "./modules/15_food/input/f15_intake_pc_observed_iso.cs3"
$offdelim;


parameter f15_prices_initial(kall) Food prices in initialization period (USD05MER per t DM)
/
$ondelim
$include "./modules/15_food/input/f15_prices_initial.csv"
$offdelim
/;


parameter f15_price_index(t_all) Food price index in initialization period (1)
/
$ondelim
$include "./modules/15_food/input/f15_prices_index.csv"
$offdelim
/;


table f15_kcal_calib_fadeout(t_all,calibscen15) Calibration fadeout factor (1)
$ondelim
$include "./modules/15_food/input/f15_kcal_balanceflow_fadeout.csv"
$offdelim
;


table f15_rum_share_fadeout(t_all,ruminantfadeoutscen15) Ruminant share fadeout scenario (1)
$ondelim
$include "./modules/15_food/input/f15_ruminant_fadeout.csv"
$offdelim
;


table f15_bodyheight(t_all,iso,sex,age)   Body height (cm per cap)
$ondelim
$include "./modules/15_food/input/f15_bodyheight_historical.cs3"
$offdelim;

table f15_schofield(sex,age, paras_s15) Schofield equation parameters in kcal per capita per day or kcal per capita per day per weight (X)
$ondelim
$include "./modules/15_food/input/f15_schofield_parameters.cs3"
$offdelim
;


*** Exogenous food substitution scenarios

table f15_food_substitution_fader(t_all,fadeoutscen15)   Fader for food substitution scenarios (1)
$ondelim
$include "./modules/15_food/input/f15_food_substitution_fader.csv"
$offdelim;


*** Exogenous food demand scenarios

table f15_intake_EATLancet(t_scen15,i,kcal_scen15,EAT_scen15,kfo)   EAT Lancet scenarios for food-specific intake (kcal per capita per day)
$ondelim
$include "./modules/15_food/input/f15_intake_EATLancet.cs3"
$offdelim;

table f15_overcons_FAOwaste(i,kfo)   Ratio between food calorie supply and food intake based on FAO food waste shares (1)
$ondelim
$include "./modules/15_food/input/f15_supply2intake_ratio_bottomup.cs3"
$offdelim;

parameter f15_calib_fsupply(i) Factor calibrating food supply as estimated from intake and FAO waste assumptions to FAO food supply (1)
/
$ondelim
$include "./modules/15_food/input/f15_calib_factor_FAOfsupply.cs4"
$offdelim
/;

table f15_exo_foodscen_fader(t_all,t_scen15) Fader that converges per capita food consumption to an exogenous diet scenario until the target year (1)
$ondelim
$include "./modules/15_food/input/f15_exo_foodscen_fader.csv"
$offdelim
;


*** EOF input.gms ***
