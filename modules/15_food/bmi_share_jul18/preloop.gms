

 i15_dem_intercept(regr15)   = f15_demand_paras(regr15,"%c15_food_scenario%","intercept");
 i15_dem_saturation(regr15)  = f15_demand_paras(regr15,"%c15_food_scenario%","saturation");
 i15_dem_halfsat(regr15)     = f15_demand_paras(regr15,"%c15_food_scenario%","halfsaturation");
 i15_dem_nonsat(regr15)      = f15_demand_paras(regr15,"%c15_food_scenario%","non_saturation");

 i15_bmi_intercept(sex,agegroup15,bmi_tree15)  = f15_bmi_shr_paras(sex,agegroup15,bmi_tree15,"intercept");
 i15_bmi_saturation(sex,agegroup15,bmi_tree15) = f15_bmi_shr_paras(sex,agegroup15,bmi_tree15,"saturation");
 i15_bmi_halfsat(sex,agegroup15,bmi_tree15)    = f15_bmi_shr_paras(sex,agegroup15,bmi_tree15,"halfsaturation");

p15_bodyheight(t,iso,sex,age,estimates15) = f15_bodyheight(t,iso,sex,age);

* calculating growth food for historical period
* in case it starts before period use values of first timestep

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

p15_lastiteration_delta_income(i) = 1;


$ifthen "%c15_rumscen%" == "mixed" i15_ruminant_fadeout(t) = (f15_ruminant_fadeout(t,"constant") + f15_ruminant_fadeout(t,"halving2050"))/2;
$else i15_ruminant_fadeout(t) = f15_ruminant_fadeout(t,"%c15_rumscen%");
$endif