i15_gdp_iso(t,iso) = f15_gdp_iso(t,iso,"%c15_gdp_scenario%");
i15_pop_iso(t,iso) = f15_pop_iso(t,iso,"%c15_pop_scenario%");
i15_gdp(t,i) = sum(i_to_iso(i,iso),i15_gdp_iso(t,iso));
i15_pop(t,i) = sum(i_to_iso(i,iso),i15_pop_iso(t,iso));

im_gdp_pc(t,i) = i15_gdp(t,i)/i15_pop(t,i);
im_development_state(t,i) = f15_development_state(t,i,"%c15_gdp_scenario%");

i15_gdp_pc_iso(t,iso)=0;
i15_gdp_pc_iso(t,iso)$(f15_gdp_iso(t,iso,"%c15_gdp_scenario%")*f15_pop_iso(t,iso,"%c15_pop_scenario%")>0)  = f15_gdp_iso(t,iso,"%c15_gdp_scenario%")/f15_pop_iso(t,iso,"%c15_pop_scenario%");
i15_gdp_pc_iso(t,iso)$(i15_gdp_pc_iso(t,iso)=0) = sum(i_to_iso(i,iso),im_gdp_pc(t,i));
i15_pop_iso(t,iso) = f15_pop_iso(t,iso,"%c15_pop_scenario%");

i15_prices_initial_kcal(iso,kfo)$(f15_nutrition_attributes("y1995",kfo,"kcal")>0)=f15_prices_initial(kfo) / f15_nutrition_attributes("y1995",kfo,"kcal")*365/10**6;

p15_prices_kcal(t,iso,kfo)=i15_prices_initial_kcal(iso,kfo);

f15_staples_kcal_structure_iso(t,iso,kst)$sum(kst2,f15_staples_kcal_structure_iso(t,iso,kst)=0) = sum(i_to_iso(i,iso),f15_staples_kcal_structure(t,i,kst));
f15_livestock_kcal_structure_iso(t,iso,kap)$sum(kst2,f15_livestock_kcal_structure_iso(t,iso,kap)=0) = sum(i_to_iso(i,iso),f15_livestock_kcal_structure(t,i,kap));


* Calculate exogenous food demand

i15_kcal_pc_initial(t,i,kfo)=0;

i15_kcal_pc_initial(t,i,kap)
=
f15_kcal_pc(t,i,"%c15_food_scenario%")*
f15_livestock_share(t,i,"%c15_food_scenario%")*
f15_livestock_kcal_structure(t,i,kap);

i15_kcal_pc_initial(t,i,kst)
=
f15_kcal_pc(t,i,"%c15_food_scenario%")*
(1-f15_livestock_share(t,i,"%c15_food_scenario%")-f15_vegfruit_share(t,i,"%c15_food_scenario%"))*
f15_staples_kcal_structure(t,i,kst);

i15_kcal_pc_initial(t,i,"others")
=
f15_kcal_pc(t,i,"%c15_food_scenario%")*
(1-f15_livestock_share(t,i,"%c15_food_scenario%")-f15_vegfruit_share(t,i,"%c15_food_scenario%"))*
f15_vegfruit_share(t,i,"%c15_food_scenario%");
