** Prohibiting harvesting and production of wood but not woodfuel from other land
v32_hvarea_other.fx(j,"wood",ac_sub)= 0;
v32_prod.fx(j,"other","wood") = 0;
*v32_hvarea_forestry.fx(j,kforestry,"ac0") = 0;

** Read exogenous rotation length
p32_rot_length(i) = f32_rot_length(i,"%c32_rot_length%");

** rotation length in 5 year time steps
p32_rotation_cellular(j) = sum(cell(i,j), ceil(p32_rot_length(i)/5));
display p32_rotation_cellular;

*' @code
*' Mapping between AC, type32 and Rotation length
*' Forests are moved to categories of type32 based the rotation lengths.
*ac_land32(j,ac,"aff") = yes$(ord(ac) > 1);
*ac_land32(j,ac,"indc") = yes$(ord(ac) > 1);

*' @stop
protect32(j,ac_sub) = no;
protect32(j,ac_sub) = yes$(ord(ac_sub) < p32_rotation_cellular(j));

harvest32(j,ac_sub) = no;
harvest32(j,ac_sub) = yes$(ord(ac_sub) >= p32_rotation_cellular(j));

*harvest32(j,ac_sub) = yes$(ord(ac_sub) >= sum(cell(i,j), ceil(p32_rot_length(i)/5)));


** Initialization of "Protected available plantations" and "availabe plantations which can be re-used".
p32_protect_avail(t,j) = 0;
v32_avail_reuse.l(j) = 0;

** Exoenously determine timber demand is fed into interface vm_prod_reg which is used to equate demand with supply.
vm_prod_reg.l(i,kforestry) = fm_forestry_demand("y1995",i,kforestry);

** Afforestation policies NPI and NDCs
p32_aff_pol(t,j) = f32_aff_pol(t,j,"%c32_aff_policy%");
p32_land(t,j,type32,ac) = 0;

** divide initial forestry area by number of age classes within protect32
** since protect32 is TRUE for ord(ac_sub) < p32_rotation_cellular(j) there is one additional junk which is assigned to ac0
p32_plant_ini_ac(j) = pm_land_start(j,"forestry")/p32_rotation_cellular(j);
*p32_plant_ini_ac(j) = pm_land_start(j,"forestry")/sum(cell(i,j), ceil(f32_rot_length(i,"init")/5));

p32_land("y1995",j,"plant",ac_sub)$(protect32(j,ac_sub)) = p32_plant_ini_ac(j);
p32_land("y1995",j,"plant","ac0") = p32_plant_ini_ac(j);

** initial shifting of age classes
p32_land(t,j,"plant",ac)$(ord(ac) > 1) = p32_land(t,j,"plant",ac-1);
** reset ac0 to zero
p32_land("y1995",j,"plant","ac0") = 0;

****** TRADE CALCULATIONS *******

** This should be done via interface from trade module

i32_trade_bal_reduction_annual(t_ext_forestry) = c32_reduction_%c21_trade_liberalization%;
i32_trade_bal_reduction_annual(tstart32) = c32_reduction_start;

i32_trade_bal_reduction("y1995") = 1;

loop (t_ext_forestry$(ord(t_ext_forestry)>1),
  i32_trade_bal_reduction(t_ext_forestry) = i32_trade_bal_reduction(t_ext_forestry-1)*(1-i32_trade_bal_reduction_annual(t_ext_forestry))**m_yeardiff(t_ext_forestry);
);

i32_trade_margin(i2,kforestry) = f32_trade_margin(i2,kforestry);
i32_trade_margin(i2,"wood") = i32_trade_margin(i2,"woodfuel");

if ((s21_trade_tariff=1),
    i32_trade_tariff(i2,kforestry) = f32_trade_tariff(i2,kforestry);
	i32_trade_tariff(i2,"wood") = i32_trade_tariff(i2,"woodfuel");
elseif (s21_trade_tariff=0),
    i32_trade_tariff(i2,kforestry) = 0;
);

