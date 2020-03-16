** This is same calculation as in carbon module. As these numbers don't exist yet due to
** carbon module appearing below forestry module, we keep this double calculation for now.
p32_carbon_density_ac_forestry(t_all,j,ac) = m_growth_vegc(0,fm_carbon_density(t_all,j,"other","vegc"),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"k","plantations")),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"m","plantations")),(ord(ac)-1));

** Calculating the marginal of carbon density i.e. change in carbon density over two time steps
** The carbon densities are tC/ha/year so we don't have to divide by timestep length.
p32_carbon_density_ac_marg(t_all,j,ac_sub) = p32_carbon_density_ac_forestry(t_all,j,ac_sub) - p32_carbon_density_ac_forestry(t_all,j,ac_sub-1);

** Calculating Instantaneous Growth Rates (IGR). This is a proxy number which can be compared against
** interest rate in the economy to make investment decisions in plantations (i.e. to keep it growing or to harvest it).
** This parameter is then used to calculate rotation lengths.
p32_IGR(t_all,j,ac_sub) = (p32_carbon_density_ac_marg(t_all,j,ac_sub)/p32_carbon_density_ac_forestry(t_all,j,ac_sub))$(p32_carbon_density_ac_forestry(t_all,j,ac_sub)>0) + 1$(p32_carbon_density_ac_forestry(t_all,j,ac_sub)<0.0001);

** IGR values for first age class ("ac0") is provided the same value as "ac5" to
** avoid a sudden drop in rotation lengths in y2000 from y1995.
p32_IGR(t_all,j,"ac0") = p32_IGR(t_all,j,"ac5");

** For each cluster in MAgPIE ("j") we calculate how long the prevailing interest rates stay lower than the IGR.
** As long as the prevailing interest rates are lower than IGR, plantations shall be kept standing.
** As long as the prevailing interest rate becomes higher than IGR, it is assumed that the forest owner would rather
** keep his/her investment in bank rather than in keeping the forest standing.
** The easiest way to do this calculation is to count a value of 1 for IGR>interest rate and a value of 0 for IGR<interest rate.
p32_rot_flg(t_all,j,ac) = 1$((p32_IGR(t_all,j,ac) - sum(cell(i,j),pm_interest_dev(t_all,i)))>0)
                        + 0$((p32_IGR(t_all,j,ac) - sum(cell(i,j),pm_interest_dev(t_all,i)))<=0);

** From the above calculation, now its easier to count how many age-classes can be sustained before IGR falls below interest rate.
** Then we just multiply the valid age-classes by 5 (because MAgPIE age classes are in 5 year steps) to get the absolute rotation length (in years)
p32_rot_length_ac_eqivalent(t_all,j) = sum(ac,p32_rot_flg(t_all,j,ac));

** We provide a upper limit of 90 years for commercial plantations.
** 90 years translates to age-class 18 (90/5)
p32_rot_length_ac_eqivalent(t_all,j)$(p32_rot_length_ac_eqivalent(t_all,j)>18) = 18;

** Holding rotation lengths constant after the end of this century.
p32_rot_length_ac_eqivalent(t_future,j) = p32_rot_length_ac_eqivalent("y2100",j);

p32_rotation_regional(t,i) = ord(t) + smax(cell(i,j), p32_rot_length_ac_eqivalent(t,j)) + card(t_past_ff);;
display p32_rotation_regional;

** Earlier we converted rotation lengths to absolute numbers, now we make the Conversion
** back to rotation length in age-classes.
p32_rotation_cellular(t_all,j) = ceil(p32_rot_length_ac_eqivalent(t_all,j));
p32_rotation_cellular_estb(t_all,j) = ceil(p32_rot_length_ac_eqivalent(t_all,j));

* Shift rotations. E.g. rotations harveted in 2050 should be harvested with the rotations using which they were establsihed.
* For 2050 plantation establsihed in 2020 with 30y rotaions shall be harvested according to 30 yr (for example)

** Update harvesting rotations
p32_rotation_cellular_harvesting(t_all,j) = p32_rotation_cellular_estb(t_all,j);

