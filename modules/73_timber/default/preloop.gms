*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Plausible cost for balance variable in case of s73_timber_demand_switch = 0 to avoid distortion of cost
s73_free_prod_cost$(s73_timber_demand_switch = 0) = s73_timber_prod_cost_wood;

** Set historical values to FAO values
p73_forestry_demand_prod_specific(t_past_forestry,iso,total_wood_products) = f73_prod_specific_timber(t_past_forestry,iso,total_wood_products);

** Loop over time to calculate future demand
** Calculations based on Lauri et al. 2019
loop(t_all$(m_year(t_all) > 2015 AND m_year(t_all) <= 2150),
   p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)$(im_gdp_pc_ppp_iso(t_all,iso)>0 AND im_pop_iso(t_all,iso)>0)
          = p73_forestry_demand_prod_specific(t_all-1,iso,total_wood_products)
          *
          (im_pop_iso(t_all,iso)/im_pop_iso(t_all-1,iso))
          *
          ((im_gdp_pc_ppp_iso(t_all,iso)/im_gdp_pc_ppp_iso(t_all-1,iso))**f73_income_elasticity(total_wood_products))
          ;
);

** Aggregate from ISO country level to MAgPIE region level
p73_timber_demand_gdp_pop(t_all,i,kforestry) = sum((i_to_iso(i,iso),kforestry_to_woodprod(kforestry,total_wood_products)),p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)) * s73_timber_demand_switch ;

** Hard additive calibration for timber demand
if(s73_timber_demand_switch=1,
  loop (t_all,
    if(m_year(t_all) <= 2015,
        p73_demand_calib(t_all,i,"wood") = f73_regional_timber_demand(t_all,i,"industrial_roundwood") - p73_timber_demand_gdp_pop(t_all,i,"wood");
        p73_timber_demand_gdp_pop(t_all,i,"wood") = p73_timber_demand_gdp_pop(t_all,i,"wood") + p73_demand_calib(t_all,i,"wood");
      );
  );

  loop (t_all$(m_year(t_all) > 2015),
    p73_timber_demand_gdp_pop(t_all,i,"wood")$(p73_timber_demand_gdp_pop(t_all,i,"wood") < p73_timber_demand_gdp_pop(t_all-1,i,"wood")) = p73_timber_demand_gdp_pop(t_all-1,i,"wood") * s73_increase_ceiling;
    p73_timber_demand_gdp_pop(t_all,i,"wood")$(p73_timber_demand_gdp_pop(t_all,i,"wood")/p73_timber_demand_gdp_pop(t_all-1,i,"wood") > s73_increase_ceiling) = p73_timber_demand_gdp_pop(t_all-1,i,"wood") * s73_increase_ceiling;
  );
);

** Alternative wood use scenarios
$ifthen "%c73_wood_scen%" == "construction"
p73_timber_demand_gdp_pop(t_all,i,"wood") = p73_timber_demand_gdp_pop(t_all,i,"wood") * f73_demand_modifier(t_all,"%c73_wood_scen%");
$endif

** Convert to tDM from mio m3
** p73_timber_demand_gdp_pop is in mio m^3
** pm_demand_forestry in mio ton DM
** Hold constraint beyond 2150 - First every time step gets 2150 values
**** Extend for Churkina et al 2020 demand scenarios
pm_demand_forestry(t_ext,i,kforestry) = round(p73_timber_demand_gdp_pop("y2150",i,kforestry) * f73_volumetric_conversion(kforestry),3);
** overwrite timesteps below 2150 with actual values
pm_demand_forestry(t_all,i,kforestry) = round(p73_timber_demand_gdp_pop(t_all,i,kforestry) * f73_volumetric_conversion(kforestry),3);

** Initialize fraction
p73_fraction(t_all)    = s73_expansion/(m_year("y2100") - sm_fix_SSP2);

** Populate the fraction for each time step
loop(t_all$(m_year(t_all) > 2015),
  p73_fraction(t_all)  = s73_expansion/(m_year("y2100") - sm_fix_SSP2) * m_yeardiff(t_all) + p73_fraction(t_all-1);
  );

** Remove equally the values from sm_fix_SSP2 (we want the construction wood demand to only start after sm_fix_SSP2)
loop(t_all$(m_year(t_all)=sm_fix_SSP2),
  p73_fraction_sm_fix = p73_fraction(t_all);
  );
p73_fraction(t_all) = p73_fraction(t_all) - p73_fraction_sm_fix;
** Set negative values to 0
p73_fraction(t_all)$(p73_fraction(t_all)<0) = 0;
** Set values after 2100 to values from 2100
p73_fraction(t_all)$(m_year(t_all)>2100) = p73_fraction("y2100");

** In case using demand from Churkina et al. 2020
if(s73_expansion = 0,
  p73_demand_constr_wood(t_all,i) = f73_construction_wood_demand(t_all,i,"%c09_pop_scenario%","%c73_build_demand%");
  p73_demand_constr_wood(t_all,i)$(m_year(t_all)<=sm_fix_SSP2) = f73_construction_wood_demand("y2025",i,"%c09_pop_scenario%","BAU");
  );

** In case using simple assumption for construction wood demand (based on industrial_roundwood demand)
if(s73_expansion > 0,
  p73_demand_constr_wood(t_all,i) = pm_demand_forestry(t_all,i,"wood") * p73_fraction(t_all);
  );

** Adjust industrial roundwood demand (construction wood demand is added on top)
pm_demand_forestry(t_all,i,"wood") = pm_demand_forestry(t_all,i,"wood") + p73_demand_constr_wood(t_all,i);
** Keep demand after 2100 constant
pm_demand_forestry(t_all,i,kforestry)$(m_year(t_all)>2100) = pm_demand_forestry("y2100",i,kforestry);
** Calculate global demand
p73_glo_wood(t_all,kforestry) = sum(i,pm_demand_forestry(t_all,i,kforestry));

im_timber_prod_cost("wood") = s73_timber_prod_cost_wood;
im_timber_prod_cost("woodfuel") = s73_timber_prod_cost_woodfuel;
