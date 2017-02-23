*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

v15_kcal_pc.fx(i,kall)=0;

v15_kcal_pc.fx(i,kap)
=
f15_kcal_pc(t,i,"%c15_food_scenario%")*
f15_livestock_share(t,i,"%c15_food_scenario%")*
f15_livestock_kcal_structure(t,i,kap);

*** ACHTUNG: preliminary bugfix due to couple products (brans production from cereals)
*v15_kcal_pc.up(i,kst)=Inf;

v15_kcal_pc.fx(i,kst)
=
f15_kcal_pc(t,i,"%c15_food_scenario%")*
(1-f15_livestock_share(t,i,"%c15_food_scenario%")-f15_vegfruit_share(t,i,"%c15_food_scenario%"))*
f15_staples_kcal_structure(t,i,kst);

v15_kcal_pc.fx(i,"others")
=
f15_kcal_pc(t,i,"%c15_food_scenario%")*
f15_vegfruit_share(t,i,"%c15_food_scenario%");