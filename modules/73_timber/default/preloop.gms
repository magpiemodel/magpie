*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Set historical values to FAO values
p73_forestry_demand_prod_specific(t_past_forestry,iso,total_wood_products) = f73_prod_specific_timber(t_past_forestry,iso,total_wood_products);

** Loop over time to calculate future demand
** Calculations based on Lauri et al. 2019
loop(t_all$(m_year(t_all) >= sm_fix_SSP2 AND m_year(t_all) <= 2150),
   p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)$(im_gdp_pc_ppp_iso(t_all,iso)>0 AND im_pop_iso(t_all,iso)>0)
          = p73_forestry_demand_prod_specific(t_all-1,iso,total_wood_products)
          *
          (im_pop_iso(t_all,iso)/im_pop_iso(t_all-1,iso))
          *
          ((im_gdp_pc_ppp_iso(t_all,iso)/im_gdp_pc_ppp_iso(t_all-1,iso))**f73_income_elasticity(total_wood_products))
          ;
);

p73_urban_pop(t_all,i,build_scen) = sum(i_to_iso(i,iso), im_pop_iso(t_all,iso)) * p73_urban_share(t_all,i);

p73_building_timber(t_all,iso,build_scen)
        =
** Mio Cap
        (im_pop_iso(t_all,iso) - im_pop_iso(t_all-1,iso))
** Req per cap tKg/cap ((kg/cap) / 1e3)
        * 7440 / 1000
** Scenario
        * p73_dem_scen(build_scen)
** We don't [* 2] afterwards wher Galina assumes that 50% of roundwood is wasted during processing


** Aggregate from ISO country level to MAgPIE region level
p73_timber_demand_gdp_pop(t_all,i,kforestry) = sum((i_to_iso(i,iso),kforestry_to_woodprod(kforestry,total_wood_products)),p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)) * s73_timber_demand_switch ;

** Hard additive calibration for timber demand
if(s73_timber_demand_switch=1,
  loop (t_all,
    if(m_year(t_all) < sm_fix_SSP2,
        p73_demand_calib(t_all,i,"wood") = f73_regional_timber_demand(t_all,i,"industrial_roundwood") - p73_timber_demand_gdp_pop(t_all,i,"wood");
        p73_timber_demand_gdp_pop(t_all,i,"wood") = p73_timber_demand_gdp_pop(t_all,i,"wood") + p73_demand_calib(t_all,i,"wood");
      );
  );

  loop (t_all$(m_year(t_all)>=sm_fix_SSP2),
    p73_timber_demand_gdp_pop(t_all,i,"wood")$(p73_timber_demand_gdp_pop(t_all,i,"wood")<p73_timber_demand_gdp_pop(t_all-1,i,"wood")) = p73_timber_demand_gdp_pop(t_all-1,i,"wood") * s73_increase_ceiling;
    p73_timber_demand_gdp_pop(t_all,i,"wood")$(p73_timber_demand_gdp_pop(t_all,i,"wood")/sum(i_to_iso(i,iso),p73_forestry_demand_prod_specific(t_all-1,iso,"industrial_roundwood")) > s73_increase_ceiling) = p73_timber_demand_gdp_pop(t_all-1,i,"wood") * s73_increase_ceiling;
  );
);
display p73_timber_demand_gdp_pop;
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
