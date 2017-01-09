*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

im_gdp_pc(t,i) = f15_gdp(t,i,"%c15_gdp_scenario%")/f15_pop(t,i,"%c15_pop_scenario%");
im_development_state(t,i) = f15_development_state(t,i,"%c15_gdp_scenario%");
i15_pop(t,i) = f15_pop(t,i,"%c15_pop_scenario%");
