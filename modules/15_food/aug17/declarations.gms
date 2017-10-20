*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


equations
         q15_food_demand(i,kfo) Food demand (million Kcal)
;

parameters
i15_kcal_pc_initial(t,i,kfo) Food demand without price shock and with calibration (kcal per capita per day)
;

positive variables
vm_dem_food(i,kall)       Demand for food (Mt DM)
v15_kcal_pc(i,kfo)       Per capita calories (kcal per capita per day)
;


*** #### Food Demand Model



equations
  q15_aim                aim function food demand model
  q15_aim_standalone     aim function standalone model
  q15_budget(iso)        Household Budget Constraint
  q15_real_income(iso)   Calculation of real income
  q15_regression1_kcal(iso)     Per capita total consumption
  q15_regression1_animals(iso)       Livestock share
  q15_regression1_processed(iso)       Processed share
  q15_regression1_vegfruit(iso) Vegetables and fruits share
  q15_foodtree1_kcal_animals(iso,kfo_ap)  Demand for animal products
  q15_foodtree1_kcal_processed(iso,kfo_pf) Demand for processed products
  q15_foodtree1_kcal_staples(iso,kfo_st)     Demand for staple products
  q15_foodtree1_kcal_vegetables(iso)     Demand for vegetable and fruits products

;


positive variables
  v15_kcal_regression(iso,kfo)     Uncalibrated regression estimates of calorie demand (Kcal\cap\day)
  v15_kcal_regression_total(iso)     Uncalibrated regression estimates of  total per capita calories (Kcal\cap\day)
  v15_livestock_share_iso(iso)       Uncalibrated regression estimates of  livestock share
  v15_processed_share_iso(iso)        Uncalibrated regression estimates of  processed share
  v15_vegfruit_share_iso(iso)       Uncalibrated regression estimates of share of vegetables fruits and nuts within diet
  v15_income_pc_real_ppp_iso(iso)    real income per capita (USD)
;

variables

  v15_demand_nonfood(iso)            non-food demand (units)
  v15_objective                      objective term
  v15_objective_standalone           objective term standalone

;

parameters
* technical
 p15_modelstat(t)                             model solver status
 p15_iteration_counter(t)                     number of iterations required for reaching an equilibrium between food demand model and magpie
 p15_convergence_measure(t)                   convergence measure to decide for continuation or stop of food_demand - magpie iteration

*prices
 p15_prices_kcal(t,iso,kfo)                   prices from magpie after optimization in US Dollar 05 per Kcal ($\Kcal)
 o15_prices_kcal(t,iso,kfo)                  prices from magpie after optimization in US Dollar 05 per Kcal ($\Kcal)
 i15_prices_initial_kcal(iso,kfo)             initial prices that capture the approximate level of prices in 1961-2010 in US Dollar 05 ($\Kcal)

* diet structure

 i15_staples_kcal_structure_iso(t,iso,kfo_st)    Share of a staple product within total staples (1)
 i15_livestock_kcal_structure_iso(t,iso,kfo_ap)  Share of a livestock product within total staples (1)
 i15_processed_kcal_structure_iso                Share of a processed product within total staples (1)
 i15_staples_kcal_iso_tmp(t,iso)    Intermediate calculation do not use elsewhere
 i15_livestock_kcal_iso_tmp(t,iso)  Intermediate calculation do not use elsewhere

* diet calibration
  p15_kcal_balanceflow(t,iso,kfo)               balanceflow to diverge from mean calories of regressions
  p15_kcal_balanceflow_lastcalibrationyear(iso,kfo) the balanceflow for the last year with observations

* before shock

 o15_kcal_regression_initial(iso,kfo)        Uncalibrated per-capita demand before price shock (kcal per capita per day)
 p15_kcal_pc_initial(t,i,kfo)               Per-capita consumption in food demand model before price shock (kcal per capita per day)
 p15_kcal_pc_initial_iso(t,iso,kfo)          Per-capita consumption in food demand model before price shock on iso level (kcal per capita per day)
 p15_demand_nonfood_iso_initial(t,iso)       non-food per-capita demand (units per capita)

