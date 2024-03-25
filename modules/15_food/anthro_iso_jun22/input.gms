*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


$setglobal c15_food_scenario  SSP2
$setglobal c15_food_scenario_noselect  SSP2
*   options:   SSP: "SSP1", "SSP2", "SSP3", "SSP4", "SSP5"
*             SRES: "A1", "A2", "B1", "B2"
*            OTHER: "SSP1_boundary", "SSP2_boundary", "SSP3_boundary", "SSP4_boundary", "SSP5_boundary"

$setglobal c15_calibscen  constant
*   options:   constant, fadeout2050

$setglobal c15_rum_share  mixed
*   options:   constant, halving2050, mixed

* Fader for food substitution scenarios and exogenous food intake and waste
* scenarios including functional forms, targets and transition periods
*   options:   constant,
*              lin_zero_10_50, lin_zero_20_50, lin_zero_20_30, lin_50pc_20_50, lin_50pc_20_50_extend65, lin_50pc_20_50_extend80,
*              lin_50pc_10_50_extend90, lin_75pc_10_50_extend90, lin_80pc_20_50, lin_80pc_20_50_extend95, lin_90pc_20_50_extend95,
*              lin_99-98-90pc_20_50-60-100, sigmoid_20pc_20_50, sigmoid_50pc_20_50, sigmoid_80pc_20_50
$setglobal c15_rumscen  constant
$setglobal c15_fishscen  constant
$setglobal c15_alcscen  constant
$setglobal c15_livescen  constant
$setglobal c15_rumdairyscen  constant
$setglobal c15_rumdairy_scp_scen  constant
$setglobal c15_livescen_target  constant
$setglobal c15_exo_foodscen  lin_zero_20_50

$setglobal c15_kcal_scen  healthy_BMI
*   options:    healthy_BMI, 2100kcal, 2500kcal,
*              endo, no_underweight, no_overweight
*              half_overweight, no_underweight_half_overweight

$setglobal c15_EAT_scen  FLX
*   options:   BMK, FLX, PSC, VEG, VGN, FLX_hmilk, FLX_hredmeat



* Set-switch for countries affected by country-specific exogenous diet scenario
* Default: all iso countries selected
sets
  scen_countries15(iso) countries to be affected by selected food sceanrio / ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,
                      ASM,ATA,ATF,ATG,AUS,AUT,AZE,BDI,BEL,BEN,
                      BES,BFA,BGD,BGR,BHR,BHS,BIH,BLM,BLR,BLZ,
                      BMU,BOL,BRA,BRB,BRN,BTN,BVT,BWA,CAF,CAN,
                      CCK,CHN,CHE,CHL,CIV,CMR,COD,COG,COK,COL,
                      COM,CPV,CRI,CUB,CUW,CXR,CYM,CYP,CZE,DEU,
                      DJI,DMA,DNK,DOM,DZA,ECU,EGY,ERI,ESH,ESP,
                      EST,ETH,FIN,FJI,FLK,FRA,FRO,FSM,GAB,GBR,
                      GEO,GGY,GHA,GIB,GIN,GLP,GMB,GNB,GNQ,GRC,
                      GRD,GRL,GTM,GUF,GUM,GUY,HKG,HMD,HND,HRV,
                      HTI,HUN,IDN,IMN,IND,IOT,IRL,IRN,IRQ,ISL,
                      ISR,ITA,JAM,JEY,JOR,JPN,KAZ,KEN,KGZ,KHM,
                      KIR,KNA,KOR,KWT,LAO,LBN,LBR,LBY,LCA,LIE,
                      LKA,LSO,LTU,LUX,LVA,MAC,MAF,MAR,MCO,MDA,
                      MDG,MDV,MEX,MHL,MKD,MLI,MLT,MMR,MNE,MNG,
                      MNP,MOZ,MRT,MSR,MTQ,MUS,MWI,MYS,MYT,NAM,
                      NCL,NER,NFK,NGA,NIC,NIU,NLD,NOR,NPL,NRU,
                      NZL,OMN,PAK,PAN,PCN,PER,PHL,PLW,PNG,POL,
                      PRI,PRK,PRT,PRY,PSE,PYF,QAT,REU,ROU,RUS,
                      RWA,SAU,SDN,SEN,SGP,SGS,SHN,SJM,SLB,SLE,
                      SLV,SMR,SOM,SPM,SRB,SSD,STP,SUR,SVK,SVN,
                      SWE,SWZ,SXM,SYC,SYR,TCA,TCD,TGO,THA,TJK,
                      TKL,TKM,TLS,TON,TTO,TUN,TUR,TUV,TWN,TZA,
                      UGA,UKR,UMI,URY,USA,UZB,VAT,VCT,VEN,VGB,
                      VIR,VNM,VUT,WLF,WSM,YEM,ZAF,ZMB,ZWE /
