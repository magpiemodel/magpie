*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Set historical values to FAO values
p73_forestry_demand_prod_specific(t_past_forestry,iso,total_wood_products) = f73_prod_specific_timber(t_past_forestry,iso,total_wood_products);

** Harvesting Costs
** Set multiplier values for cost of harvesting
p73_timber_harvest_cost(t,j,ac,"forestry")    = s73_timber_harvest_cost;
** Natural vegetation are made more expensive to harvest due to need for
** specialized machinery and labor and difficulty in reaching inaccessible areas
p73_timber_harvest_cost(t,j,ac,"secdforest")  = s73_timber_harvest_cost * s73_cost_multiplier;
p73_timber_harvest_cost(t,j,ac,"other")       = s73_timber_harvest_cost / 2;
p73_timber_harvest_cost(t,j,ac,"primforest")  = s73_timber_harvest_cost * s73_cost_multiplier * s73_cost_multiplier;

** Loop over time to calculate future demand
** Calculations based on Lauri et al. 2019
loop(t_all$(m_year(t_all) >= 2015 AND m_year(t_all) < 2150),
   p73_forestry_demand_prod_specific(t_all+1,iso,total_wood_products)
          = p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)
          *
          (im_pop_iso(t_all+1,iso)/im_pop_iso(t_all,iso))$(im_pop_iso(t_all,iso)>0)
          *
          ((im_gdp_pc_ppp_iso(t_all+1,iso)/im_gdp_pc_ppp_iso(t_all,iso))**f73_income_elasticity(total_wood_products))$(im_gdp_pc_ppp_iso(t_all,iso)>0)
          ;
);
* Fill in very small values
p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)$(im_gdp_pc_ppp_iso(t_all,iso)=0) = 0.000001;
p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)$(p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)=0) = 0.00000001;

** Aggregate from ISO country level to MAgPIE region level
p73_timber_demand_gdp_pop(t_all,i,kforestry) = sum((i_to_iso(i,iso),kforestry_to_woodprod(kforestry,total_wood_products)),p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)) * sm_timber_demand_switch;

** Hard additive calibration for timber demand
loop (t_past_forestry,
  p73_demand_calib(t_past_forestry,i,"wood") = p73_timber_demand_gdp_pop(t_past_forestry,i,"wood") - sum(i_to_iso(i,iso),p73_forestry_demand_prod_specific(t_past_forestry,iso,"industrial_roundwood"));
  p73_timber_demand_gdp_pop(t_past_forestry,i,"wood")$(p73_demand_calib(t_past_forestry,i,"wood")>0) = p73_timber_demand_gdp_pop(t_past_forestry,i,"wood") - p73_demand_calib(t_past_forestry,i,"wood");
);
loop (t_all$(m_year(t_all)>=2020),
  p73_timber_demand_gdp_pop(t_all,i,"wood")$(p73_timber_demand_gdp_pop(t_all,i,"wood")/sum(i_to_iso(i,iso),p73_forestry_demand_prod_specific(t_all-1,iso,"industrial_roundwood")) > s73_increase_ceiling) = p73_timber_demand_gdp_pop(t_all-1,i,"wood") * s73_increase_ceiling;
);

** Alternative wood use scenarios
$ifthen "%c73_wood_scen%" == "construction"
p73_timber_demand_gdp_pop(t_all,i,"wood") = p73_timber_demand_gdp_pop(t_all,i,"wood") * f73_demand_modifier(t_all,"%c73_wood_scen%");
$endif

** Convert to tDM from mio m3
** p73_timber_demand_gdp_pop is in mio m^3
** pm_demand_ext in mio ton DM
** Hold constraint beyond 2150 - First every time step gets 2150 values
pm_demand_ext(t_ext,i,kforestry) = round(p73_timber_demand_gdp_pop("y2150",i,kforestry) * f73_volumetric_conversion(kforestry),3);
** overwrite timesteps below 2150 with actual values
pm_demand_ext(t_all,i,kforestry) = round(p73_timber_demand_gdp_pop(t_all,i,kforestry) * f73_volumetric_conversion(kforestry),3);
