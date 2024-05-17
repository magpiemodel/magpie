*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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

* Switch to determine countries for which exogenous food scenarios (EAT Lancet diet and
* food waste scenarios), and food substitution scenarios shall be applied.
* In the default case, the exogenous food scenarios affect all countries.
p15_country_dummy(iso) = 0;
p15_country_dummy(scen_countries15) = 1;

** The following lines define scenario faders for substituting different food groups
* If s15_exo_foodscen_functional_form = 1, the exogenous food scenario is faded in linearly.
* If s15_exo_foodscen_functional_form = 2, the exogenous food scenario is faded in applying a sigmoid trajectory.
if (s15_food_subst_functional_form = 1,

  m_linear_time_interpol(p15_ruminant_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,s15_ruminant_substitution);
  m_linear_time_interpol(p15_fish_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,s15_fish_substitution);
  m_linear_time_interpol(p15_alcohol_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,s15_alcohol_substitution);
  m_linear_time_interpol(p15_livestock_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,s15_livestock_substitution);
  m_linear_time_interpol(p15_rumdairy_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,s15_rumdairy_substitution);
  m_linear_time_interpol(p15_rumdairy_scp_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,    s15_rumdairy_scp_substitution);
  if(s15_livescen_target = 1,
    m_linear_time_interpol(p15_livestock_threshold_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,1);
  else
    p15_livestock_threshold_subst_fader(t) = 0;
  );

elseif s15_food_subst_functional_form = 2,

  m_sigmoid_time_interpol(p15_ruminant_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,s15_ruminant_substitution);
  m_sigmoid_time_interpol(p15_fish_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,s15_fish_substitution);
  m_sigmoid_time_interpol(p15_alcohol_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,s15_alcohol_substitution);
  m_sigmoid_time_interpol(p15_livestock_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,s15_livestock_substitution);
  m_sigmoid_time_interpol(p15_rumdairy_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,s15_rumdairy_substitution);
  m_sigmoid_time_interpol(p15_rumdairy_scp_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,  s15_rumdairy_scp_substitution);
  if(s15_livescen_target = 1,
   m_sigmoid_time_interpol(p15_livestock_threshold_subst_fader,s15_food_substitution_start,s15_food_substitution_target,0,1);
  else
   p15_livestock_threshold_subst_fader(t) = 0;
  );

);


* Food substitution scenarios including functional forms, targets and transition periods
i15_ruminant_fadeout(t,iso) = 1 - p15_country_dummy(iso)*p15_ruminant_subst_fader(t);
i15_fish_fadeout(t,iso) = 1 - p15_country_dummy(iso)*p15_fish_subst_fader(t);
i15_alcohol_fadeout(t,iso) = 1 - p15_country_dummy(iso)*p15_alcohol_subst_fader(t);
i15_livestock_fadeout(t,iso) = 1 - p15_country_dummy(iso)*p15_livestock_subst_fader(t);
i15_rumdairy_fadeout(t,iso) = 1 - p15_country_dummy(iso)*p15_rumdairy_subst_fader(t);
i15_rumdairy_scp_fadeout(t,iso) = 1 - p15_country_dummy(iso)*p15_rumdairy_scp_subst_fader(t);
i15_livestock_fadeout_threshold(t,iso) = 1 - p15_country_dummy(iso)*p15_livestock_threshold_subst_fader(t);


** The following lines define the scenario fader for the exogeneous food scenario
* If s15_exo_foodscen_functional_form = 1, the exogenous food scenario is faded in linearly.
* If s15_exo_foodscen_functional_form = 2, the exogenous food scenario is faded in applying a sigmoid trajectory.
if (s15_exo_foodscen_functional_form = 1,
  m_linear_time_interpol(p15_exo_food_scenario_fader,s15_exo_foodscen_start,s15_exo_foodscen_target,0,s15_exo_foodscen_convergence);

elseif s15_exo_foodscen_functional_form = 2,
  m_sigmoid_time_interpol(p15_exo_food_scenario_fader,s15_exo_foodscen_start,s15_exo_foodscen_target,0,s15_exo_foodscen_convergence);

);

* Fade in scenarios at country level
i15_exo_foodscen_fader(t,iso) = p15_exo_food_scenario_fader(t) * p15_country_dummy(iso);

* Select from the data set of EAT Lancet scenarios the target years that are
* consistent with the target year of the fader:

if(s15_exo_foodscen_target = 2030,
  i15_intake_EATLancet_all(iso,kcal_scen15,EAT_scen15,kfo) = f15_intake_EATLancet("y2030",iso,kcal_scen15,EAT_scen15,kfo);
*extra condition to see if India diet scenario has been selected
  if (s15_exo_diet = 2,
    i15_intake_EATLancet_all(iso,kcal_scen15,EAT_scen15,kfo) = f15_intake_NIN("y2030",iso,kcal_scen15,EAT_scen15,kfo);
  );
else
  i15_intake_EATLancet_all(iso,kcal_scen15,EAT_scen15,kfo) = f15_intake_EATLancet("y2050",iso,kcal_scen15,EAT_scen15,kfo);
  if (s15_exo_diet = 2,
    i15_intake_EATLancet_all(iso,kcal_scen15,EAT_scen15,kfo) = f15_intake_NIN("y2050",iso,kcal_scen15,EAT_scen15,kfo);
  );
);

* initial prices in $US per Kcal
i15_prices_initial_kcal(iso,kfo)$(fm_nutrition_attributes("y1995",kfo,"kcal")>0) = f15_prices_initial(kfo)
                                                                                    / (fm_nutrition_attributes("y1995",kfo,"kcal")*10**6);
p15_prices_kcal(t,iso,kfo,"iter1") = i15_prices_initial_kcal(iso,kfo);
p15_convergence_measure(t,iter15) = NA;
