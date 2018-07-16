*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*' @equations

q15_food_demand(i2,kfo) ..
                (vm_dem_food(i2,kfo) + sum(ct, f15_household_balance_flow(ct,i2,kfo,"dm")))
                * sum(ct,(f15_nutrition_attributes(ct,kfo,"kcal") * 10**6)) =g=
                sum(ct,im_pop(ct,i2) * p15_kcal_pc(ct,i2,kfo)) * 365
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
          sum(iso,
          - 10**6*v15_income_balance(iso))
          - sum((iso,sex,age_group,bmi_group15),
           v15_calib_punishment(iso,sex,age_group,bmi_group15)
          );

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
         sum((ct,kfo), v15_kcal_regr(iso,kfo)*365
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

*' First we estimate the BMI distribution within the population, using
*' regression in an hierachrical tree. First we estimate the regression shares:

q15_regr_bmi_shr(iso,sex,age_overgroup15,bmi_regr_type15) ..
        v15_bmi_shr_regr(iso,sex,age_overgroup15,bmi_regr_type15)
        =e=
        f15_bmi_shr_regr_paras(sex,age_overgroup15,bmi_regr_type15,"intercept")
        + (f15_bmi_shr_regr_paras(sex,age_overgroup15,bmi_regr_type15,"saturation") * v15_income_pc_real_ppp_iso(iso))
        / (f15_bmi_shr_regr_paras(sex,age_overgroup15,bmi_regr_type15,"halfsaturation") + v15_income_pc_real_ppp_iso(iso));

*' Then we apply these regression shares to an hierarchical tree structure

q15_bmi_shr_verylow(iso,sex,age_overgroup15) ..
        v15_bmi_shr_overgroups(iso,sex,age_overgroup15,"verylow")
        =e=
        v15_bmi_shr_regr(iso,sex,age_overgroup15,"low")
        * v15_bmi_shr_regr(iso,sex,age_overgroup15,"lowsplit")
        ;

q15_bmi_shr_low(iso,sex,age_overgroup15) ..
        v15_bmi_shr_overgroups(iso,sex,age_overgroup15,"low")
        =e=
        v15_bmi_shr_regr(iso,sex,age_overgroup15,"low")
        * (1- v15_bmi_shr_regr(iso,sex,age_overgroup15,"lowsplit"))
        ;

q15_bmi_shr_medium(iso,sex,age_overgroup15) ..
        v15_bmi_shr_overgroups(iso,sex,age_overgroup15,"medium")
        =e=
        (1-v15_bmi_shr_regr(iso,sex,age_overgroup15,"low")
        -v15_bmi_shr_regr(iso,sex,age_overgroup15,"high"))
        * (1-v15_bmi_shr_regr(iso,sex,age_overgroup15,"mediumsplit"))
        ;

q15_bmi_shr_medium_high(iso,sex,age_overgroup15) ..
        v15_bmi_shr_overgroups(iso,sex,age_overgroup15,"mediumhigh")
        =e=
        (1-v15_bmi_shr_regr(iso,sex,age_overgroup15,"low")
        -v15_bmi_shr_regr(iso,sex,age_overgroup15,"high"))
        * v15_bmi_shr_regr(iso,sex,age_overgroup15,"mediumsplit")
        ;

q15_bmi_shr_high(iso,sex,age_overgroup15) ..
        v15_bmi_shr_overgroups(iso,sex,age_overgroup15,"high")
        =e=
        v15_bmi_shr_regr(iso,sex,age_overgroup15,"high")
        * (1-v15_bmi_shr_regr(iso,sex,age_overgroup15,"highsplit"))
        ;

q15_bmi_shr_veryhigh(iso,sex,age_overgroup15) ..
        v15_bmi_shr_overgroups(iso,sex,age_overgroup15,"veryhigh")
        =e=
        v15_bmi_shr_regr(iso,sex,age_overgroup15,"high")
        * v15_bmi_shr_regr(iso,sex,age_overgroup15,"highsplit")
        ;

q15_bmi_shr(iso,sex,age_group) ..
        sum(bmi_group15, v15_bmi_shr(iso,sex,age_group,bmi_group15))
        =e=
        1;

q15_bmi_shr_agg(iso,sex,age_group,bmi_group15) ..
        v15_bmi_shr(iso,sex,age_group,bmi_group15)
        =e=
        sum(agegroup2overgroup(age_overgroup15,age_group),
          v15_bmi_shr_overgroups(iso,sex,age_overgroup15,bmi_group15)
        )
        + v15_bmi_shr_calib(iso,sex,age_group,bmi_group15) ;

*' We want to calibrate BMI shares to historical values while avoiding
*' negative values or values exceeding 1
*' The following equations punish a divergence from previously
*' estimated calibration factors with additional costs. They only
*' allow for a reduction of calibration factors. The constraints
*' do not punish a change in the sahre of the category "medium", such that
*' the reduced category will be shifted into the middle BMI share group.


q51_bmi_shr_calib_high(iso,sex,age_group,bmi_group_est15)$(sum(ct,i15_bmi_shr_calib(ct,iso,sex,age_group,bmi_group_est15))>=0)..
        v15_bmi_shr_calib(iso,sex,age_group,bmi_group_est15)
        =l=
        sum(ct,i15_bmi_shr_calib(ct,iso,sex,age_group,bmi_group_est15));

q51_bmi_shr_calib_low(iso,sex,age_group,bmi_group_est15)$(sum(ct,i15_bmi_shr_calib(ct,iso,sex,age_group,bmi_group_est15))<0)..
        v15_bmi_shr_calib(iso,sex,age_group,bmi_group_est15)
        =g=
        sum(ct,i15_bmi_shr_calib(ct,iso,sex,age_group,bmi_group_est15));

q51_bmi_shr_calib(iso,sex,age_group,bmi_group_est15)..
        100*(
          sum(ct,i15_bmi_shr_calib(ct,iso,sex,age_group,bmi_group_est15))-v15_bmi_shr_calib(iso,sex,age_group,bmi_group_est15)
        )$(sum(ct,i15_bmi_shr_calib(ct,iso,sex,age_group,bmi_group_est15))>=0)
        + 100 * (
          v15_bmi_shr_calib(iso,sex,age_group,bmi_group_est15)-sum(ct,i15_bmi_shr_calib(ct,iso,sex,age_group,bmi_group_est15))
        )$(sum(ct,i15_bmi_shr_calib(ct,iso,sex,age_group,bmi_group_est15))<0)
        =e=
        v15_calib_punishment(iso,sex,age_group,bmi_group_est15);

*' Food intake is estimated based on BMI distribution, typical intakes for
*' BMI groups, demographic structure and extra energy requirements for
*' pregnancy and lactation (estimated based on the new-born population size)

q15_intake(iso)..
         v15_kcal_intake_total_regr(iso) =e=
         (
           sum((ct, sex, age_group, bmi_group15),
               v15_bmi_shr(iso,sex,age_group,bmi_group15)*
               im_demography(ct,iso,sex,age_group) *
               i15_intake(ct,iso,sex,age_group,bmi_group15)
           ) + sum(ct,i15_kcal_pregnancy(ct,iso))
         )/sum((sex,age_group,ct), im_demography(ct,iso,sex,age_group));


*' Food demand is based on food intake and a regression
*' based on income which estimates how much the actual demand is relative to
*' the requried intake.
*' The difference between demand and intake is food waste (not explcitly
*' mentioned in this equation)

q15_regr_kcal(iso) ..
         v15_kcal_regr_total(iso) =e=
         v15_regr(iso, "overconsumption")
         *v15_kcal_intake_total_regr(iso);

*' This equation estimates key dietary composition regressision factors,
*' such as the share of animal products, empty calories, or
*' fruit vegetables and nuts.

q15_regr(iso, demand_subsys15) ..
         v15_regr(iso, demand_subsys15) =e=
         i15_demand_regr_paras(demand_subsys15,"intercept")
         + (i15_demand_regr_paras(demand_subsys15,"saturation") * v15_income_pc_real_ppp_iso(iso))
         / (i15_demand_regr_paras(demand_subsys15,"halfsaturation") + v15_income_pc_real_ppp_iso(iso)**i15_demand_regr_paras(demand_subsys15,"non_saturation"));

*' In the subsequent equations, those parameters
*' are used to determine the dietary composition using an hirachical tree:
*' Total calories are first divided into animal and plant based; the plant-based
*' are further divided into processed empty calories and nutritious calories
*' and so on.

q15_foodtree_kcal_animals(iso,kfo_ap) ..
         v15_kcal_regr(iso,kfo_ap) =e=
         v15_kcal_regr_total(iso)
         * v15_regr(iso, "livestockshare")
         * sum(ct,i15_livestock_kcal_structure_iso(ct,iso,kfo_ap));

q15_foodtree_kcal_processed(iso,kfo_pf) ..
         v15_kcal_regr(iso,kfo_pf) =e=
         v15_kcal_regr_total(iso)
         * (1 - v15_regr(iso, "livestockshare"))
         * v15_regr(iso, "processedshare")
         * sum(ct,i15_processed_kcal_structure_iso(ct,iso,kfo_pf)) ;

q15_foodtree_kcal_vegetables(iso) ..
         v15_kcal_regr(iso,"others") =e=
         v15_kcal_regr_total(iso)
         * (1 - v15_regr(iso, "livestockshare"))
         * (1 - v15_regr(iso, "processedshare"))
         * v15_regr(iso, "vegfruitshare");

q15_foodtree_kcal_staples(iso,kfo_st) ..
         v15_kcal_regr(iso,kfo_st) =e=
         v15_kcal_regr_total(iso)
         * (1 - v15_regr(iso, "livestockshare"))
         * (1 - v15_regr(iso, "processedshare"))
         * (1 - v15_regr(iso, "vegfruitshare"))
         * sum(ct,i15_staples_kcal_structure_iso(ct,iso,kfo_st)) ;