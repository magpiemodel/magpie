*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*' @equations

q15_food_demand(i2,kfo) ..
                (vm_dem_food(i2,kfo) + sum(ct, f15_household_balance_flow(ct,i2,kfo,"dm")))
                * sum(ct,(f15_nutrition_attributes(ct,kfo,"kcal") * 10**6)) =g=
                sum(ct,im_pop(ct,i2) *
                (p15_kcal_pc(ct,i2,kfo)+p15_balanceflow_kcal(ct,i2,kfo))) * 365
                ;

*' The constraint transforms the fooduse of agricultural products into per-capita
*' food demand.
*' vm_dem_food is the fooduse of agricultural products. Its measured in tons dry matter
*' before processing. Multiplying with the nutrition attributes provides the equivalent
*' in calories. While nutrition attributes are assumed to be globally the same
*' (assumption of homogeneous products), a regional balanceflow is used to account
*' for current differences in food processing, where some regions get different calories
*' from the same fooduse quantitiy. Depending on the inputdata, the balanceflow
*' may fade out in the future, which implies actual homogeneous products.

*' The subsequent equations belong to the standalone food demand model, which is
*' executed before MAgPIE or iterated with MAgPIE. They are excluded from the run
*' of MAgPIE itself.

q15_aim ..
          v15_objective =e=
          sum(iso,v15_income_pc_real_ppp_iso(iso)
          - 10**6*v15_income_balance(iso));

*' In principle, the food demand model has only one solution which satifies all
*' equations. The objective could therefore be choosen arbirtrarily, and the
*' solver just finds the single solution.
*' However, if the model is executed outside its domain
*' (e.g. with extreme price shocks), it can happen that real income turns
*' negative (because the increase in food value exceeds the available income).
*' To avoid this case, we allow for a punishment term v15_income_balance, which
*' increases the real income, but which negatively affects the maximized
*' objective variable, disincentivizing its use in cases where not needed.


q15_budget(iso) ..
         v15_income_pc_real_ppp_iso(iso) =e=
         sum((ct,kfo), v15_kcal_regression(iso,kfo)*365
         *(i15_prices_initial_kcal(iso,kfo)-p15_prices_kcal(ct,iso,kfo)))
         + sum(ct,im_gdp_pc_ppp_iso(ct,iso)) + v15_income_balance(iso);

*' The budget constraint calculates the real income after an eventual price
*' shock. The basic assumption is that increasing prices reduce real income,
*' while decreasing prices increase real income.
*' Through this income effect, higher prices reduce the food demand.
*' The income before the food price shock is im_gdp_pc_ppp.
*' Its reduced by the change in value of the demanded calories under changed
*' prices.
*' In the following, the real income is used to determine food intake,
*' food demand as well as dietary composition.

q15_regression_intake(iso,sex,age) ..
         v15_kcal_intake_regression(iso,sex,age) =e=
         sum(ct,p15_kcal_requirement(ct,iso,sex,age)
         + p15_kcal_pregnancy(ct,iso,sex,age))
         * ((f15_intake_regr_paras(sex,age,"saturation")*v15_income_pc_real_ppp_iso(iso))
            /(f15_intake_regr_paras(sex,age,"halfsaturation")+v15_income_pc_real_ppp_iso(iso))
            +f15_intake_regr_paras(sex,age,"intercept"))
         ;

*' Food intake is based on food requirement (the calories requried for a
*' normalized bodymass index under a given body height), and a regression
*' based on income which estimates how much the actual intake is relative to
*' the requried intake.


q15_regression_kcal(iso) ..
         v15_kcal_regression_total(iso) =e=
         v15_regression(iso, "overconsumption")
         * sum((sex,age,ct), v15_kcal_intake_regression(iso,sex,age)
         * im_demography(ct,iso,sex,age))
         / sum((sex,age,ct), im_demography(ct,iso,sex,age));

*' Food demand is based on food intake and a regression
*' based on income which estimates how much the actual demand is relative to
*' the requried intake.
*' The difference between demand and intake is food waste (not explcitly
*' mentioned in this equation)

q15_regression(iso, demand_subsys15) ..
         v15_regression(iso, demand_subsys15) =e=
         i15_demand_regr_paras(demand_subsys15,"intercept")
         + (i15_demand_regr_paras(demand_subsys15,"saturation") * v15_income_pc_real_ppp_iso(iso))
         / (i15_demand_regr_paras(demand_subsys15,"halfsaturation") + v15_income_pc_real_ppp_iso(iso)**i15_demand_regr_paras(demand_subsys15,"non_saturation"));

*' This equation estimates key dietary composition regression factors,
*' such as the share of animal products, empty calories, or
*' fruit vegetables and nuts. In the subsequent equations, those parameters
*' are used to determine the dietary composition using an hirachical tree:
*' Total calories are first divided into animal and plant based; the plant-based
*' are further divided into processed empty calories and nutritious calories
*' and so on.

q15_foodtree_kcal_animals(iso,kfo_ap) ..
         v15_kcal_regression(iso,kfo_ap) =e=
         v15_kcal_regression_total(iso)
         * v15_regression(iso, "livestockshare")
         * sum(ct,i15_livestock_kcal_structure_iso(ct,iso,kfo_ap));

q15_foodtree_kcal_processed(iso,kfo_pf) ..
         v15_kcal_regression(iso,kfo_pf) =e=
         v15_kcal_regression_total(iso)
         * (1 - v15_regression(iso, "livestockshare"))
         * v15_regression(iso, "processedshare")
         * sum(ct,i15_processed_kcal_structure_iso(ct,iso,kfo_pf)) ;

q15_foodtree_kcal_vegetables(iso) ..
         v15_kcal_regression(iso,"others") =e=
         v15_kcal_regression_total(iso)
         * (1 - v15_regression(iso, "livestockshare"))
         * (1 - v15_regression(iso, "processedshare"))
         * v15_regression(iso, "vegfruitshare");

q15_foodtree_kcal_staples(iso,kfo_st) ..
         v15_kcal_regression(iso,kfo_st) =e=
         v15_kcal_regression_total(iso)
         * (1 - v15_regression(iso, "livestockshare"))
         * (1 - v15_regression(iso, "processedshare"))
         * (1 - v15_regression(iso, "vegfruitshare"))
         * sum(ct,i15_staples_kcal_structure_iso(ct,iso,kfo_st)) ;