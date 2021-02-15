** Calculation of Single rotation model rotation lengths
** Using forestry carbon densitiy here via carbon density data exchange from carbon module.
p32_carbon_density_ac_forestry(t_all,j,ac) = pm_carbon_density_ac_forestry(t_all,j,ac,"vegc");

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
$elseif "%c32_interest_rate%" == "global"
  p32_rot_flg(t_all,j,ac) = 1$(p32_IGR(t_all,j,ac) - s32_forestry_int_rate  >  0)
                          + 0$(p32_IGR(t_all,j,ac) - s32_forestry_int_rate <= 0);
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
  pm_representative_rotation(t_all,i) = ord(t_all) + ceil(sum(cell(i,j),p32_rot_length_ac_eqivalent(t_all,j))/p32_ncells(i));
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

** Afforestation policies NPI and NDCs
p32_aff_pol(t,j) = f32_aff_pol(t,j,"%c32_aff_policy%");

* Calculate the remaining exogenous afforestation with respect to the maximum exogenous target over time.
* `p32_aff_togo` is used to adjust `s32_max_aff_area` in the constraint `q32_max_aff`.
p32_aff_togo(t) = sum(j, smax(t2, p32_aff_pol(t2,j)) - p32_aff_pol(t,j));

* Adjust the afforestation limit `s32_max_aff_area` upwards, if it is below the exogenous policy target.
s32_max_aff_area = max(s32_max_aff_area, sum(j, smax(t2, p32_aff_pol(t2,j))) );

p32_cdr_ac(t,j,ac) = 0;

** Define ini32 set. ac0 is included here. Therefore, initial shifting in presolve.
ini32(j,ac) = no;
ini32(j,ac) = yes$(ord(ac) >= 1 AND ac.off < p32_rotation_cellular_harvesting("y1995",j));

** divide initial forestry area by number of age classes within ini32
if(s32_initial_distribution = 0,
** Initialize with highest age class
  p32_land_start_ac(j,"plant","acx") = pcm_land(j,"forestry") * sum(cell(i,j),f32_plantedforest(i));
  p32_land_start_ac(j,"ndc","acx")   = pcm_land(j,"forestry") * sum(cell(i,j),1-f32_plantedforest(i));

elseif s32_initial_distribution = 1,
** Initialize with equal distribution among rotation age classes
    p32_plant_ini_ac(j) = pm_land_start(j,"forestry") * sum(cell(i,j),f32_plantedforest(i))/p32_rotation_cellular_harvesting("y1995",j);
    p32_land_start_ac(j,"plant",ac)$(ini32(j,ac)) = p32_plant_ini_ac(j);
    p32_land_start_ac(j,"ndc",ac)$(ini32(j,ac))   = pm_land_start(j,"forestry") * sum(cell(i,j),1- f32_plantedforest(i))/p32_rotation_cellular_harvesting("y1995",j);

elseif s32_initial_distribution = 2,
    p32_plant_ini_ac(j) = pm_land_start(j,"forestry") * sum(cell(i,j),f32_plantedforest(i));
    p32_land_start_ac(j,"plant",ac) = p32_plant_ini_ac(j) * f32_ac_dist(ac);
    p32_land_start_ac(j,"ndc",ac)   = pm_land_start(j,"forestry") * sum(cell(i,j),1-f32_plantedforest(i)) * f32_ac_dist(ac);

elseif s32_initial_distribution = 3,
    p32_plant_ini_ac(j) = pm_land_start(j,"forestry") * sum(cell(i,j),f32_plantedforest(i));
    p32_rotation_dist(j,ac) =  (im_plantedclass_ac(j,ac)$(ini32(j,ac))/sum(ac2,im_plantedclass_ac(j,ac2)$(ini32(j,ac2))))$(sum(ac2,im_plantedclass_ac(j,ac2)$(ini32(j,ac2))));
    p32_land_start_ac(j,"plant",ac)$(ini32(j,ac)) = p32_plant_ini_ac(j) * p32_rotation_dist(j,ac);
    p32_land_start_ac(j,"ndc",ac)$(ini32(j,ac))   = pm_land_start(j,"forestry") * sum(cell(i,j),1-f32_plantedforest(i)) * p32_rotation_dist(j,ac);

*use residual approach to avoid distributional errors i.e., poulter set with no plantations but luh reporting plantations in a cell
    loop (j,
      if(sum(ac,p32_land_start_ac(j,"plant",ac)$(ini32(j,ac))) = 0,
      p32_land_start_ac(j,"plant",ac)$(ini32(j,ac)) =  pm_land_start(j,"forestry") * sum(cell(i,j),f32_plantedforest(i))/p32_rotation_cellular_harvesting("y1995",j);
      p32_land_start_ac(j,"ndc",ac)$(ini32(j,ac))   =  pm_land_start(j,"forestry") * sum(cell(i,j),1-f32_plantedforest(i))/p32_rotation_cellular_harvesting("y1995",j);
       );
    );

elseif s32_initial_distribution = 4,
    loop(j,
** Set all acs to 0
    p32_ac_dist_flag(j,ac) = 0;
** Calculate reverse of age-classes, if rotation is 11acs, then ac0 should get a value of 11, 11th ac should get value of 1
    p32_ac_dist_flag(j,ac) = (10*p32_rotation_cellular_harvesting("y1995",j)-((ord(ac)-1))*5)$(ord(ac) <= p32_rotation_cellular_harvesting("y1995",j));
** Calculate the weights, youngest age-class will have highest weight
    p32_ac_dist(j,ac) = (p32_ac_dist_flag(j,ac) / (sum(ac2,p32_ac_dist_flag(j,ac2)) + ord(ac)))$(ord(ac) <= p32_rotation_cellular_harvesting("y1995",j));
** there can be isntances where this distribution is not summing up to 1, in that case we take the excess and remove it evenly from all age-classes
    p32_ac_dist(j,ac)$(sum(ac2, p32_ac_dist(j,ac2))>1) = (p32_ac_dist(j,ac) - (sum(ac2, p32_ac_dist(j,ac2))-1)/p32_ac_dist_flag(j,"ac0"))$(ord(ac) <= p32_rotation_cellular_harvesting("y1995",j));
    );
** Isolate plantations from planted forest (forestry)
    p32_plant_ini_ac(j) = pm_land_start(j,"forestry") * sum(cell(i,j),f32_plantedforest(i));
** Divide plantations according to distribution
    p32_land_start_ac(j,"plant",ac) = p32_plant_ini_ac(j) * p32_ac_dist(j,ac);
** Divide NDCs according to same distribution
    p32_land_start_ac(j,"ndc",ac)   = pm_land_start(j,"forestry") * sum(cell(i,j),1-f32_plantedforest(i)) * p32_ac_dist(j,ac);

*use residual approach to avoid distributional errors i.e., poulter set with no plantations but luh reporting plantations in a cell
    loop (j,
      if(sum(ac,p32_land_start_ac(j,"plant",ac)$(ini32(j,ac))) = 0,
      p32_land_start_ac(j,"plant",ac)$(ini32(j,ac)) =  pm_land_start(j,"forestry") * sum(cell(i,j),f32_plantedforest(i))/p32_rotation_cellular_harvesting("y1995",j);
      p32_land_start_ac(j,"ndc",ac)$(ini32(j,ac))   =  pm_land_start(j,"forestry") * sum(cell(i,j),1-f32_plantedforest(i))/p32_rotation_cellular_harvesting("y1995",j);
       );
    );

);

