*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


equations
  q15_food_demand(i,kfo) Food demand (mio. kcal)
;

positive variables
  vm_dem_food(i,kall)       Demand for food (mio. tDM per yr)
;


*** #### Food Demand Model



equations
  q15_aim                aim function food demand model (mio. USD05)
  q15_budget(iso)        Household Budget Constraint (USD05 per capita per day)

  q15_regr_bmi_shr(iso,sex,agegroup15,bmi_tree15) estimates regression parameters for BMI regression shares (capita per capita)
  q15_bmi_shr_verylow(iso,sex,agegroup15)  estimates bmi share for population groups (capita per capita)
  q15_bmi_shr_low(iso,sex,agegroup15)       estimates bmi share for population groups (capita per capita)
  q15_bmi_shr_medium(iso,sex,agegroup15)     estimates bmi share for population groups (capita per capita)
  q15_bmi_shr_medium_high(iso,sex,agegroup15)     estimates bmi share for population groups (capita per capita)
  q15_bmi_shr_high(iso,sex,agegroup15)      estimates bmi share for population groups  (capita per capita)
  q15_bmi_shr_veryhigh(iso,sex,agegroup15)   estimates bmi share for population groups  (capita per capita)
  q15_bmi_shr_agg(iso,sex,age,bmi_group15)     disaggregates age groups from overarchign groups (cpatia per capita)

  q15_intake(iso) Intake estimation for country total (kcal per capita per day)
  q15_regr_kcal(iso)     Per capita total consumption (kcal per capita per day)
  q15_regr(iso, regr15)  Share regressions  (kcal per kcal)
  q15_foodtree_kcal_animals(iso,kfo_ap)  Demand for animal products  (kcal per capita per day)
  q15_foodtree_kcal_processed(iso,kfo_pf) Demand for processed products  (kcal per capita per day)
  q15_foodtree_kcal_staples(iso,kfo_st)     Demand for staple products  (kcal per capita per day)
  q15_foodtree_kcal_vegetables(iso)     Demand for vegetable and fruits products  (kcal per capita per day)

;


positive variables
  v15_kcal_regr(iso,kfo)     Uncalibrated regression estimates of calorie demand (kcal per cap per day)
  v15_kcal_regr_total(iso)     Uncalibrated regression estimates of  total per capita calories (kcal per cap per day)
  v15_demand_regr(iso, regr15)       Uncalibrated regression estimates of kcal shares (-)
  v15_income_pc_real_ppp_iso(iso)    real income per capita (USD per cap)
  v15_income_balance(iso)            balance variable to balance cases in which reduction in income beats gdp pc (USD05 per cap)
  v15_kcal_intake_total_regr(iso)  Intake (kcal per cap per day)
  v15_regr_overgroups(iso,sex,agegroup15,bmi_tree15)   hierarchical tree parameter regressions (capita per capita))
  v15_bmi_shr_regr(iso,sex,age,bmi_group15) uncalibrated share of population groups belonging to a certain bmi_group (capita per capita)
  v15_bmi_shr_overgroups(iso,sex,agegroup15,bmi_group15) uncalibrated  share of population groups belonging to a certain bmi_group (capita per capita)
;

variables
  v15_objective                      objective term (USD05)
;

scalar s15_count counter for creating average consumption over the length between timesteps;

parameters
* technical
 p15_modelstat(t)                             model solver status (1)
 p15_iteration_counter(t)                     number of iterations required for reaching an equilibrium between food demand model and magpie (1)
 p15_convergence_measure(t)                   convergence measure to decide for continuation or stop of food_demand - magpie iteration (1)
 i15_dem_intercept(regr15)              food regression parameters intercept (1)
 i15_dem_saturation(regr15)             food regression parameters saturation(1)
 i15_dem_halfsat(regr15)                food regression parameters halfsaturation(1)
 i15_dem_nonsat(regr15)                 food regression parameters nonsaturation(1)

*prices
 p15_prices_kcal(t,iso,kfo)                   prices from magpie after optimization (USD05 per kcal)
 i15_prices_initial_kcal(iso,kfo)             initial prices that capture the approximate level of prices in 1961-2010 (USD05 per kcal)

