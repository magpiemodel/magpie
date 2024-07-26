*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
  q15_food_demand(i,kfo) Food demand (mio. kcal)
;

positive variables
  vm_dem_food(i,kall)    Food demand (mio. tDM per yr)
;


*** #### Food Demand Model
equations
  q15_aim                Objective function of food demand model (mio. USD05PPP)
  q15_budget(iso)        Household budget constraint (USD05PPP per cap per day)

  q15_regr_bmi_shr(iso,sex,agegroup15,bmi_tree15)   Estimates regression parameters for BMI regression shares (1)
  q15_bmi_shr_verylow(iso,sex,agegroup15)           Estimates BMI share for population groups with low BMI (1)
  q15_bmi_shr_low(iso,sex,agegroup15)               Estimates BMI share for population groups with very low BMI (1)
  q15_bmi_shr_medium(iso,sex,agegroup15)            Estimates BMI share for population groups with medium BMI(1)
  q15_bmi_shr_medium_high(iso,sex,agegroup15)       Estimates BMI share for population groups with medium to high BMI (1)
  q15_bmi_shr_high(iso,sex,agegroup15)              Estimates BMI share for population groups with high BMI (1)
  q15_bmi_shr_veryhigh(iso,sex,agegroup15)          Estimates BMI share for population groups with very high BMI (1)
  q15_bmi_shr_agg(iso,sex,age,bmi_group15)          Disaggregates age groups from overarching groups (1)

  q15_intake(iso)                                   Estimates average intake for the entire country (kcal per cap per day)
  q15_regr_kcal(iso)                                Per capita total demand (kcal per cap per day)
  q15_regr(iso, regr15)                             Estimates parameters for food demand and dietary composition (1)
  q15_foodtree_kcal_animals(iso,kfo_ap)             Demand for animal products  (kcal per cap per day)
  q15_foodtree_kcal_processed(iso,kfo_pf)           Demand for processed products  (kcal per cap per day)
  q15_foodtree_kcal_staples(iso,kfo_st)             Demand for staple products  (kcal per cap per day)
  q15_foodtree_kcal_vegetables(iso)                 Demand for vegetable and fruit products  (kcal per cap per day)
;


positive variables
  v15_kcal_regr(iso,kfo)                                 Uncalibrated regression estimates of calorie demand (kcal per cap per day)
  v15_kcal_regr_total(iso)                               Uncalibrated regression estimates of  total per cap calories (kcal per cap per day)
  v15_demand_regr(iso, regr15)                           Uncalibrated regression estimates of kcal shares (1)
  v15_income_pc_real_ppp_iso(iso)                        Real income per cap (USD05PPP per cap)
  v15_income_balance(iso)                                Balance variable to balance cases in which reduction in income is larger than the per capita GDP (USD05PPP per cap per yr)
  v15_kcal_intake_total_regr(iso)                        Food intake (kcal per cap per day)
  v15_regr_overgroups(iso,sex,agegroup15,bmi_tree15)     Hierarchical tree parameter regressions (1)
  v15_bmi_shr_regr(iso,sex,age,bmi_group15)              Uncalibrated share of population groups belonging to a certain BMI group (1)
  v15_bmi_shr_overgroups(iso,sex,agegroup15,bmi_group15) Uncalibrated  share of population groups belonging to a certain BMI group (1)
;

variables
  v15_objective                      Objective term (USD05PPP)
;

scalars
  s15_yeardiff                       Number of 5-year time intervalls between time steps (1)
  s15_count                          Loop counter for interpolating body height estimates between longer timesteps (1)
  s15_run_diet_postprocessing        run diet postprocessing (1)
;

