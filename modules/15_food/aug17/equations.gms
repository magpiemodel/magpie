*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



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
*         3000;
         sum(ct,exp(2.825+m_year(ct)*0.002131)*v15_income_pc_real_ppp_iso(iso)**(0.162+m_year(ct)*(-0.00003124)));

q15_regression1_animals(iso) ..
         v15_livestock_share_iso(iso)
         =e=
         0.3157*v15_income_pc_real_ppp_iso(iso)/(4151+v15_income_pc_real_ppp_iso(iso));
*         sum(ct,
*                 (1.372/100 - 5.295 /1000000* m_year(ct)) * v15_income_pc_real_ppp_iso(iso)**0.5
*                 * exp(-(-1.102 /10000 + 6.404  / 100000000 * m_year(ct))*v15_income_pc_real_ppp_iso(iso))
*         );

q15_regression1_processed(iso) ..
         v15_processed_share_iso(iso)
         =e=
         0.4915*v15_income_pc_real_ppp_iso(iso)/(4273+v15_income_pc_real_ppp_iso(iso));
         ;

q15_regression1_vegfruit(iso) ..
         v15_vegfruit_share_iso(iso)
         =e=
         0.1871*v15_income_pc_real_ppp_iso(iso)/(2987+v15_income_pc_real_ppp_iso(iso));
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