* anthropometrics
  p15_bmi_shr(t,iso,sex,age,bmi_group15)      calibrated estimates bmi share for population groups  (capita per capita)
  p15_bodyheight(t,iso,sex,age,estimates15)     body height (cm per capita)
  p15_bodyweight(t,iso,sex,age,bmi_group15) body weight (kg per capita)
  p15_bodyheight_calib(t,iso,sex,age_new_estimated15)               calibration factor for regional differences in height (cm)
  p15_kcal_growth_food(t_all,iso,underaged15)  average per-capita consumption of growth relevant food items in the last 3 5-year steps (kcal per capita per day)
  p15_physical_activity_level(t,iso,sex,age)    physical activity levels in PAL relative to Basic metabolic rate BMR (kcal per kcal)

  i15_bmi_intercept(sex,agegroup15,bmi_tree15)   BMI share regression intercept (1)
  i15_bmi_saturation(sex,agegroup15,bmi_tree15)  BMI share regression saturation (1)
  i15_bmi_halfsat(sex,agegroup15,bmi_tree15)     BMI share regression halfsaturation (1)

  i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,bmi_tree15)   BMI regression share precalculation based on regression parameters required for calibration (capita per capita)
  i15_bmi_shr_pre(t,iso,sex,agegroup15,bmi_group15) BMI share precalculation based on regression parameters required for calibration (capita per capita)
  i15_bmi_shr_calib(t,iso,sex,age,bmi_group15) calibration parameters to meet historical BMI shares (capita per capita)
  i15_bmi_shr_calib_lastcalibyear(iso,sex,age,bmi_group15) calibration parameters of the last year with historical observatiosn (capita per capita)

* diet structure
  p15_kcal_intake_total(t,iso) Total intake in a country (kcal per capita per day)
  i15_intake(t,iso,sex,age,bmi_group15) Mean intake by population group (kcal per capita per day)
  i15_kcal_pregnancy(t,iso) Additional calorie requriements for pregnancy and lactation (kcal)
  p15_kcal_regr(t, iso, kfo)        Uncalibrated regression estimates of calorie demand (kcal per cap per day)

 i15_ruminant_fadeout(t_all) ruminant fadeout share (1)

 i15_staples_kcal_structure_iso(t,iso,kfo_st)    Share of a staple product within total staples (1)
 i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap)  Share of a livestock product within total staples (uncorrected for future changes in shares) (1)
 i15_livestock_kcal_structure_iso(t,iso,kfo_ap)  Share of a livestock product within total staples (corrected) (1)
 i15_processed_kcal_structure_iso                Share of a processed product within total staples (1)
 i15_staples_kcal_iso_tmp(t,iso)    Intermediate calculation do not use elsewhere (kcal per cap per day)
 i15_livestock_kcal_iso_tmp(t,iso)  Intermediate calculation do not use elsewhere (kcal per cap per day)

* diet calibration
  p15_kcal_calib(t,iso,kfo)               balanceflow to diverge from mean calories of regressions (kcal per cap per day)
  p15_kcal_calib_lastcalibyear(iso,kfo) the calibration factor for the last year with observations (kcal per cap per day)
  p15_balanceflow_kcal(t,i,kfo)          balanceflow for mismatch between FAOSTAT and demand estimates (kcal per capita per day)
  p15_balanceflow_kcal_iso(t,iso,kfo)    balanceflow for mismatch between FAOSTAT and demand estimates (kcal per capita per day)
  p15_balanceflow_kcal_lastcalibyear(iso,kfo) balanceflow of last historic timestep for mismatch between FAOSTAT and demand estimates (kcal per capita per day)

* before shock

 o15_kcal_regr_initial(iso,kfo)        Uncalibrated per-capita demand before price shock (kcal per capita per day)
 p15_kcal_pc_initial(t,i,kfo)               Per-capita consumption in food demand model before price shock (kcal per capita per day)
 pm_kcal_pc_initial(t,i,kfo)                 Per-capita consumption in food demand model before price shock (kcal per capita per day)
 p15_kcal_pc_initial_iso(t,iso,kfo)          Per-capita consumption in food demand model before price shock on iso level (kcal per capita per day)

* after price shock
 p15_kcal_pc_iso(t,iso,kfo)                 Per-capita consumption in food demand model after price shock (kcal per capita per day)
 p15_kcal_pc(t,i,kfo)                       Per-capita consumption in food demand model after price shock (kcal per capita per day)
 p15_kcal_pc_calibrated(t,i,kfo)            Calibrated per-capita consumption in food demand model after price shock (kcal per capita per day)

