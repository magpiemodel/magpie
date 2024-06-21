*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*m_sigmoid_time_interpol(i32_plant_contr_fader,2020,2050,0.05,0);
m_sigmoid_time_interpol(i32_plant_contr_growth_fader,s32_plant_contr_growth_startyear,s32_plant_contr_growth_endyear,s32_plant_contr_growth_startvalue,s32_plant_contr_growth_endvalue);

p32_est_cost("plant") = s32_est_cost_plant;
p32_est_cost("ndc") = s32_est_cost_natveg;
p32_est_cost("aff") = s32_est_cost_natveg$(s32_aff_plantation = 0) + s32_est_cost_plant$(s32_aff_plantation = 1);

** Calculation of Single rotation model rotation lengths
** Using forestry carbon densitiy here via carbon density data exchange from carbon module.
p32_carbon_density_ac_forestry(t_all,j,ac) = pm_carbon_density_plantation_ac(t_all,j,ac,"vegc");

** Calculating the marginal of carbon density i.e. change in carbon density over two time steps
** The carbon densities are tC/ha/year so we don't have to divide by timestep length.
loop(ac$(ord(ac) > 1),
  p32_carbon_density_ac_marg(t_all,j,ac) = (p32_carbon_density_ac_forestry(t_all,j,ac) - p32_carbon_density_ac_forestry(t_all,j,ac-1))/5;
  );
p32_carbon_density_ac_marg(t_all,j,"ac0") = 0;

** Calculating Instantaneous Growth Rates (IGR).
** This is a proxy number which can be compared against interest rate in the economy to
** make investment decisions in plantations (i.e. to keep it growing or to harvest it).
** This parameter is then used to calculate rotation lengths.
p32_IGR(t_all,j,ac) =   (p32_carbon_density_ac_marg(t_all,j,ac)/p32_carbon_density_ac_forestry(t_all,j,ac))$(p32_carbon_density_ac_forestry(t_all,j,ac)>0)
                      + 1$(p32_carbon_density_ac_forestry(t_all,j,ac)=0);

** For each cluster in MAgPIE ("j") we calculate how long the prevailing interest rates stay lower than the IGR.
** As long as the prevailing interest rates are lower than IGR, plantations shall be kept standing.
** As long as the prevailing interest rate becomes higher than IGR, it is assumed that the forest owner would rather
** keep his/her investment in bank rather than in keeping the forest standing.
** The easiest way to do this calculation is to count a value of 1 for IGR>interest rate and a value of 0 for IGR<interest rate.
$ifthen "%c32_interest_rate%" == "regional"
  p32_rot_flg(t_all,j,ac) = 1$(p32_IGR(t_all,j,ac) - sum(cell(i,j),pm_interest("y1995",i)) >  0)
                          + 0$(p32_IGR(t_all,j,ac) - sum(cell(i,j),pm_interest("y1995",i)) <= 0);
  display "Rotation lengths are calculated based on equating instantaneous growth rate to regional interest rate.";
$elseif "%c32_interest_rate%" == "global"
  p32_rot_flg(t_all,j,ac) = 1$(p32_IGR(t_all,j,ac) - s32_forestry_int_rate  >  0)
                          + 0$(p32_IGR(t_all,j,ac) - s32_forestry_int_rate <= 0);
  display "Rotation lengths are calculated based on equating instantaneous growth rate to global interest rate.";
$endif

$ifthen "%c32_rot_calc_type%" == "current_annual_increment"
  p32_rot_flg(t_all,j,ac) = 1$(p32_carbon_density_ac_marg(t_all,j,ac) - p32_carbon_density_ac_marg(t_all,j,ac-1) >  0)
                          + 0$(p32_carbon_density_ac_marg(t_all,j,ac) - p32_carbon_density_ac_marg(t_all,j,ac-1) <= 0);
  display "Rotation lengths are calculated based on maximizing current annual increment in this run.";
