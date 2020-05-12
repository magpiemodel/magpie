*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

 i15_bmi_intercept(sex,agegroup15,bmi_tree15)  = f15_bmi_shr_paras(sex,agegroup15,bmi_tree15,"intercept");
 i15_bmi_saturation(sex,agegroup15,bmi_tree15) = f15_bmi_shr_paras(sex,agegroup15,bmi_tree15,"saturation");
 i15_bmi_halfsat(sex,agegroup15,bmi_tree15)    = f15_bmi_shr_paras(sex,agegroup15,bmi_tree15,"halfsaturation");

p15_bodyheight(t,iso,sex,age,estimates15) = f15_bodyheight(t,iso,sex,age);

* calculating growth food for historical period

loop(t_past,
     if (ord(t_past)>3,
       p15_kcal_growth_food(t_past,iso,"10--14") = sum(growth_food15, f15_kcal_pc_iso(t_past-3,iso,growth_food15));
       p15_kcal_growth_food(t_past,iso,"5--9") = sum(growth_food15, f15_kcal_pc_iso(t_past-2,iso,growth_food15));
       p15_kcal_growth_food(t_past,iso,"0--4") = sum(growth_food15, f15_kcal_pc_iso(t_past-1,iso,growth_food15));
     Elseif ord(t_past)=3,
       p15_kcal_growth_food(t_past,iso,"10--14") = sum(growth_food15, f15_kcal_pc_iso(t_past-2,iso,growth_food15));
       p15_kcal_growth_food(t_past,iso,"5--9") = sum(growth_food15, f15_kcal_pc_iso(t_past-2,iso,growth_food15));
       p15_kcal_growth_food(t_past,iso,"0--4") = sum(growth_food15, f15_kcal_pc_iso(t_past-1,iso,growth_food15));
     Elseif ord(t_past)=2,
       p15_kcal_growth_food(t_past,iso,"10--14") = sum(growth_food15, f15_kcal_pc_iso(t_past-1,iso,growth_food15));
       p15_kcal_growth_food(t_past,iso,"5--9") = sum(growth_food15, f15_kcal_pc_iso(t_past-1,iso,growth_food15));
       p15_kcal_growth_food(t_past,iso,"0--4") = sum(growth_food15, f15_kcal_pc_iso(t_past-1,iso,growth_food15));
     Elseif ord(t_past)=1,
       p15_kcal_growth_food(t_past,iso,"10--14") = sum(growth_food15, f15_kcal_pc_iso(t_past-0,iso,growth_food15));
       p15_kcal_growth_food(t_past,iso,"5--9") = sum(growth_food15, f15_kcal_pc_iso(t_past-0,iso,growth_food15));
       p15_kcal_growth_food(t_past,iso,"0--4") = sum(growth_food15, f15_kcal_pc_iso(t_past-0,iso,growth_food15));
     );
);

* initial prices in $US per Kcal
i15_prices_initial_kcal(iso,kfo)$(f15_nutrition_attributes("y1995",kfo,"kcal")>0) = f15_prices_initial(kfo)
                                                                                  / (f15_nutrition_attributes("y1995",kfo,"kcal")*10**6);
p15_prices_kcal(t,iso,kfo)=i15_prices_initial_kcal(iso,kfo);

p15_lastiteration_delta_income(t,i) = 1;



* Temporal development of ruminant meat share within the livestock food product
* group (applied before food demand model is executed)
$ifthen "%c15_rum_share%" == "mixed" i15_rum_share_fadeout(t,iso) = (f15_rum_share_fadeout(t,"constant") + f15_rum_share_fadeout(t,"halving2050"))/2;
$else i15_rum_share_fadeout(t,iso) = f15_rum_share_fadeout(t,"%c15_rum_share%");
$endif

* Stronger ruminant fadeout for India
if (s15_rum_share_fadeout_india_strong = 1,
	i15_rum_share_fadeout(t,"IND") = f15_rum_share_fadeout_india(t);
);

* Milk fadeout for India
if (s15_milk_share_fadeout_india = 0,
	i15_milk_share_fadeout_india(t) = 1;
Elseif s15_milk_share_fadeout_india = 1,
	i15_milk_share_fadeout_india(t) = f15_milk_share_fadeout_india(t);
);

display i15_milk_share_fadeout_india;






* ###### Exogenous food waste and diet scenarios as well as food substitution scenarios


* Initialisation of the ratio between food calorie demand and food intake for the
* historical reference period:
p15_demand2intake_ratio_ref(i) = 0;



* Switch to determine countries for which  exogenous food scenarios (EAT Lancet diet and 
* food waste scenarios), and food substitution scenarios shall be applied.
* In the default case, the food scenario affects all countries when activated.
p15_country_dummy(iso) = 0;
p15_country_dummy(scen_countries15) = 1;


* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p15_foodscen_region_shr(t_all,i) = sum(i_to_iso(i,iso), p15_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));


* The target year for transition to exogenous scenario diets defines the speed
* of fading from regression based daily food consumption towards the scenario.
* Note: p15_foodscen_region_shr(t,i) is 1 in the default case)
i15_exo_foodscen_fader(t,i) = f15_exo_foodscen_fader(t,"%c15_exo_scen_targetyear%") * p15_foodscen_region_shr(t,i);


* Food substitution scenarios including functional forms, targets and transition periods
* Note: p15_foodscen_region_shr(t,i) is 1 in the default case)
i15_ruminant_fadeout(t,i) = f15_food_substitution_fader(t,"%c15_rumscen%") * p15_foodscen_region_shr(t,i);
i15_fish_fadeout(t,i) = f15_food_substitution_fader(t,"%c15_fishscen%") * p15_foodscen_region_shr(t,i);
i15_alcohol_fadeout(t,i) = f15_food_substitution_fader(t,"%c15_alcscen%") * p15_foodscen_region_shr(t,i);
i15_livestock_fadeout(t,i) = f15_food_substitution_fader(t,"%c15_livescen%") * p15_foodscen_region_shr(t,i);
i15_rumdairy_fadeout(t,i) = f15_food_substitution_fader(t,"%c15_rumdairyscen%") * p15_foodscen_region_shr(t,i);