* calculate diet iteration breakpoint

  p15_income_pc_real_ppp(t,i)                 regional per-capita income after price shock (USD05 per capita)
  p15_delta_income(t,i)           regional change in per-capita income due to price shock (1)
  p15_lastiteration_delta_income(i) regional change in per-capita income due to price shock of last iteration (1)

;

scalars
 s15_year                    current year as integer value  /2000/
;

*' @code
*' The food demand model consists of the following equations which are not
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



*' In contrast, the equation q15_food_demand does only belong to MAgPIE, but
*' not to the food demand model.
*' @stop

m15_food_demand.optfile   = 0 ;
m15_food_demand.scaleopt  = 1 ;
m15_food_demand.solprint  = 0 ;
m15_food_demand.holdfixed = 1 ;



*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_food(t,i,kall,type)                                     Demand for food (mio. tDM per yr)
 ov15_kcal_regr(t,iso,kfo,type)                                 Uncalibrated regression estimates of calorie demand (kcal per cap per day)
 ov15_kcal_regr_total(t,iso,type)                               Uncalibrated regression estimates of  total per capita calories (kcal per cap per day)
 ov15_demand_regr(t,iso,regr15,type)                            Uncalibrated regression estimates of kcal shares (-)
 ov15_income_pc_real_ppp_iso(t,iso,type)                        real income per capita (USD per cap)
 ov15_income_balance(t,iso,type)                                balance variable to balance cases in which reduction in income beats gdp pc (USD05 per cap)
 ov15_kcal_intake_total_regr(t,iso,type)                        Intake (kcal per cap per day)
 ov15_regr_overgroups(t,iso,sex,agegroup15,bmi_tree15,type)     hierarchical tree parameter regressions (capita per capita))
 ov15_bmi_shr_regr(t,iso,sex,age,bmi_group15,type)              uncalibrated share of population groups belonging to a certain bmi_group (capita per capita)
 ov15_bmi_shr_overgroups(t,iso,sex,agegroup15,bmi_group15,type) uncalibrated  share of population groups belonging to a certain bmi_group (capita per capita)
 ov15_objective(t,type)                                         objective term (USD05)
 oq15_food_demand(t,i,kfo,type)                                 Food demand (mio. kcal)
 oq15_aim(t,type)                                               aim function food demand model (mio. USD05)
 oq15_budget(t,iso,type)                                        Household Budget Constraint (USD05 per capita per day)
 oq15_regr_bmi_shr(t,iso,sex,agegroup15,bmi_tree15,type)        estimates regression parameters for BMI regression shares (capita per capita)
 oq15_bmi_shr_verylow(t,iso,sex,agegroup15,type)                estimates bmi share for population groups (capita per capita)
 oq15_bmi_shr_low(t,iso,sex,agegroup15,type)                    estimates bmi share for population groups (capita per capita)
 oq15_bmi_shr_medium(t,iso,sex,agegroup15,type)                 estimates bmi share for population groups (capita per capita)
 oq15_bmi_shr_medium_high(t,iso,sex,agegroup15,type)            estimates bmi share for population groups (capita per capita)
 oq15_bmi_shr_high(t,iso,sex,agegroup15,type)                   estimates bmi share for population groups  (capita per capita)
 oq15_bmi_shr_veryhigh(t,iso,sex,agegroup15,type)               estimates bmi share for population groups  (capita per capita)
 oq15_bmi_shr_agg(t,iso,sex,age,bmi_group15,type)               disaggregates age groups from overarchign groups (cpatia per capita)
 oq15_intake(t,iso,type)                                        Intake estimation for country total (kcal per capita per day)
 oq15_regr_kcal(t,iso,type)                                     Per capita total consumption (kcal per capita per day)
 oq15_regr(t,iso,regr15,type)                                   Share regressions  (kcal per kcal)
 oq15_foodtree_kcal_animals(t,iso,kfo_ap,type)                  Demand for animal products  (kcal per capita per day)
 oq15_foodtree_kcal_processed(t,iso,kfo_pf,type)                Demand for processed products  (kcal per capita per day)
 oq15_foodtree_kcal_staples(t,iso,kfo_st,type)                  Demand for staple products  (kcal per capita per day)
 oq15_foodtree_kcal_vegetables(t,iso,type)                      Demand for vegetable and fruits products  (kcal per capita per day)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
