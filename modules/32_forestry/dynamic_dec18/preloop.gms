*v32_hvarea_forestry.fx(j,kforestry,"ac0") = 0;

** Read exogenous rotation length
p32_rot_length(t,i) = f32_rot_length(t,i,"%c32_rot_length%");
p32_rot_length_estb(t,i) = f32_rot_length(t,i,"%c32_rot_length_estb%");

pm_rot_length(t,i) = p32_rot_length(t,i);
pm_rot_length_estb(t,i) = p32_rot_length_estb(t,i);

** rotation length in 5 year time steps
p32_rotation_cellular(t,j) = sum(cell(i,j), ceil(p32_rot_length(t,i)/5));
p32_rotation_cellular_estb(t,j) = sum(cell(i,j), ceil(p32_rot_length_estb(t,i)/5));

*' @code
*' Mapping between AC, type32 and Rotation length
*' Forests are moved to categories of type32 based the rotation lengths.
*ac_land32(j,ac,"aff") = yes$(ord(ac) > 1);
*ac_land32(j,ac,"indc") = yes$(ord(ac) > 1);

*' @stop
protect32(t,j,ac_sub) = no;
protect32(t,j,ac_sub) = yes$(ord(ac_sub) < p32_rotation_cellular(t,j));

harvest32(t,j,ac_sub) = no;
harvest32(t,j,ac_sub) = yes$(ord(ac_sub) >= p32_rotation_cellular(t,j));

** Initialization of "Protected available plantations" and "availabe plantations which can be re-used".
p32_protect_avail(t,j) = 0;
v32_avail_reuse.l(j) = 0;

** Exoenously determine timber demand is fed into interface vm_prod_reg which is used to equate demand with supply.
*vm_prod_reg.l(i,kforestry) = fm_forestry_demand("y1995",i,kforestry);

** Afforestation policies NPI and NDCs
p32_aff_pol(t,j) = f32_aff_pol(t,j,"%c32_aff_policy%");
p32_land(t,j,type32,ac) = 0;

** divide initial forestry area by number of age classes within protect32
** since protect32 is TRUE for ord(ac_sub) < p32_rotation_cellular(j) there is one additional junk which is assigned to ac0
p32_plant_ini_ac(j) = pm_land_start(j,"forestry")/p32_rotation_cellular("y1995",j);
*p32_plant_ini_ac(j) = pm_land_start(j,"forestry")/sum(cell(i,j), ceil(f32_rot_length(i,"init")/5));

p32_land("y1995",j,"plant",ac_sub)$(protect32("y1995",j,ac_sub)) = p32_plant_ini_ac(j);
p32_land("y1995",j,"plant","ac0") = p32_plant_ini_ac(j);

** initial shifting of age classes
p32_land(t,j,"plant",ac)$(ord(ac) > 1) = p32_land(t,j,"plant",ac-1);
** reset ac0 to zero
p32_land("y1995",j,"plant","ac0") = 0;

**************************************************************************************
pm_production_ratio_ext(i,t_ext) = fm_production_ratio(i,"y2100");
pm_production_ratio_ext(i,t_all) = fm_production_ratio(i,t_all);

p32_forestry_management(i) = f32_forestry_management(i);
p32_forestry_management("IND") = 10;
p32_forestry_management("USA") = 7;
*p32_forestry_management("CAZ") = 7;
*p32_forestry_management("LAM") = 4;
*p32_forestry_management("OAS") = 6;
*p32_forestry_management("REF") = 2;
*p32_forestry_management("SSA") = 2;
*p32_forestry_management("CHA") = 7;
*p32_forestry_management("MEA") = 200;

f32_fac_req_ha(i2,"recur") = 100;
f32_fac_req_ha(i2,"mon") = 33;
fm_harvest_cost_ha(i2)  = 2000;

**************************************************************************
