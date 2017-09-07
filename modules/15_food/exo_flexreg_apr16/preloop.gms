*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

i15_gdp_iso(t,iso) = f15_gdp_iso(t,iso,"%c15_gdp_scenario%");
i15_pop_iso(t,iso) = f15_pop_iso(t,iso,"%c15_pop_scenario%");
i15_gdp(t,i) = sum(i_to_iso(i,iso),i15_gdp_iso(t,iso));
i15_pop(t,i) = sum(i_to_iso(i,iso),i15_pop_iso(t,iso));

im_gdp_pc_mer(t,i) = i15_gdp_mer(t,i)/i15_pop(t,i);
im_development_state(t,i) = f15_development_state(t,i,"%c15_gdp_scenario%");

i15_gdp_pc_iso(t,iso)=0;
i15_gdp_pc_iso(t,iso)$(f15_gdp_iso(t,iso,"%c15_gdp_scenario%")*f15_pop_iso(t,iso,"%c15_pop_scenario%")>0)  = f15_gdp_iso(t,iso,"%c15_gdp_scenario%")/f15_pop_iso(t,iso,"%c15_pop_scenario%");
i15_gdp_pc_iso(t,iso)$(i15_gdp_pc_iso(t,iso)=0) = sum(i_to_iso(i,iso),im_gdp_pc_mer(t,i));