;

$onMultiR
set    kfo_rd(kfo) Ruminant meat and dairy food products / livst_rum /;
$offMulti

scalar s15_elastic_demand  Elastic demand switch (1=elastic 0=exogenous) (1) / 0 /;

scalar s15_calibrate Calibration switch (1=calibrated 0=pure regression outcomes) (1) / 1 /;
* only for per-capita calories, not for e.g. calibration of transformation parameters between per-capita calories in dm

scalar s15_maxiter Scalar defining maximum number of iterations (1) / 5 /;

scalar s15_convergence Convergence criterion (1) / 0.005 /;
* maximum relative per-capita gdp difference within a region between two iteratios

scalar s15_exo_waste Switch for transition towards exogenous food waste scenario (1)  / 0 /;

scalar s15_waste_scen Scenario target for the ratio between food demand and intake (1)  / 1.2 /;

scalar s15_exo_diet Switch for transition towards exogenous diet scenario (1)  / 0 /;
* The following switches only become active when s15_exo_diet is active
* They define which components of the diet should become active
* If the switch is set to 1,the exogenous diets are activated.
* For all other settings (!=1), the endogenous estimate is used.
* When activating a target, total calories are always preserved via scaling of staples
scalar s15_exo_monogastric Exogenous EAT Lancet animal product target on  (1) / 1 /;
scalar s15_exo_ruminant Exogenous EAT Lancet animal product target on  (1) / 1 /;
scalar s15_exo_fish Exogenous EAT Lancet animal product target on  (1) / 1 /;
scalar s15_exo_fruitvegnut Exogenous EAT Lancet fruit vegetable nut seeds target on  (1) / 1 /;
scalar s15_exo_roots Exogenous EAT Lancet root target on (1) / 1 /;
scalar s15_exo_pulses Exogenous pulses target on  (1) / 1 /;
scalar s15_exo_sugar Exogenous sugar target on  (1) / 1 /;
scalar s15_exo_oils Exogenous oils (1) / 1 /;
scalar s15_exo_brans Exogenous brans (1) / 0 /;
scalar s15_exo_scp Exogenous microbial protein target on  (1) / 1 /;
* The EAT-Lancet diet only allows for added sugars, but does not include processed food or
* alcohol. Via 's15_alc_scen' a maximum target for alcohol consumption can be defined.
scalar s15_exo_alcohol Exogenous alcohol target on (1) / 1 /;
scalar s15_alc_scen Scenario target for the inclusion of alcohol in the EAT-Lancet diet (1)  / 0 /;

scalar s15_rum_share_fadeout_india_strong   switch for stronger ruminant fadeout in India (binary) / 1 /;

scalar s15_milk_share_fadeout_india     switch for milk fadeout in India (binary) / 1 /;

scalar s15_kcal_pc_livestock_intake_target target for livestock intake (kcal per cap per day) / 430 /;

