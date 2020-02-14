*** Fixing some vars

vm_prod_heaven_timber.fx(j,kforestry) = 0;
v73_prod_natveg.fx(j,"other",ac_sub,"wood") = 0;
vm_other_change.fx(j,"wood",ac_sub) = 0;

***** Calculate model estimate per capita
loop(t,

p73_wood_products_demand_pc(t,iso,wood_panels) = 8.978e-06*im_gdp_pc_ppp_iso(t,iso)**0.9244;

p73_wood_products_demand_pc(t,iso,"wood_pulp") = 9.984e-07*im_gdp_pc_ppp_iso(t,iso)**1.218;

p73_wood_products_demand_pc(t,iso,"sawnwood") = 7.204e-05*im_gdp_pc_ppp_iso(t,iso)**0.8023;

  if (sum(sameas(t_past,t),1) = 1,

      p73_calibration_timber_demand_pc(t,iso,wood_products) = f73_observed_timber_demand_pc(t,iso,wood_products) - p73_wood_products_demand_pc(t, iso, wood_products);
      p73_calib_lastyr_pc(iso,wood_products) = p73_calibration_timber_demand_pc(t,iso,wood_products);

  else

      p73_calibration_timber_demand_pc(t,iso,wood_products) = p73_calib_lastyr_pc(iso,wood_products);

  );
);

*calibrated_pc is the value we get based on calibration value we create and add on top of model estimate
p73_calibrated_pc(t,iso,wood_products) = p73_wood_products_demand_pc(t, iso, wood_products) + p73_calibration_timber_demand_pc(t,iso,wood_products);

* Total demand is calculated based on pc demand multiplied by population
p73_calibrated_abs(t,iso,wood_products) = p73_calibrated_pc(t,iso,wood_products) * im_pop_iso(t,iso);
p73_calibrated_abs_glo(t) = sum((iso,wood_products),p73_calibrated_abs(t,iso,wood_products));
display p73_calibrated_abs_glo;