$endif

$ifthen "%c32_rot_calc_type%" == "mean_annual_increment"
  p32_avg_increment(t_all,j,ac) = pm_carbon_density_plantation_ac(t_all,j,ac,"vegc") / ((ord(ac)+1)*5);
  p32_rot_flg(t_all,j,ac) = 1$(p32_carbon_density_ac_marg(t_all,j,ac) - p32_avg_increment(t_all,j,ac) >  0)
                          + 0$(p32_carbon_density_ac_marg(t_all,j,ac) - p32_avg_increment(t_all,j,ac) <= 0);
  display "Rotation lengths are calculated based on maximizing mean annual increment in this run.";
$endif

** From the above calculation, now it is easier to count how many age-classes can be sustained before IGR falls below interest rate.

*********************************************************************************

** Faustmann rotation lengths:

p32_time(ac) = ord(ac);

p32_discount_factor(t_all,j,ac)         =  1/(exp(sum(cell(i,j),pm_interest(t_all,i))*p32_time(ac)));

p32_net_present_value(t_all,j,ac)       = ((s32_price * p32_carbon_density_ac_forestry(t_all,j,ac) * p32_discount_factor(t_all,j,ac)))/(1-p32_discount_factor(t_all,j,ac));

p32_stand_value(t_all,j,ac)             = s32_price * p32_carbon_density_ac_forestry(t_all,j,ac);
p32_stand_value(t_all,j,ac)$(p32_stand_value(t_all,j,ac)<0.01) = 0.01;

p32_investment_returns_lost(t_all,j,ac) = sum(cell(i,j),pm_interest(t_all,i)) * p32_net_present_value(t_all,j,ac);
p32_land_rent_weighted(t_all,j,ac)      = p32_investment_returns_lost(t_all,j,ac)/p32_stand_value(t_all,j,ac) ;

p32_rot_flg_faustmann(t_all,j,ac)       = 1$(p32_IGR(t_all,j,ac) > sum(cell(i,j),pm_interest(t_all,i)) + p32_land_rent_weighted(t_all,j,ac))
                                        + 0$(p32_IGR(t_all,j,ac) <= sum(cell(i,j),pm_interest(t_all,i)) + p32_land_rent_weighted(t_all,j,ac));

p32_rot_length_faustmann(t_all,j)       = sum(ac,p32_rot_flg_faustmann(t_all,j,ac));

*********************************************************************************

** Change rotation based on switch. If not use calculation before faustmann
if(s32_faustmann_rotation = 0,
  p32_rot_length_ac_eqivalent(t_all,j) = sum(ac,p32_rot_flg(t_all,j,ac));
elseif s32_faustmann_rotation = 1,
  p32_rot_length_ac_eqivalent(t_all,j) = sum(ac,p32_rot_flg_faustmann(t_all,j,ac));
);

** We provide a upper limit of 90 years for commercial plantations.
** 90 years translates to age-class 18 (90/5)
p32_rot_length_ac_eqivalent(t_all,j)$(p32_rot_length_ac_eqivalent(t_all,j)>18) = 18;
p32_rot_length_ac_eqivalent(t_historical,j) = p32_rot_length_ac_eqivalent("y1995",j);

** Holding rotation lengths constant after the end of this century.
p32_rot_length_ac_eqivalent(t_future,j) = p32_rot_length_ac_eqivalent("y2100",j);

** Number of cells in each region
p32_ncells(i) = sum(cell(i,j),1);

**** Representative regional rotation
loop(t_all,
  p32_rotation_regional(t_all,i) = ceil(sum(cell(i,j), p32_rot_length_ac_eqivalent(t_all,j))/p32_ncells(i));
  );

** Earlier we converted rotation lengths to absolute numbers, now we make the Conversion
** back to rotation length in age-classes.
p32_rotation_cellular_estb(t_all,j) = ceil(p32_rot_length_ac_eqivalent(t_all,j));