** RL Extension
p32_rotation_cellular_estb(t_all,j) = p32_rotation_cellular_estb(t_all,j) + c32_rotation_extension ;

loop(t_all,
  loop(j,
      p32_rotation_offset = p32_rotation_cellular_estb(t_all,j);
      if(ord(t_all)>p32_rotation_offset,
        p32_rotation_cellular_harvesting(t_all,j) = p32_rotation_cellular_estb(t_all-p32_rotation_offset,j);
        );
    );
);

** Rotation used for establishment decision - Same as harvesting rotation for now.
** This is declared as interface because this is also need in trade module.
p32_rot_length_ac_eqivalent(t_all,j) = p32_rotation_cellular_estb(t_all,j);

** Define protect and harvest setting
protect32(t,j,ac_sub) = no;
*protect32(t,j,ac_sub) = yes$(ord(ac_sub) < p32_rotation_cellular(t,j));
protect32(t,j,ac_sub) = yes$(ord(ac_sub) < p32_rotation_cellular_harvesting(t,j));

harvest32(t,j,ac_sub) = no;
*harvest32(t,j,ac_sub) = yes$(ord(ac_sub) >= p32_rotation_cellular(t,j));
harvest32(t,j,ac_sub) = yes$(ord(ac_sub) >= p32_rotation_cellular_harvesting(t,j));

display p32_rotation_cellular_estb,p32_rotation_cellular_harvesting;

** Afforestation policies NPI and NDCs
p32_aff_pol(t,j) = f32_aff_pol(t,j,"%c32_aff_policy%");
p32_land(t,j,type32,ac) = 0;

* Calculate the remaining exogenous afforestation with respect to the maximum exogenous target over time.
* `p32_aff_togo` is used to adjust `s32_max_aff_area` in the constraint `q32_max_aff`.
p32_aff_togo(t) = sum(j, smax(t2, p32_aff_pol(t2,j)) - p32_aff_pol(t,j));

* Adjust the afforestation limit `s32_max_aff_area` upwards, if it is below the exogenous policy target.
p32_max_aff_area = max(s32_max_aff_area, sum(j, smax(t2, p32_aff_pol(t2,j))) );

p32_cdr_ac(t,j,ac) = 0;

** divide initial forestry area by number of age classes within protect32
** since protect32 is TRUE for ord(ac_sub) < p32_rotation_cellular(j) there is
** one additional junk which is assigned to ac0
p32_plant_ini_ac(j) = pm_land_start(j,"forestry")/p32_rotation_cellular("y1995",j);

p32_land("y1995",j,"plant",ac_sub)$(protect32("y1995",j,ac_sub)) = p32_plant_ini_ac(j);
p32_land("y1995",j,"plant","ac0") = p32_plant_ini_ac(j);

*initial assumption for harvested area
pc32_hvarea_forestry(j) = p32_plant_ini_ac(j);
vm_hvarea_forestry.l(j,ac_sub) = p32_plant_ini_ac(j)/card(ac_sub);

p32_land_start(j,type32,ac) = p32_land("y1995",j,type32,ac);
display p32_land_start;

** Initial shifting of age classes
p32_land(t,j,"plant",ac)$(ord(ac) > 1) = p32_land(t,j,"plant",ac-1);
** Reset ac0 to zero
p32_land("y1995",j,"plant","ac0") = 0;

** Proportion of production coming from plantations
p32_production_ratio_ext(t_ext,i) = f32_production_ratio("y2100",i);
p32_production_ratio_ext(t_all,i) = f32_production_ratio(t_all,i);

p32_plant_prod_share(t_ext,i) = f32_plant_prod_share("y2100");
p32_plant_prod_share(t_all,i) = f32_plant_prod_share(t_all);

** Forest management options. Probably deprecated.
f32_forestry_management("USA","plantations") = 7;
p32_management_factor(j,mgmt_type) = sum(cell(i,j),ceil(f32_forestry_management(i,"plantations")/f32_forestry_management(i,"natveg")));
p32_management_factor(j,"high") = p32_management_factor(j,"normal") * 3;
**************************************************************************