parameters
* technical
 p15_modelstat(t)                              Model solver status (1)
 p15_iteration_counter(t)                      Number of iterations required for reaching an equilibrium between food demand model and magpie (1)
 p15_convergence_measure(t,iter15)             Convergence measure to decide for continuation or stop of food_demand - magpie iteration (1)
 i15_dem_intercept(iso,regr15)                 Food regression parameters intercept in kcal or as share (X)
 i15_dem_saturation(iso,regr15)                Food regression parameters saturation in kcal or as share (X)
 i15_dem_halfsat(iso,regr15)                   Food regression parameters halfsaturation (USD05PPP per cap)
 i15_dem_nonsat(iso,regr15)                    Food regression parameters nonsaturation (1)
 p15_ruminant_subst_fader(t_all)               Ruminant meat substitution fader (1)
 p15_fish_subst_fader(t_all)                   Fish substitution fader (1)
 p15_alcohol_subst_fader(t_all)                Alcohol substitution fader (1)
 p15_livestock_subst_fader(t_all)              Livestock substitution fader (1)
 p15_rumdairy_subst_fader(t_all)               Ruminant and dairy substitution fader (1)
 p15_rumdairy_scp_subst_fader(t_all)           Ruminant and dairy substitution with SCP fader (1)
 p15_livestock_threshold_subst_fader(t_all)    Fader for livestock threshold target (1)
 p15_exo_food_scenario_fader(t_all)            Exogenous diet scenario fader (1)

* prices
  p15_prices_kcal(t,iso,kfo,iter15)                 Prices from MAgPIE after optimization (USD05PPP per kcal)
  i15_prices_initial_kcal(iso,kfo)                  Initial prices that capture the approximate level of prices in 1961-2010 (USD05PPP per kcal)

* anthropometrics
  p15_bodyheight(t,iso,sex,age,estimates15)           Body height (cm per cap)
  p15_bodyweight(t,iso,sex,age,bmi_group15)           Body weight (kg per cap)
  p15_bodyheight_calib(t,iso,sex,age_new_estimated15) Calibration factor for regional height differences (cm)
  p15_kcal_growth_food(t_all,iso,underaged15)         Average per capita demand for body size growth relevant food items in the last three 5-year steps (kcal per capita per day)
  p15_physical_activity_level(t,iso,sex,age)          Physical activity levels in PAL relative to basic metabolic rate BMR (kcal per kcal)

  i15_bmi_intercept(sex,agegroup15,bmi_tree15)     BMI share regression intercept (1)
  i15_bmi_saturation(sex,agegroup15,bmi_tree15)    BMI share regression saturation (1)
  i15_bmi_halfsat(sex,agegroup15,bmi_tree15)       BMI share regression halfsaturation (1)

  p15_bmi_shr_regr(t,iso,sex,age,bmi_group15)              Uncalibrated regression estimates of BMI shares (1)
  i15_bmi_shr_calib(t,iso,sex,age,bmi_group15)             Calibration parameters to meet historical BMI shares (1)
  i15_bmi_shr_calib_lastcalibyear(iso,sex,age,bmi_group15) Calibration parameters of the last year with historical observations (1)

* diet structure
  p15_intake(t,iso,sex,age,bmi_group15)            Mean food intake by population group (kcal per capita per day)
  i15_kcal_pregnancy(t,iso)                        Additional calorie requirements  for pregnancy and lactation (kcal)
  p15_kcal_regr(t, iso, kfo)                       Uncalibrated regression estimates of calorie demand (kcal per cap per day)

  i15_milk_share_fadeout_india(t_all)              Temporal fader of milk share in india (applied before food demand model) (1)
  i15_rum_share_fadeout(t_all,iso)                 Temporal fader of ruminant meat share (applied before food demand model) (1)
  i15_ruminant_fadeout(t,iso)                      Ruminant fadeout share (1)
  i15_fish_fadeout(t,iso)                          Fish fadeout share (1)
  i15_alcohol_fadeout(t,iso)                       Alcohol fadeout share (1)
  i15_livestock_fadeout(t,iso)                     Livestock fadeout share (1)
  i15_rumdairy_fadeout(t,iso)                      Ruminant meat and dairy fadeout share (1)
  i15_rumdairy_scp_fadeout(t,iso)                  Ruminant meat and dairy fadeout share to be replaced by SCP (1)
  i15_livestock_fadeout_threshold(t,iso)           Livestock fadeout share for threshold (1)

  i15_protein_to_kcal_ratio(t,kfo)                   Protein-to-kcal ratio (g protein per kcal)

  i15_staples_kcal_structure_iso(t,iso,kfo_st)       Share of single staple products within total staples (1)
  i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap) Share of single livestock products within total livestock products (uncorrected for future changes in shares) (1)
  i15_livestock_kcal_structure_iso(t,iso,kfo_ap)     Share of single livestock products within total livestock products (corrected for future changes in shares) (1)
  i15_processed_kcal_structure_iso(t,iso,kfo_pf)     Share of single processed products within total processed food (1)

