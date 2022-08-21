*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: c15_livescenmagpie@pik-potsdam.de

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


* ###### Exogenous food waste and diet scenarios as well as food substitution scenarios


* Switch to determine countries for which  exogenous food scenarios (EAT Lancet diet and
* food waste scenarios), and food substitution scenarios shall be applied.
* In the default case, the exogenous food scenarios affect all countries.
p15_country_dummy(iso) = 0;
p15_country_dummy(scen_countries15) = 1;

* Food substitution scenarios including functional forms, targets and transition periods
i15_ruminant_fadeout(t,iso) = 1 - p15_country_dummy(iso)*(1-f15_food_substitution_fader(t,"%c15_rumscen%"));
i15_fish_fadeout(t,iso) = 1 - p15_country_dummy(iso)*(1-f15_food_substitution_fader(t,"%c15_fishscen%"));
i15_alcohol_fadeout(t,iso) = 1 - p15_country_dummy(iso)*(1-f15_food_substitution_fader(t,"%c15_alcscen%"));
i15_livestock_fadeout(t,iso) = 1 - p15_country_dummy(iso)*(1-f15_food_substitution_fader(t,"%c15_livescen%"));
i15_rumdairy_fadeout(t,iso) = 1 - p15_country_dummy(iso)*(1-f15_food_substitution_fader(t,"%c15_rumdairyscen%"));
i15_rumdairy_scp_fadeout(t,iso) = 1 - p15_country_dummy(iso)*(1-f15_food_substitution_fader(t,"%c15_rumdairy_scp_scen%"));
i15_livestock_fadeout_threshold(t,iso) = 1 - p15_country_dummy(iso)*(1-f15_food_substitution_fader(t,"%c15_livescen_target%"));


* Exogenous food intake and waste scenarios including functional forms, targets and transition periods
i15_exo_foodscen_fader(t,iso) = (1-f15_food_substitution_fader(t,"%c15_exo_foodscen%")) * p15_country_dummy(iso);

* Select from the data set of EAT Lancet scenarios the target years that are
* consistent with the target year of the fader:

$ifthen "%c15_exo_foodscen%" == "lin_zero_20_30"
  i15_intake_EATLancet_all(iso,kcal_scen15,EAT_scen15,kfo) = f15_intake_EATLancet("y2030",iso,kcal_scen15,EAT_scen15,kfo);
$else
  i15_intake_EATLancet_all(iso,kcal_scen15,EAT_scen15,kfo) = f15_intake_EATLancet("y2050",iso,kcal_scen15,EAT_scen15,kfo);
$endif

* initial prices in $US per Kcal
i15_prices_initial_kcal(iso,kfo)$(f15_nutrition_attributes("y1995",kfo,"kcal")>0) = f15_prices_initial(kfo)
                                                                                  / (f15_nutrition_attributes("y1995",kfo,"kcal")*10**6);
p15_prices_kcal(t,iso,kfo,"iter1")=i15_prices_initial_kcal(iso,kfo);
p15_convergence_measure(t,iter15)=NA;
