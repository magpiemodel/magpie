*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

i15_intake_standardized_pc_iso(t,iso) = f15_intake_standardized_pc_iso(t,iso,"%c09_pop_scenario%");



* initial prices in $US per Kcal
i15_prices_initial_kcal(iso,kfo)$(f15_nutrition_attributes("y1995",kfo,"kcal")>0) = f15_prices_initial(kfo)
                                                                                  / (f15_nutrition_attributes("y1995",kfo,"kcal")*10**6);
p15_prices_kcal(t,iso,kfo)=i15_prices_initial_kcal(iso,kfo);

p15_lastiteration_delta_income_pc_real_ppp(i)=1;

$ifthen "%c15_rumscen%" == "mixed" i15_ruminant_fadeout(t) = (f15_ruminant_fadeout(t,"constant") + f15_ruminant_fadeout(t,"halving2050"))/2;
$else i15_ruminant_fadeout(t) = f15_ruminant_fadeout(t,"%c15_rumscen%");
$endif