* after price shock
 p15_kcal_pc_iso(t,iso,kfo)                  Per-capita consumption in food demand model after price shock (kcal per capita per day)
 p15_kcal_pc(t,i,kfo)                       Per-capita consumption in food demand model after price shock (kcal per capita per day)

* calculate diet iteration breakpoint

  p15_income_pc_real_ppp(t,i)                 regional per-capita income after price shock (GDP per capita in MAgPIE currency)
  p15_delta_income_pc_real_ppp(t,i)           regional change in per-capita income due to price shock (1)
  p15_lastiteration_delta_income_pc_real_ppp(i) regional change in per-capita income due to price shock of last iteration (1)

;

scalars
 s15_prices_nonfood          nonfood price (US Dollar per unit)  /1/
 s15_prices_nonfood_initial  nonfood price before shock (US Dollar per unit)  /1/
 s15_year                    current year as integer value  /2000/
 s15_maxiter                 maximum iteration number /5/
 s15_standalone              standalone activated / 0 /
;



model m15_food_demand /
      q15_aim,
      q15_budget,
      q15_real_income,
      q15_regression1_kcal,
      q15_regression1_animals,
      q15_regression1_processed,
      q15_regression1_vegfruit,
      q15_foodtree1_kcal_animals,
      q15_foodtree1_kcal_processed,
      q15_foodtree1_kcal_staples,
      q15_foodtree1_kcal_vegetables/;

m15_food_demand.optfile   = 0 ;
m15_food_demand.scaleopt  = 1 ;
m15_food_demand.solprint  = 1 ;
m15_food_demand.holdfixed = 1 ;

model magpiemini /
      q15_food_demand,
      q15_aim_standalone/;




*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_food(t,i,kall,type)                       Demand for food (Mt DM)
 ov15_kcal_pc(t,i,kfo,type)                       Per capita calories (kcal per capita per day)
 ov15_kcal_regression(t,iso,kfo,type)             Uncalibrated regression estimates of calorie demand (Kcal\cap\day)
 ov15_kcal_regression_total(t,iso,type)           Uncalibrated regression estimates of  total per capita calories (Kcal\cap\day)
 ov15_livestock_share_iso(t,iso,type)             Uncalibrated regression estimates of  livestock share
 ov15_processed_share_iso(t,iso,type)             Uncalibrated regression estimates of  processed share
 ov15_vegfruit_share_iso(t,iso,type)              Uncalibrated regression estimates of share of vegetables fruits and nuts within diet
 ov15_income_pc_real_ppp_iso(t,iso,type)          real income per capita (USD)
 ov15_demand_nonfood(t,iso,type)                  non-food demand (units)
 ov15_objective(t,type)                           objective term
 ov15_objective_standalone(t,type)                objective term standalone
 oq15_food_demand(t,i,kfo,type)                   Food demand (million Kcal)
 oq15_aim(t,type)                                 aim function food demand model
 oq15_aim_standalone(t,type)                      aim function standalone model
 oq15_budget(t,iso,type)                          Household Budget Constraint
 oq15_real_income(t,iso,type)                     Calculation of real income
 oq15_regression1_kcal(t,iso,type)                Per capita total consumption
 oq15_regression1_animals(t,iso,type)             Livestock share
 oq15_regression1_processed(t,iso,type)           Processed share
 oq15_regression1_vegfruit(t,iso,type)            Vegetables and fruits share
 oq15_foodtree1_kcal_animals(t,iso,kfo_ap,type)   Demand for animal products
 oq15_foodtree1_kcal_processed(t,iso,kfo_pf,type) Demand for processed products
 oq15_foodtree1_kcal_staples(t,iso,kfo_st,type)   Demand for staple products
 oq15_foodtree1_kcal_vegetables(t,iso,type)       Demand for vegetable and fruits products
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
