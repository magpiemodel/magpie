*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



q15_food_demand(i2,kfo) ..
                (vm_dem_food(i2,kfo) + sum(ct,f15_household_balance_flow(ct,i2,kfo,"dm")))
                * sum(ct,(f15_nutrition_attributes(ct,kfo,"kcal")*10**6))
                =g=
                sum(ct,im_pop(ct,i2)) * v15_kcal_pc(i2,kfo) * 365
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

q15_regression1_kcal(iso) ..
         v15_kcal_regression_total(iso)
         =e=
         sum(ct,i15_intake_standardized_pc_iso(ct,iso))
         * (
* SSP1
*$ifthen "%c15_food_scenario%"=="SSP1"   (0.765 + 0.00649*v15_income_pc_real_ppp_iso(iso)**0.5*exp(0.00001465*v15_income_pc_real_ppp_iso(iso)))
$ifthen "%c15_food_scenario%"=="SSP1"   (9.023e-01 + exp(-1.396e-05*v15_income_pc_real_ppp_iso(iso))- exp(-8.484e-05*v15_income_pc_real_ppp_iso(iso)))
* SSP2
$elseif "%c15_food_scenario%"=="SSP2"   (0.845 + 0.671*v15_income_pc_real_ppp_iso(iso)/(v15_income_pc_real_ppp_iso(iso)+4189))
* SSP3
$elseif "%c15_food_scenario%"=="SSP3"   (21.11 - 21.218 * v15_income_pc_real_ppp_iso(iso)**(-0.0075))
* SSP4
$elseif "%c15_food_scenario%"=="SSP4"   (0.845 + 0.671*v15_income_pc_real_ppp_iso(iso)/(v15_income_pc_real_ppp_iso(iso)+4189))
* SSP5
$elseif "%c15_food_scenario%"=="SSP5"   (21.11 - 21.218 * v15_income_pc_real_ppp_iso(iso)**(-0.0075))
$endif
         );

q15_regression1_animals(iso) ..
         v15_livestock_share_iso(iso)
         =e=
* SSP1
$ifthen "%c15_food_scenario%"=="SSP1"   (0.0547 + exp(-2.578e-05*v15_income_pc_real_ppp_iso(iso)) - exp(-4.969e-05 *v15_income_pc_real_ppp_iso(iso)))
* SSP2
$elseif "%c15_food_scenario%"=="SSP2"   (0.316*v15_income_pc_real_ppp_iso(iso)/(4070+v15_income_pc_real_ppp_iso(iso)))
* SSP3
$elseif "%c15_food_scenario%"=="SSP3"   (0.006383*v15_income_pc_real_ppp_iso(iso)**0.373124)
* SSP4
$elseif "%c15_food_scenario%"=="SSP4"   (0.006383*v15_income_pc_real_ppp_iso(iso)**0.373124)
* SSP5
$elseif "%c15_food_scenario%"=="SSP5"   (0.006383*v15_income_pc_real_ppp_iso(iso)**0.373124)
$endif
         ;

q15_regression1_processed(iso) ..
         v15_processed_share_iso(iso)
         =e=
* SSP1
$ifthen "%c15_food_scenario%"=="SSP1"   (0.100 + exp(-1.535e-05*v15_income_pc_real_ppp_iso(iso)) - exp(-4.482e-05 *v15_income_pc_real_ppp_iso(iso)))
* SSP2
$elseif "%c15_food_scenario%"=="SSP2"   (0.4878*v15_income_pc_real_ppp_iso(iso)/(4023+v15_income_pc_real_ppp_iso(iso)))
* SSP3
$elseif "%c15_food_scenario%"=="SSP3"   (0.009508*v15_income_pc_real_ppp_iso(iso)**0.378022)
* SSP4
$elseif "%c15_food_scenario%"=="SSP4"   (0.4878*v15_income_pc_real_ppp_iso(iso)/(4023+v15_income_pc_real_ppp_iso(iso)))
* SSP5
$elseif "%c15_food_scenario%"=="SSP5"   (0.009508*v15_income_pc_real_ppp_iso(iso)**0.378022)
$endif
         ;

q15_regression1_vegfruit(iso) ..
         v15_vegfruit_share_iso(iso)
         =e=
* SSP1
$ifthen "%c15_food_scenario%"=="SSP1"   (0.03839*v15_income_pc_real_ppp_iso(iso)**0.19036)
* SSP2
$elseif "%c15_food_scenario%"=="SSP2"   (0.0294+0.1871*v15_income_pc_real_ppp_iso(iso)/(6805+v15_income_pc_real_ppp_iso(iso)))
* SSP3
$elseif "%c15_food_scenario%"=="SSP3"   (4.399e-02 + exp(-2.731e-05*v15_income_pc_real_ppp_iso(iso)) - exp(-4.048e-05 *v15_income_pc_real_ppp_iso(iso)))
* SSP4
$elseif "%c15_food_scenario%"=="SSP4"   (0.1901*v15_income_pc_real_ppp_iso(iso)/(3053+v15_income_pc_real_ppp_iso(iso)))
* SSP5
$elseif "%c15_food_scenario%"=="SSP5"   (-0.08718+0.03839*v15_income_pc_real_ppp_iso(iso)**0.19036)
$endif
         ;




q15_foodtree1_kcal_animals(iso,kfo_ap) ..
         v15_kcal_regression(iso,kfo_ap)
         =e=
         v15_kcal_regression_total(iso)
         * v15_livestock_share_iso(iso)
         * sum(ct,i15_livestock_kcal_structure_iso(ct,iso,kfo_ap));

q15_foodtree1_kcal_processed(iso,kfo_pf) ..
         v15_kcal_regression(iso,kfo_pf)
         =e=
         v15_kcal_regression_total(iso)
         * (1 - v15_livestock_share_iso(iso))
         * v15_processed_share_iso(iso)
         * sum(ct,i15_processed_kcal_structure_iso(ct,iso,kfo_pf)) ;

q15_foodtree1_kcal_vegetables(iso) ..
         v15_kcal_regression(iso,"others")
         =e=
         v15_kcal_regression_total(iso)
         * (1 - v15_livestock_share_iso(iso))
         * (1 - v15_processed_share_iso(iso))
         * v15_vegfruit_share_iso(iso);

q15_foodtree1_kcal_staples(iso,kfo_st) ..
         v15_kcal_regression(iso,kfo_st)
         =e=
         v15_kcal_regression_total(iso)
         * (1 - v15_livestock_share_iso(iso))
         * (1 - v15_processed_share_iso(iso))
         * (1 - v15_vegfruit_share_iso(iso))
         * sum(ct,i15_staples_kcal_structure_iso(ct,iso,kfo_st)) ;