scalar s15_livescen_target_subst fade-out of livestock products (0) or substitution of livestock products with plant-based products (1) / 1 /;

table f15_household_balanceflow(t_all,i,kall,dm_ge_nr)   Balance flow to take account of heterogeneous products and processes (mio. tDM)
$ondelim
$include "./modules/15_food/input/f15_household_balanceflow.cs3"
$offdelim;

table fm_nutrition_attributes(t_all,kall,nutrition) Nutrition attributes of food items dedicated for fooduse (mio. kcal per tDM | t Protein per tDM)
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


table f15_rum_share_fadeout(t_all,livst_fadeoutscen15) Ruminant share fadeout scenario (1)
$ondelim
$include "./modules/15_food/input/f15_ruminant_fadeout.csv"
$offdelim
;

parameter f15_rum_share_fadeout_india(t_all) Ruminant share fadeout scenario for India (1)
/
$ondelim
$include "./modules/15_food/input/f15_ruminant_fadeout_india.csv"
$offdelim
/;

parameter f15_milk_share_fadeout_india(t_all) Milk share India fadeout scenario (1)
/
$ondelim
$include "./modules/15_food/input/f15_milk_fadeout_india.csv"
$offdelim
/;


table f15_bodyheight(t_all,iso,sex,age)   Body height (cm per cap)
$ondelim
$include "./modules/15_food/input/f15_bodyheight_historical.cs3"
$offdelim;

table f15_bodyheight_regr_paras(sex,paras_h15)   Body height regression parameters (X)
$ondelim
$include "./modules/15_food/input/f15_bodyheight_regr_paras.cs3"
$offdelim;

table f15_schofield(sex,age, paras_s15) Schofield equation parameters in kcal per capita per day or kcal per capita per day per weight (X)
$ondelim
$include "./modules/15_food/input/f15_schofield_parameters.cs3"
$offdelim
;

*** Food substitution scenarios

table f15_food_substitution_fader(t_all,fadeoutscen15)   Fader for food substitution scenarios (1)
$ondelim
$include "./modules/15_food/input/f15_food_substitution_fader.csv"
$offdelim;


*** Exogenous food demand scenarios

table f15_intake_EATLancet(t_scen15,iso,kcal_scen15,EAT_scen15,kfo)   EAT Lancet scenarios for food specific intake (kcal per capita per day)
$ondelim
$include "./modules/15_food/input/f15_intake_EATLancet_iso.cs3"
$offdelim;

table f15_overcons_FAOwaste(iso,kfo)   Ratio between food calorie supply and food intake based on FAO food waste shares (1)
$ondelim
$include "./modules/15_food/input/f15_supply2intake_ratio_FAO_iso.cs3"
$offdelim;

*** EAT Lancet diet recommendation
table f15_rec_EATLancet(iso,EAT_targets15,EAT_targettype15)   Minimum and maximum targets for healthy diets recommended by the EAT-Lancet Commission (kcal per capita per day)
$ondelim
$include "./modules/15_food/input/f15_targets_EATLancet_iso.cs3"
$offdelim;

table f15_fruitveg2others_kcal_ratio(t_all,iso,EAT_special)  Country-specific ratio of calories from fruits and vegetables within the others and cassav_sp food categories (1)
$ondelim
$include "./modules/15_food/input/f15_fruitveg2others_kcal_ratio_iso.cs3"
$offdelim;

* This file contains exogenous dietary recommendations for India and EAT Lancet recommendations for all other regions
* Different set elements for sets "t_scen15", "kcal_scen15" and "EAT_scen15" result in the identical target diet as per f15_intake_EATLancet
table f15_intake_NIN(t_scen15,iso,kcal_scen15,EAT_scen15,kfo)   NIN scenarios for food-specific intake (kcal per capita per day)
$ondelim
$include "./modules/15_food/input/f15_intake_NIN_iso.cs3"
$offdelim;

*** EOF input.gms ***
