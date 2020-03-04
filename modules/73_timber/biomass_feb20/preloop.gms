*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Fixing variables
*vm_prod_heaven_timber.fx(j,kforestry) = 0;
v73_prod_natveg.fx(j,"other",ac_sub,"wood") = 0;
v73_prod_natveg.fx(j,"primforest",ac_sub,kforestry)$(not sameas(ac_sub,"acx")) = 0;
vm_hvarea_other.fx(j,ac_sub,"wood") = 0;


****************** IIASA demand ******************
*' Taken from Supply and demand functions for global wood markets: Specification and
*' plausibility testing of econometric models within the global forest sector.
*' https://doi.org/10.1016/j.forpol.2018.04.003
*' Fiberboard value used for wood, Fuelwood value used for wood fuel (Table 5).
p73_income_elasticity(total_wood_products) = 0.1;
*' Overwrite known values
p73_income_elasticity("wood_fuel") = -0.57;
p73_income_elasticity("wood_pulp") = 0.36;
p73_income_elasticity("particle_board_and_osb") = 0.75;
p73_income_elasticity("fibreboard") = 1.06;
p73_income_elasticity("plywood") = 0.94;
p73_income_elasticity("veneer_sheets") = 0.60;
p73_income_elasticity("sawnwood") = 0.19;
p73_income_elasticity("other_industrial_roundwood") = 0.22;
** veneer_sheets and other_industrial_roundwood from buongiorno paper
p73_income_elasticity("other_sawnwood") = p73_income_elasticity("sawnwood");

** Set historical values to FAO values
p73_forestry_demand_prod_specific(t_past,iso,total_wood_products) = f73_prod_specific_timber(t_past,iso,total_wood_products);

** Loop over time to calculate future demand

loop(t_all$(m_year(t_all) >= 2010 AND m_year(t_all) < 2150),
   p73_forestry_demand_prod_specific(t_all+1,iso,total_wood_products)
          = p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)
          *
          (im_pop_iso(t_all+1,iso)/im_pop_iso(t_all,iso))$(im_pop_iso(t_all,iso)>0)
          *
          ((im_gdp_pc_ppp_iso(t_all+1,iso)/im_gdp_pc_ppp_iso(t_all,iso))**p73_income_elasticity(total_wood_products))$(im_gdp_pc_ppp_iso(t_all,iso)>0)
          ;
);
p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)$(im_gdp_pc_ppp_iso(t_all,iso)=0) = 0;

p73_timber_demand_gdp_pop(t_all,i,kforestry) = sum((i_to_iso(i,iso),kforestry_to_woodprod(kforestry,total_wood_products)),p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)) * s73_timber_demand;
p73_glo_timber_demand(t_all,kforestry) = sum(i,p73_timber_demand_gdp_pop(t_all,i,kforestry));
display p73_glo_timber_demand;

** Woodfuel fix
p73_timber_demand_gdp_pop(t_all,i,"woodfuel") = (p73_timber_demand_gdp_pop(t_all,i,"woodfuel") * 0.50)$(im_development_state(t_all,i)<1)
      + (p73_timber_demand_gdp_pop(t_all,i,"woodfuel"))$(im_development_state(t_all,i)=1);

pm_demand_ext(t_ext,i,kforestry) = p73_timber_demand_gdp_pop("y2150",i,kforestry);
pm_demand_ext(t_all,i,kforestry) = p73_timber_demand_gdp_pop(t_all,i,kforestry);
pm_demand_ext(t_all,"JPN",kforestry) =0;
pm_demand_ext(t_all,"MEA",kforestry) = p73_timber_demand_gdp_pop(t_all,"MEA",kforestry) * 0.5;
***** Calculate model estimate per capita
*p73_wood_products_demand_pc(t,iso,wood_panels) =1.044e-05*(im_gdp_pc_ppp_iso(t,iso)**0.9063);
*
*p73_wood_products_demand_pc(t,iso,"wood_pulp") = 9.984e-07*(im_gdp_pc_ppp_iso(t,iso)**1.218);
*
*p73_wood_products_demand_pc(t,iso,"sawnwood") = 7.204e-05*(im_gdp_pc_ppp_iso(t,iso)**0.8023);
*
*p73_wood_products_demand_pc(t,iso,"wood_fuel") = sum(wood_panels,p73_wood_products_demand_pc(t,iso,wood_panels) * 0.3);
*
*loop(t,
*  if (sum(sameas(t_past,t),1) = 1,
*
*      p73_calibration_timber_demand_pc(t,iso,wood_products)
*      =
*      f73_observed_timber_demand_pc(t,iso,wood_products)
*      -
*      p73_wood_products_demand_pc(t, iso, wood_products);
*
*      p73_calib_lastyr_pc(iso,wood_products)
*      =
*      p73_calibration_timber_demand_pc(t,iso,wood_products);
*
*  else
*
*      p73_calibration_timber_demand_pc(t,iso,wood_products)
*      =
*      p73_calib_lastyr_pc(iso,wood_products);
*
*  );
*);
*
*** Calibrated_pc is the value we get based on calibration value we create and add on top of model estimate
*p73_calibrated_pc(t,iso,wood_products)
*=
*p73_wood_products_demand_pc(t, iso, wood_products)
*+
*p73_calibration_timber_demand_pc(t,iso,wood_products);
*
*** Total demand is calculated based on pc demand multiplied by population
*p73_calibrated_abs(t,iso,wood_products)
*= p73_calibrated_pc(t,iso,wood_products) * im_pop_iso(t,iso);
*
*p73_calibrated_abs_glo(t)
*= sum((iso,total_wood_products),p73_calibrated_abs(t,iso,total_wood_products));
*
*p73_wood_products_demand_reg(t,i,kforestry)
*= sum((i_to_iso(i,iso),kforestry_to_woodprod(kforestry,total_wood_products)), p73_wood_products_demand_pc(t,iso,total_wood_products)*im_pop_iso(t,iso));
*
*p73_wood_products_demand_GLO(t,kforestry) = sum(i,p73_wood_products_demand_reg(t,i,kforestry));

*display p73_calibrated_abs_glo,p73_wood_products_demand_GLO,p73_wood_products_demand_reg;
