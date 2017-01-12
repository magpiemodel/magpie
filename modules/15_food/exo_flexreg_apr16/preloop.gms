*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

i15_gdp(t,i) = sum(i_to_iso(i,iso),f15_gdp_iso(t,iso,"%c15_gdp_scenario%"));
i15_pop(t,i) = sum(i_to_iso(i,iso),f15_pop_iso(t,iso,"%c15_pop_scenario%"));

im_gdp_pc(t,i) = i15_gdp(t,i)/i15_pop(t,i);
im_development_state(t,i) = f15_development_state(t,i,"%c15_gdp_scenario%");