** Set harvesting rotations same as establishment rotations -- Don't move this line below extension of rotation. This is overwritten in the next loop anyways
p32_rotation_cellular_harvesting(t_all,j) = p32_rotation_cellular_estb(t_all,j);

** RL Extension
p32_rotation_cellular_estb(t_all,j) = p32_rotation_cellular_estb(t_all,j) * s32_rotation_extension ;

** With the following loop, harvesting rotations are updated based on the rotation length
** at which the establishment of plantations was made. For example, an establishment with
** 50 year rotation in mind in year 2000 shall be available for harvest when the age of
** this plantation is 50 years in 2050. The following loop makes sure that the harvesting
** age is updated correctly in the future.

loop(j,
  loop(t_all,
      p32_rotation_offset = p32_rotation_cellular_estb(t_all,j);
* The harvest year is calculated for future based on current establishment decision
      p32_rotation_cellular_harvesting(t_all+p32_rotation_offset,j) = p32_rotation_cellular_estb(t_all,j);
    );
  );

** This loop fixes empty gaps.
** For example in 2035, if establishment length was 10 (50yrs) then it should be harvested in 2085
** But in 2040, lets say if establishment length was 11 (55yrs) then the harvesting should happen in 2095.
** This leaves y2090 with a gap where model doesn't know which value to choose
** At this point, it takes the values which were initialized in lines above
** where we give harvested rotations the same value as establishment rotation to start with
** The loop below makes some educated guess based on jumps during these blind spots and fills them with proper numbers
loop(t_all,
  p32_rotation_cellular_harvesting(t_all+1,j)$(abs(p32_rotation_cellular_harvesting(t_all+1,j) - p32_rotation_cellular_harvesting(t_all,j))>2 AND ord(t_all)<card(t_all)) = p32_rotation_cellular_harvesting(t_all,j);
  );

p32_cdr_ac(t,j,ac) = 0;

** Define ini32 set. ac0 is included here. Therefore, initial shifting in presolve.
ini32(j,ac) = no;
ini32(j,ac) = yes$(ord(ac) >= 1 AND ac.off < p32_rotation_cellular_harvesting("y1995",j));

** divide initial forestry area by number of age classes within ini32
** divide initial forestry area by number of age classes within ini32
if(s32_initial_distribution = 0,
** Initialize with highest age class
  p32_land_start_ac(j,"plant","acx") = pcm_land(j,"forestry") * sum(cell(i,j),f32_plantedforest(i));
  p32_land_start_ac(j,"ndc","acx")   = pcm_land(j,"forestry") * sum(cell(i,j),1-f32_plantedforest(i));

elseif s32_initial_distribution = 1,
** Initialize with equal distribution among rotation age classes
** Plantated forest area is divided into ndcs (other planted forest) and plantations
    p32_land_start_ac(j,"plant",ac)$(ini32(j,ac)) = pm_land_start(j,"forestry") * sum(cell(i,j),f32_plantedforest(i))/p32_rotation_cellular_harvesting("y1995",j);
    p32_land_start_ac(j,"ndc",ac)$(ini32(j,ac))   = pm_land_start(j,"forestry") * sum(cell(i,j),1- f32_plantedforest(i))/p32_rotation_cellular_harvesting("y1995",j);

);

** Redistribute to youngest age class in case the distribution to plantations and
** ndcs does not match fully with LUH initialized data
loop(j,
  if(pm_land_start(j,"forestry") > sum((type32,ac),p32_land_start_ac(j,type32,ac)),
    p32_land_start_ac(j,"ndc","ac0") = p32_land_start_ac(j,"ndc","ac0") + (pm_land_start(j,"forestry") - sum((type32,ac),p32_land_start_ac(j,type32,ac)));
    );
);

** Initialize forestry land types 
pc32_land(j,type32,ac) = p32_land_start_ac(j,type32,ac);

