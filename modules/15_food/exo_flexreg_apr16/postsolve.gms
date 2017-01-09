*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_food(t,i,kall,"marginal")     = vm_dem_food.m(i,kall);
 ov15_kcal_pc(t,i,kall,"marginal")    = v15_kcal_pc.m(i,kall);
 oq15_food_demand(t,i,kfo,"marginal") = q15_food_demand.m(i,kfo);
 ov_dem_food(t,i,kall,"level")        = vm_dem_food.l(i,kall);
 ov15_kcal_pc(t,i,kall,"level")       = v15_kcal_pc.l(i,kall);
 oq15_food_demand(t,i,kfo,"level")    = q15_food_demand.l(i,kfo);
 ov_dem_food(t,i,kall,"upper")        = vm_dem_food.up(i,kall);
 ov15_kcal_pc(t,i,kall,"upper")       = v15_kcal_pc.up(i,kall);
 oq15_food_demand(t,i,kfo,"upper")    = q15_food_demand.up(i,kfo);
 ov_dem_food(t,i,kall,"lower")        = vm_dem_food.lo(i,kall);
 ov15_kcal_pc(t,i,kall,"lower")       = v15_kcal_pc.lo(i,kall);
 oq15_food_demand(t,i,kfo,"lower")    = q15_food_demand.lo(i,kfo);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
