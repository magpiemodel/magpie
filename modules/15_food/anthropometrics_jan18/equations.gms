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
          sum(iso,v15_income_pc_real_ppp_iso(iso) - 10**6*v15_income_balance(iso));

q15_aim_standalone ..
          v15_objective_standalone
          =e=
          sum(iso,v15_kcal_regression_total(iso));

q15_budget(iso) ..
         v15_income_pc_real_ppp_iso(iso)
         =e=
         sum((ct,kfo), v15_kcal_regression(iso,kfo)*365*(i15_prices_initial_kcal(iso,kfo)-p15_prices_kcal(ct,iso,kfo)))
         + sum(ct,im_gdp_pc_ppp_iso(ct,iso)) + v15_income_balance(iso);


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
         v15_regression(iso, "overconsumption")
         * sum((sex,age_group,ct), v15_kcal_intake_regression(iso,sex,age_group)
         * im_demography(ct,iso,sex,age_group))
         /sum((sex,age_group,ct), im_demography(ct,iso,sex,age_group));


  q15_regression(iso, demand_subsystem15) ..
         v15_regression(iso, demand_subsystem15)
         =e=
         i15_demand_regression_parameters(demand_subsystem15,"intercept") +
         i15_demand_regression_parameters(demand_subsystem15,"saturation") * v15_income_pc_real_ppp_iso(iso)
         /(i15_demand_regression_parameters(demand_subsystem15,"halfsaturation") + v15_income_pc_real_ppp_iso(iso)**i15_demand_regression_parameters(demand_subsystem15,"non_saturation"));

q15_foodtree_kcal_animals(iso,kfo_ap) ..
         v15_kcal_regression(iso,kfo_ap)
         =e=
         v15_kcal_regression_total(iso)
         * v15_regression(iso, "livestockshare")
         * sum(ct,i15_livestock_kcal_structure_iso(ct,iso,kfo_ap));

q15_foodtree_kcal_processed(iso,kfo_pf) ..
         v15_kcal_regression(iso,kfo_pf)
         =e=
         v15_kcal_regression_total(iso)
         * (1 - v15_regression(iso, "livestockshare"))
         * v15_regression(iso, "processedshare")
         * sum(ct,i15_processed_kcal_structure_iso(ct,iso,kfo_pf)) ;

q15_foodtree_kcal_vegetables(iso) ..
         v15_kcal_regression(iso,"others")
         =e=
         v15_kcal_regression_total(iso)
         * (1 - v15_regression(iso, "livestockshare"))
         * (1 - v15_regression(iso, "processedshare"))
         * v15_regression(iso, "vegfruitshare");

q15_foodtree_kcal_staples(iso,kfo_st) ..
         v15_kcal_regression(iso,kfo_st)
         =e=
         v15_kcal_regression_total(iso)
         * (1 - v15_regression(iso, "livestockshare"))
         * (1 - v15_regression(iso, "processedshare"))
         * (1 - v15_regression(iso, "vegfruitshare"))
         * sum(ct,i15_staples_kcal_structure_iso(ct,iso,kfo_st)) ;