*** NPI/NDC policies BEGIN
** Afforestation policies NPI and NDCs
p32_aff_pol(t,j) = round(f32_aff_pol(t,j,"%c32_aff_policy%"),6);

* Calculate the remaining exogenous afforestation with respect to the maximum exogenous target over time.
* `p32_aff_togo` is used to adjust `s32_max_aff_area` in the constraint `q32_max_aff`.
p32_aff_togo(t,i) = smax(t2, sum(cell(i,j), p32_aff_pol(t2,j))) - sum(cell(i,j), p32_aff_pol(t,j));

* Calculate the limit for endogenous afforestation
* The global (`s32_max_aff_area`) and regional limit (`f32_max_aff_area`) for total afforestation (sum of endogenous and exogenous) is reduced by exogenous NPI/NDC afforestation (`p32_aff_pol`).
if(s32_max_aff_area_glo = 1,
  i32_max_aff_area_glo(t) = s32_max_aff_area - smax(t2, sum(j, p32_aff_pol(t2,j)));
  i32_max_aff_area_glo(t)$(i32_max_aff_area_glo(t) < 1e-6) = 0;
  i32_max_aff_area_glo(t)$(m_year(t) <= sm_fix_SSP2) = Inf;
  i32_max_aff_area_reg(t,i) = 0;
elseif s32_max_aff_area_glo = 0,
  i32_max_aff_area_reg(t,i) = f32_max_aff_area(i) - smax(t2, sum(cell(i,j), p32_aff_pol(t2,j)));
  i32_max_aff_area_reg(t,i)$(i32_max_aff_area_reg(t,i) < 1e-6) = 0;
  i32_max_aff_area_reg(t,i)$(m_year(t) <= sm_fix_SSP2) = Inf;
  i32_max_aff_area_glo(t) = 0;
);

*** NPI/NDC policies END

*fix bph effect to zero for all age classes except the ac that is chosen for the bph effect to occur after planting (e.g. canopy closure)
*fade-in from ac10 to ac30. First effect in ac10 (ord 3), last effect in ac30 (ord 7).
ac_bph(ac) = no;
ac_bph(ac) = yes$(ord(ac) >= 3 AND ord(ac) <= 7);
display ac_bph;

p32_aff_bgp(j,ac) = 0;
p32_tcre_glo(j) = 0;
if(s32_tcre_local = 1,
  p32_aff_bgp(j,ac_bph) = f32_aff_bgp(j,"%c32_aff_bgp%")/f32_tcre(j,"%c32_tcre_ctrl%")/card(ac_bph);
else
*m_weightedmean returns a global value, which is then used assigned to all j. We use land area as weight.
  p32_tcre_glo(j2) = m_weightedmean(f32_tcre(j,"%c32_tcre_ctrl%"),sum(land, pcm_land(j,land)),j);
  p32_aff_bgp(j,ac_bph) = f32_aff_bgp(j,"%c32_aff_bgp%")/p32_tcre_glo(j)/card(ac_bph);
);

** set bii coefficients
p32_bii_coeff(type32,bii_class_secd,potnatveg) = 0;
if(s32_aff_bii_coeff = 0,
 p32_bii_coeff("aff",bii_class_secd,potnatveg) = fm_bii_coeff(bii_class_secd,potnatveg)
elseif s32_aff_bii_coeff = 1,
 p32_bii_coeff("aff",bii_class_secd,potnatveg) = fm_bii_coeff("timber",potnatveg)
);
p32_bii_coeff("ndc",bii_class_secd,potnatveg) = fm_bii_coeff(bii_class_secd,potnatveg);
p32_bii_coeff("plant",bii_class_secd,potnatveg) = fm_bii_coeff("timber",potnatveg);

* initialize parameter
p32_land(t,j,type32,ac) = 0;

* initialize forest disturbance losses
p32_disturbance_loss_ftype32(t,j,"aff",ac) = 0;
