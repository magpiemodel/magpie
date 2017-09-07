*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

equations
q15_food_demand(i,kfo) Food demand
q15_dummy                        empty constraint that is necessary because empty models cannot be declared
;

parameters
i15_gdp_iso(t,iso)      income in mio US Dollar 05 MER before a price shock
i15_pop_iso(t,iso)      population in mio capita 
i15_pop_iso(t,iso)      population in mio capita
i15_gdp(t,i)      income in mio US Dollar 05 MER before a price shock
i15_pop(t,i)      population in mio capita
im_development_state(t,i)  development state (share in high income level)
im_gdp_pc_mer(t,i)              GDP per capita (USD)
i15_kcal_pc_initial(t,i,kall) Food demand without price shock (kcal per capita per day)
i15_gdp_pc_iso(t,iso)       income per capita in US Dollar 05 MER per capita before a price shock
;

positive variables
vm_dem_food(i,kall)       Demand for food (Mt DM)
v15_kcal_pc(i,kall)        Per capita calories (kcal per capita per day)
;

model m15_food_demand / q15_dummy /;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_food(t,i,kall,type)     Demand for food (Mt DM)
 ov15_kcal_pc(t,i,kall,type)    Per capita calories (kcal per capita per day)
 oq15_food_demand(t,i,kfo,type) Food demand
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