* diet calibration
  p15_kcal_calib(t,iso,kfo)                   Balance flow to diverge from mean calories of regressions (kcal per cap per day)
  p15_kcal_calib_lastcalibyear(iso,kfo)       Calibration factor for the last year with observations (kcal per cap per day)
  p15_balanceflow_kcal(t,i,kfo)               Balance flow for mismatch between FAOSTAT and demand estimates (kcal per capita per day)
  p15_balanceflow_kcal_iso(t,iso,kfo)         Balance flow for mismatch between FAOSTAT and demand estimates (kcal per capita per day)
  p15_balanceflow_kcal_lastcalibyear(iso,kfo) Balance flow of last historic time step for mismatch between FAOSTAT and demand estimates (kcal per capita per day)

* before shock
 o15_kcal_regr_initial(t,iso,kfo)             Uncalibrated per capita demand before price shock (kcal per capita per day)
 pm_kcal_pc_initial(t,i,kall)                 Per capita consumption in food demand model before price shock (kcal per capita per day)
 p15_kcal_pc_initial_iso(t,iso,kfo)           Per capita consumption in food demand model before price shock on country level (kcal per capita per day)

* after price shock
 p15_kcal_pc_iso(t,iso,kfo)                        Per capita consumption in food demand model after price shock on country level (kcal per capita per day)
 p15_kcal_pc(t,i,kfo)                              Per capita consumption in food demand model after price shock on regional level (kcal per capita per day)
 p15_kcal_pc_calibrated(t,i,kfo)                   Calibrated per capita consumption in food demand model after price shock (kcal per capita per day)
 p15_kcal_pc_iso_orig(t,iso,kfo)                   Auxiliary parameter for per capita food consumption - basis for convergence into waste and diet scenarios (kcal per capita per day)
 p15_kcal_pc_iso_livestock_orig(t,iso)             Auxiliary parameter for per capita livestock consumption - basis for scenarios of livestock food substitution (kcal per capita per day)
 p15_kcal_pc_iso_rumdairy_orig(t,iso)              Auxiliary parameter for per capita ruminant and dairy consumption - basis for scenarios of ruminant-based food substitution (kcal per capita per day)
 p15_kcal_pc_iso_plant_orig(t,iso)                 Auxiliary parameter for per capita plant-based food consumption - basis for scenarios of livestock food substitution (kcal per capita per day)
 p15_protein_pc_iso_scp(t,iso,kfo_rd)              Per capita consumption of SCP in food demand model after price shock on country level (g protein per capita per day)
 p15_livestock_kcal_structure_orig(t,iso,kfo_lp)   Auxiliary parameter for livestock kcal structure - basis for scenarios of livestock food substitution (1)
 p15_rumdairy_kcal_structure_orig(t,iso,kfo_rd)    Auxiliary parameter for ruminant and dairy kcal structure - basis for scenarios of ruminant-based food substitution (1)
 p15_plant_kcal_structure_orig(t,iso,kfo_pp)       Auxiliary parameter for plant-based food kcal structure - basis for scenarios of livestock food substitution (1)
 p15_kcal_pc_livestock_supply_target(iso)          Target of per capita livestock consumption (kcal per capita per day)

 p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15) Calibrated estimates of BMI share for population groups  (1)
 p15_bmi_shr_target(t,iso,sex,age,bmi_group15)     Target for BMI shares under exogenous scenarios (1)
 p15_intake_total(t,iso)                           Total food intake in a country (kcal per capita per day)