** Extended time frame calculations. Holding constant after y2150.
p32_demand_ext(t_ext_forestry,i,kforestry) = fm_forestry_demand("y2150",i,kforestry);
p32_demand_ext(t_all,i,kforestry) = fm_forestry_demand(t_all,i,kforestry);

p32_selfsuff_ext(t_ext_forestry,i,kforestry) = fm_self_suff_forestry("y2150",i,kforestry);
p32_selfsuff_ext(t_all,i,kforestry) = fm_self_suff_forestry(t_all,i,kforestry);

p32_trade_balanceflow_ext(t_ext_forestry,kforestry) = fm_trade_balanceflow_forestry("y2150",kforestry);
p32_trade_balanceflow_ext(t_all,kforestry) = fm_trade_balanceflow_forestry(t_all,kforestry);

p32_exp_shr_ext(t_ext_forestry,i,kforestry) = fm_exp_shr_forestry("y2150",i,kforestry);
p32_exp_shr_ext(t_all,i,kforestry) = fm_exp_shr_forestry(t_all,i,kforestry);

p32_production_ratio_ext(i,t_ext_forestry) = f32_production_ratio(i,"y2150");
p32_production_ratio_ext(i,t_all) = f32_production_ratio(i,t_all);
********

p32_forestry_management(i) = f32_forestry_management(i);
p32_forestry_management("IND") = 10;
*p32_forestry_management("CHA") = 7;
p32_forestry_management("MEA") = 20;

f32_fac_req_ha(i2,"recur") = 100;
f32_fac_req_ha(i2,"mon") = 33;
f32_harvest_cost_ha(i2,"harv")  = 300;

**************************************************************************
$ontext
*** copied from 45
pm_climate_class(j,clcl) = f45_koeppengeiger(j,clcl);

*** copied from 52
*age-class carbon density start values
pc52_carbon_density_start(t,j,"vegc") = 0;
pc52_carbon_density_start(t,j,"litc") = fm_carbon_density(t,j,"past","litc");
pc52_carbon_density_start(t,j,"soilc") = fm_carbon_density(t,j,"past","soilc");

*calculate vegetation age-class carbon density in current time step with chapman richards equation
pm_carbon_density_ac(t,j,ac,"vegc") = m_growth_vegc(pc52_carbon_density_start(t,j,"vegc"),fm_carbon_density(t,j,"other","vegc"),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"k")),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"m")),(ord(ac)-1));

*calculate litter and soil carbon density based on linear growth funktion: carbon_density(ac) = intercept + slope*ac (20 year time horizon taken from IPCC)
pm_carbon_density_ac(t,j,ac,"litc") = m_growth_litc_soilc(pc52_carbon_density_start(t,j,"litc"),fm_carbon_density(t,j,"other","litc"),(ord(ac)-1));
pm_carbon_density_ac(t,j,ac,"soilc") = m_growth_litc_soilc(pc52_carbon_density_start(t,j,"soilc"),fm_carbon_density(t,j,"other","soilc"),(ord(ac)-1));
*************

p32_yield_forestry_ac("y1995",j,ac) =
    sum(cell(i,j),p32_forestry_management(i))
    * m_growing_stock(pm_carbon_density_ac("y1995",j,ac,"vegc"));

fixed_land(j,ac) = p32_land("y1995",j,"plant",ac);
fixed_yield(j,ac) = p32_yield_forestry_ac("y1995",j,ac);

fixed_demand(j) = sum(ac$harvest32(j,ac),fixed_land(j,ac) * fixed_yield(j,ac)) * 0.88;

p32_demand_ext(t_ext_forestry,i,"wood") = sum(cell(i,j),fixed_demand(j)/2);
p32_demand_ext(t_all,i,"wood") = sum(cell(i,j),fixed_demand(j)/2);
p32_demand_ext(t_ext_forestry,i,"woodfuel") = sum(cell(i,j),fixed_demand(j)/2);
p32_demand_ext(t_all,i,"woodfuel") = sum(cell(i,j),fixed_demand(j)/2);
$offtext