** Initialization of land
*p32_land_start_ac(j,type32,ac) = p32_land("y1995",j,type32,ac);

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
  p32_tcre_glo(j2) = m_weightedmean(f32_tcre(j,"%c32_tcre_ctrl%"),sum(land, pcm_land(j,land)),j)
  p32_aff_bgp(j,ac_bph) = f32_aff_bgp(j,"%c32_aff_bgp%")/p32_tcre_glo(j)/card(ac_bph)
);

**************************************************************************
*******************************************************************************
** Calibrate plantations yields
*******************************************************************************
p32_observed_gs_reg(i) = 0;
p32_observed_gs_reg(i)$(f32_gs_relativetarget(i)>0)  = (sum((cell(i,j),ac),(pm_timber_yield_initial(j,ac,"forestry")$(not sameas(ac,"ac0")) / sm_wood_density) * p32_land_start_ac(j,"plant",ac)$(not sameas(ac,"ac0")))/ sum((cell(i,j),ac),p32_land_start_ac(j,"plant",ac)$(not sameas(ac,"ac0"))));
p32_gs_scaling_reg(i) = 1;
p32_gs_scaling_reg(i)$(f32_gs_relativetarget(i)>0) = f32_gs_relativetarget(i) / p32_observed_gs_reg(i);
p32_gs_scaling_reg(i)$(p32_gs_scaling_reg(i) < 1) = 1;

display p32_land_start_ac;

** Update c-densitiy
display p32_gs_scaling_reg;
pm_carbon_density_ac_forestry(t_all,j,ac,"vegc") = pm_carbon_density_ac_forestry(t_all,j,ac,"vegc") * sum(cell(i,j),p32_gs_scaling_reg(i));

** Calculate plantation contribution scaled to Growing stock in plantations
p32_plantation_contribution(t_ext,i) = 0.001;
p32_plantation_contribution(t_ext,i)$(f32_gs_relativetarget(i)>0) = f32_plantation_contribution(t_ext,i,"%c32_dev_scen%","%c32_incr_rate%");
