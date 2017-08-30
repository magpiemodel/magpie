



* initial prices in $US per Kcal
i15_prices_initial_kcal(iso,kfo)$(f15_nutrition_attributes("y1995",kfo,"kcal")>0) = f15_prices_initial(kfo)
                                                                                  / (f15_nutrition_attributes("y1995",kfo,"kcal")*10**6);
p15_prices_kcal(t,iso,kfo)=i15_prices_initial_kcal(iso,kfo);

*** get share of a staple product within total staples and livestock products, and replace zero shares with reginoal avarages
* first set it to equal shares, just in case there is no population


i15_staples_kcal_structure_iso(t,iso,kst) =
                               sum(iso2, f15_kcal_pc_iso(t,iso2,kst)*im_pop_iso(t,iso2)) /
                               (
                                 sum((kst2,iso2),f15_kcal_pc_iso(t,iso2,kst2)*im_pop_iso(t,iso2))
                                 +10**(-5)
                               );
* 10**(-5) required to avoid unlogical division by zero error. Ask Jan P

i15_staples_kcal_structure_iso(t,iso,kst)$(sum(kst2,f15_kcal_pc_iso(t,iso,kst2))>0) =
                               f15_kcal_pc_iso(t,iso,kst)
                               /sum(kst2,f15_kcal_pc_iso(t,iso,kst2));


i15_livestock_kcal_structure_iso(t,iso,kap2) =
                                 sum(iso2, f15_kcal_pc_iso(t,iso2,kap2)*im_pop_iso(t,iso2))/
                                 (
                                   sum((kap3,iso2),(f15_kcal_pc_iso(t,iso2,kap3)*im_pop_iso(t,iso2)))
                                   +10**(-5)
                                 );

i15_livestock_kcal_structure_iso(t,iso,kap2)$sum(kap3,f15_kcal_pc_iso(t,iso,kap3)>0)=
                                 f15_kcal_pc_iso(t,iso,kap2) /
                                 sum(kap3,f15_kcal_pc_iso(t,iso,kap3));
* 10**(-5) required to avoid unlogical division by zero error.


p15_lastiteration_delta_income_pc_real_ppp(i)=1;
