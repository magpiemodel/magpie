*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



q15_food_demand(i2,kfo) ..
                (vm_dem_food(i2,kfo) + sum(ct,f15_household_balance_flow(ct,i2,kfo,"dm")))
                * sum(ct,f15_nutrition_attributes(ct,kfo,"kcal"))
                /365 * 10**6
                =e=
                sum(ct,i15_pop(ct,i2)) * v15_kcal_pc(i2,kfo)
                ;


q15_dummy .. 0 =n=0;