*food waste
 p15_demand2intake_ratio(t,iso)                   Ratio between food calorie demand and intake (kcal per kcal)
 p15_waste_pc(t,iso,kfo)                          Household waste by food group (kcal per capita per day)
 p15_intake_detail(t,iso,kfo)                     Intake by food group (kcal per capita per day)
 p15_demand2intake_ratio_detail(t,iso,kfo)        Food waste ratio by food group (kcal per kcal)
 p15_demand2intake_ratio_detail_preexo(t,iso,kfo) Food waste as outcome of regression (kcal per kcal)

* transition to exogenous scenario diets
 i15_intake_scen_target(t,iso)                            Target for total per capita calorie intake according to an exogenous diet scenario (kcal per capita per day)
 i15_intake_EATLancet_all(iso,kcal_scen15,EAT_scen15,kfo) Food-specific per capita calorie intake according to various EAT Lancet diet scenarios (kcal per capita per day)
 i15_intake_EATLancet(iso,kfo)                            Food-specific per capita calorie intake according to EAT Lancet diet scenario (kcal per capita per day)
 p15_intake_detailed_scen_target(t,iso,kfo)               Target for food-specific per capita calorie intake according to an exogenous diet scenario (kcal per capita per day)

 i15_fruit_ratio(t,iso,EAT_special)                       Ratio of calories from fruits and vegetables within the others and cassav_sp food categories (1)
 p15_intake_detail_starchyfruit(t,iso)                    Auxiliary parameter for the intake of starchy fruits included in cassav_sp (kcal per capita per day)
 p15_intake_detail_roots(t,iso)                           Auxiliary parameter for the intake of roots (kcal per capita per day)
 p15_intake_detail_fruitveg(t,iso)                        Auxiliary parameter for the intake of fruits and vegetables included in others (kcal per capita per day)
 p15_intake_detail_nuts(t,iso)                            Auxiliary parameter for the intake of nuts included in others (kcal per capita per day)
 p15_intake_detailed_scen_starchyfruit(t,iso)             Auxiliary scenario target for the intake of starchy fruits included in cassav_sp (kcal per capita per day)
 p15_intake_detailed_scen_roots(t,iso)                    Auxiliary scenario target for the intake of roots (kcal per capita per day)
 p15_intake_detailed_scen_fruitveg(t,iso)                 Auxiliary scenario target for the intake of fruits and vegetables included in others (kcal per capita per day)
 p15_intake_detailed_scen_nuts(t,iso)                     Auxiliary scenario target for the intake of nuts included in others (kcal per capita per day)

 i15_exo_foodscen_fader(t,iso)                Fader that converges per capita food consumption to an exogenous diet scenario (1)

* country-specific scenario switch
 p15_country_dummy(iso)                       Dummy parameter indicating whether country is affected by diet scenarios (1)

* calculate diet iteration breakpoint
 p15_income_pc_real_ppp(t,i)                  Regional per capita income after price shock on regional level (USD05PPP per capita)
 p15_delta_income(t,i,iter15)                 Regional change in per capita income due to price shock on regional level (1)
;

scalars
 s15_scp_fat_per_milk               Fat needed as ingredient for scp-based milk alternative (g per 100g wet matter) / 3.3 /
 s15_scp_sugar_per_milk             Sugar needed as ingredient for scp-based milk alternative (g per 100g wet matter) / 4.7 /
 s15_scp_protein_per_milk           Protein needed as ingredient for scp-based milk alternative (g per 100g wet matter) / 3.3 /
 s15_scp_fat_content                Fat content of microbial biomass based on Solein from Solar foods (t fat per t DM) / 0.05 /
 s15_scp_fat_protein_ratio_meat     Ratio of protein to fat in both plant based meat alternatives and current meat products (t fat per t protein) / 0.66 /
;


*' @code
*' The food demand model consists of the following equations, which are not
*' part of MAgPIE.
model m15_food_demand /
      q15_aim,
      q15_budget,

      q15_regr_bmi_shr,

      q15_bmi_shr_verylow,
      q15_bmi_shr_low,
      q15_bmi_shr_medium,
      q15_bmi_shr_medium_high,
      q15_bmi_shr_high,
      q15_bmi_shr_veryhigh,

      q15_bmi_shr_agg,

      q15_intake,
      q15_regr_kcal,
      q15_regr,

      q15_foodtree_kcal_animals,
      q15_foodtree_kcal_processed,
      q15_foodtree_kcal_staples,
      q15_foodtree_kcal_vegetables
  /;

