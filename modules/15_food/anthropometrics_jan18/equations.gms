*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



q15_food_demand(i2,kfo) ..
                (vm_dem_food(i2,kfo) + sum(ct, f15_household_balance_flow(ct,i2,kfo,"dm")))
                * sum(ct,(f15_nutrition_attributes(ct,kfo,"kcal") * 10**6))
                =g=
                sum(ct,im_pop(ct,i2) * p15_kcal_pc(ct,i2,kfo)) * 365
                ;

**** ### Elastic Food Demand

q15_aim ..
          v15_objective
          =e=
          sum(iso,v15_income_pc_real_ppp_iso(iso));

q15_aim_standalone ..
          v15_objective_standalone
          =e=
          sum(iso,v15_kcal_regression_total(iso));

q15_budget(iso) ..
         sum((ct,kfo), v15_kcal_regression(iso,kfo)*365*p15_prices_kcal(ct,iso,kfo))
         + v15_demand_nonfood(iso)*s15_prices_nonfood
         =e=
         sum(ct,im_gdp_pc_ppp_iso(ct,iso))
         ;

q15_real_income(iso) ..
         v15_income_pc_real_ppp_iso(iso)
         =e=
         sum((kfo), v15_kcal_regression(iso,kfo)*365*i15_prices_initial_kcal(iso,kfo))
         + v15_demand_nonfood(iso)*s15_prices_nonfood_initial;
;


* Foodtree One

q15_regression_intake(iso,sex,age_group) ..
         v15_kcal_intake_regression(iso,sex,age_group)
         =e=
         sum(ct,p15_kcal_requirement(ct,iso,sex,age_group))*
         (
            f15_intake_regression_parameters(sex,age_group,"saturation")*v15_income_pc_real_ppp_iso(iso)
            /(f15_intake_regression_parameters(sex,age_group,"halfsaturation")+v15_income_pc_real_ppp_iso(iso))
            +f15_intake_regression_parameters(sex,age_group,"intercept")
         )
         +sum(ct,p15_intake_balanceflow(ct,iso,sex,age_group))
         ;


q15_regression_kcal(iso) ..
         v15_kcal_regression_total(iso)
         =e=
         sum((sex,age_group,ct),v15_kcal_intake_regression(iso,sex,age_group)
         *(i15_par("kcal","a") + i15_par("kcal","b")*v15_income_pc_real_ppp_iso(iso)
         /(i15_par("kcal","c") + v15_income_pc_real_ppp_iso(iso)**i15_par("kcal","d")))
         * im_demography(ct,iso,sex,age_group))
         /sum((sex,age_group,ct), im_demography(ct,iso,sex,age_group));



  q15_regression_animals(iso) ..
         v15_livestock_share_iso(iso)
         =e=
         i15_par("livs","a") + i15_par("livs","b")*v15_income_pc_real_ppp_iso(iso)
         /(i15_par("livs","c") + v15_income_pc_real_ppp_iso(iso)**i15_par("livs","d"));




q15_regression_processed(iso) ..
         v15_processed_share_iso(iso)
         =e=
* SSP1
$ifthen "%c15_food_scenario%"=="SSP1"   (95.61*v15_income_pc_real_ppp_iso(iso)/(1.523e+06+v15_income_pc_real_ppp_iso(iso)**1.5))
* SSP2
$elseif "%c15_food_scenario%"=="SSP2"   (0.4884*v15_income_pc_real_ppp_iso(iso)/(4039+v15_income_pc_real_ppp_iso(iso)))
* SSP3
$elseif "%c15_food_scenario%"=="SSP3"   (0.1715*v15_income_pc_real_ppp_iso(iso)/(1039+v15_income_pc_real_ppp_iso(iso)**0.9))
* SSP4
$elseif "%c15_food_scenario%"=="SSP4"   (95.61*v15_income_pc_real_ppp_iso(iso)/(1.523e+06+v15_income_pc_real_ppp_iso(iso)**1.5))
* SSP5
$elseif "%c15_food_scenario%"=="SSP5"   (95.61*v15_income_pc_real_ppp_iso(iso)/(1.523e+06+v15_income_pc_real_ppp_iso(iso)**1.5))
$endif
         ;




q15_regression_vegfruit(iso) ..
         v15_vegfruit_share_iso(iso)
         =e=
* SSP1
$ifthen "%c15_food_scenario%"=="SSP1"   (0.02333*v15_income_pc_real_ppp_iso(iso)/(325.1+v15_income_pc_real_ppp_iso(iso)**0.8))
* SSP2
$elseif "%c15_food_scenario%"=="SSP2"   (0.1868*v15_income_pc_real_ppp_iso(iso)/(4.432e+03+v15_income_pc_real_ppp_iso(iso)))
* SSP3
$elseif "%c15_food_scenario%"=="SSP3"   (1.509*v15_income_pc_real_ppp_iso(iso)/(4.829e+04+v15_income_pc_real_ppp_iso(iso)**1.2))
* SSP4
$elseif "%c15_food_scenario%"=="SSP4"   (0.1868*v15_income_pc_real_ppp_iso(iso)/(4.432e+03+v15_income_pc_real_ppp_iso(iso)))
* SSP5
$elseif "%c15_food_scenario%"=="SSP5"   (0.02333*v15_income_pc_real_ppp_iso(iso)/(325.1+v15_income_pc_real_ppp_iso(iso)**0.8))
$endif
         ;



q15_foodtree_kcal_animals(iso,kfo_ap) ..
         v15_kcal_regression(iso,kfo_ap)
         =e=
         v15_kcal_regression_total(iso)
         * v15_livestock_share_iso(iso)
         * sum(ct,i15_livestock_kcal_structure_iso(ct,iso,kfo_ap));

q15_foodtree_kcal_processed(iso,kfo_pf) ..
         v15_kcal_regression(iso,kfo_pf)
         =e=
         v15_kcal_regression_total(iso)
         * (1 - v15_livestock_share_iso(iso))
         * v15_processed_share_iso(iso)
         * sum(ct,i15_processed_kcal_structure_iso(ct,iso,kfo_pf)) ;

q15_foodtree_kcal_vegetables(iso) ..
         v15_kcal_regression(iso,"others")
         =e=
         v15_kcal_regression_total(iso)
         * (1 - v15_livestock_share_iso(iso))
         * (1 - v15_processed_share_iso(iso))
         * v15_vegfruit_share_iso(iso);

q15_foodtree_kcal_staples(iso,kfo_st) ..
         v15_kcal_regression(iso,kfo_st)
         =e=
         v15_kcal_regression_total(iso)
         * (1 - v15_livestock_share_iso(iso))
         * (1 - v15_processed_share_iso(iso))
         * (1 - v15_vegfruit_share_iso(iso))
         * sum(ct,i15_staples_kcal_structure_iso(ct,iso,kfo_st)) ;