*' In contrast, the equation `q15_food_demand` is part of MAgPIE, but
*' not of the food demand model.
*' @stop

m15_food_demand.optfile   = 0 ;
m15_food_demand.scaleopt  = 1 ;
m15_food_demand.solprint  = 0 ;
m15_food_demand.holdfixed = 1 ;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_food(t,i,kall,type)                                     Food demand (mio. tDM per yr)
 ov15_kcal_regr(t,iso,kfo,type)                                 Uncalibrated regression estimates of calorie demand (kcal per cap per day)
 ov15_kcal_regr_total(t,iso,type)                               Uncalibrated regression estimates of  total per cap calories (kcal per cap per day)
 ov15_demand_regr(t,iso,regr15,type)                            Uncalibrated regression estimates of kcal shares (1)
 ov15_income_pc_real_ppp_iso(t,iso,type)                        Real income per cap (USD05PPP per cap)
 ov15_income_balance(t,iso,type)                                Balance variable to balance cases in which reduction in income is larger than the per capita GDP (USD05PPP per cap per yr)
 ov15_kcal_intake_total_regr(t,iso,type)                        Food intake (kcal per cap per day)
 ov15_regr_overgroups(t,iso,sex,agegroup15,bmi_tree15,type)     Hierarchical tree parameter regressions (1)
 ov15_bmi_shr_regr(t,iso,sex,age,bmi_group15,type)              Uncalibrated share of population groups belonging to a certain BMI group (1)
 ov15_bmi_shr_overgroups(t,iso,sex,agegroup15,bmi_group15,type) Uncalibrated  share of population groups belonging to a certain BMI group (1)
 ov15_objective(t,type)                                         Objective term (USD05PPP)
 oq15_food_demand(t,i,kfo,type)                                 Food demand (mio. kcal)
 oq15_aim(t,type)                                               Objective function of food demand model (mio. USD05PPP)
 oq15_budget(t,iso,type)                                        Household budget constraint (USD05PPP per cap per day)
 oq15_regr_bmi_shr(t,iso,sex,agegroup15,bmi_tree15,type)        Estimates regression parameters for BMI regression shares (1)
 oq15_bmi_shr_verylow(t,iso,sex,agegroup15,type)                Estimates BMI share for population groups with low BMI (1)
 oq15_bmi_shr_low(t,iso,sex,agegroup15,type)                    Estimates BMI share for population groups with very low BMI (1)
 oq15_bmi_shr_medium(t,iso,sex,agegroup15,type)                 Estimates BMI share for population groups with medium BMI(1)
 oq15_bmi_shr_medium_high(t,iso,sex,agegroup15,type)            Estimates BMI share for population groups with medium to high BMI (1)
 oq15_bmi_shr_high(t,iso,sex,agegroup15,type)                   Estimates BMI share for population groups with high BMI (1)
 oq15_bmi_shr_veryhigh(t,iso,sex,agegroup15,type)               Estimates BMI share for population groups with very high BMI (1)
 oq15_bmi_shr_agg(t,iso,sex,age,bmi_group15,type)               Disaggregates age groups from overarching groups (1)
 oq15_intake(t,iso,type)                                        Estimates average intake for the entire country (kcal per cap per day)
 oq15_regr_kcal(t,iso,type)                                     Per capita total demand (kcal per cap per day)
 oq15_regr(t,iso,regr15,type)                                   Estimates parameters for food demand and dietary composition (1)
 oq15_foodtree_kcal_animals(t,iso,kfo_ap,type)                  Demand for animal products  (kcal per cap per day)
 oq15_foodtree_kcal_processed(t,iso,kfo_pf,type)                Demand for processed products  (kcal per cap per day)
 oq15_foodtree_kcal_staples(t,iso,kfo_st,type)                  Demand for staple products  (kcal per cap per day)
 oq15_foodtree_kcal_vegetables(t,iso,type)                      Demand for vegetable and fruit products  (kcal per cap per day)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
