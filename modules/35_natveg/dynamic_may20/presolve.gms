*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_hvarea_secdforest.fx(j,ac_est) = 0;
vm_hvarea_other.fx(j,ac_est) = 0;

if((ord(t) = 1),
	pc35_secdforest(j,ac) = i35_secdforest(j,ac);
	pc35_other(j,ac) = i35_other(j,ac);
else
 	pc35_secdforest(j,ac) = p35_secdforest(t-1,j,ac);
 	pc35_other(j,ac) = p35_other(t-1,j,ac);
);

* Shift ageclasses due to forest fires, first calculate damages
if(s35_forest_damage=1,
	pc35_disturbance_loss_secdf(j,ac_sub) = pc35_secdforest(j,ac_sub) * sum(cell(i,j),f35_forest_lost_share(i,"wildfire"))*m_timestep_length_forestry;
	pc35_disturbance_loss_primf(j) = pcm_land(j,"primforest") * sum(cell(i,j),f35_forest_lost_share(i,"wildfire"))*m_timestep_length_forestry;
	);

if(s35_forest_damage=2,
	pc35_disturbance_loss_secdf(j,ac_sub) = pc35_secdforest(j,ac_sub) * sum((cell(i,j),combined_loss),f35_forest_lost_share(i,combined_loss))*m_timestep_length_forestry;
	pc35_disturbance_loss_primf(j) = pcm_land(j,"primforest") * sum((cell(i,j),combined_loss),f35_forest_lost_share(i,combined_loss))*m_timestep_length_forestry;
	);
* Distribution of damages correctly
	pc35_secdforest(j,ac_est) = pc35_secdforest(j,ac_est) + sum(ac_sub,pc35_disturbance_loss_secdf(j,ac_sub))/card(ac_est) + pc35_disturbance_loss_primf(j)/card(ac_est);
  pc35_secdforest(j,ac_sub) = pc35_secdforest(j,ac_sub) - pc35_disturbance_loss_secdf(j,ac_sub);
  pcm_land(j,"primforest") = pcm_land(j,"primforest") - pc35_disturbance_loss_primf(j);
  vm_land.l(j,"primforest") = pcm_land(j,"primforest");

* Regrowth of natural vegetation (natural succession) is modelled by shifting age-classes according to time step length.
s35_shift = m_timestep_length_forestry/5;
* example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s35_shift = 1)
    p35_other(t,j,ac)$(ord(ac) > s35_shift) = pc35_other(j,ac-s35_shift);
* account for cases at the end of the age class set (s35_shift > 1) which are not shifted by the above calculation
    p35_other(t,j,"acx") = p35_other(t,j,"acx")
                  + sum(ac$(ord(ac) > card(ac)-s35_shift), pc35_other(j,ac));

* Usual shift
* example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s35_shift = 1)
    p35_secdforest(t,j,ac)$(ord(ac) > s35_shift) = pc35_secdforest(j,ac-s35_shift);
* account for cases at the end of the age class set (s35_shift > 1) which are not shifted by the above calculation
    p35_secdforest(t,j,"acx") = p35_secdforest(t,j,"acx")
                  + sum(ac$(ord(ac) > card(ac)-s35_shift), pc35_secdforest(j,ac));

*' @code
*' If the vegetation carbon density in a simulation unit due to regrowth
*' exceeds a threshold of 20 tC/ha the respective area is shifted from other natural land to secondary forest.
p35_recovered_forest(t,j,ac)$(not sameas(ac,"acx")) =
			p35_other(t,j,ac)$(pm_carbon_density_ac(t,j,ac,"vegc") > 20);
p35_other(t,j,ac) = p35_other(t,j,ac) - p35_recovered_forest(t,j,ac);
p35_secdforest(t,j,ac) =
			p35_secdforest(t,j,ac) + p35_recovered_forest(t,j,ac);
*' @stop

pc35_secdforest(j,ac) = p35_secdforest(t,j,ac);
v35_secdforest.l(j,ac) = pc35_secdforest(j,ac);
vm_land.l(j,"secdforest") = sum(ac, pc35_secdforest(j,ac));
pcm_land(j,"secdforest") = sum(ac, pc35_secdforest(j,ac));

pc35_other(j,ac) = p35_other(t,j,ac);
v35_other.l(j,ac) = pc35_other(j,ac);
vm_land.l(j,"other") = sum(ac, pc35_other(j,ac));
pcm_land(j,"other") = sum(ac, pc35_other(j,ac));

*** Forest protection (WDPA areas and different conservation priority areas)
* calc protection share for primforest, secdforest and other land
p35_protect_shr(t,j,prot_type)$(sum(land_natveg, pm_land_start(j,land_natveg)) > 0) = f35_protect_area(j,prot_type)/sum(land_natveg, pm_land_start(j,land_natveg));
p35_protect_shr(t,j,prot_type)$(p35_protect_shr(t,j,prot_type) > 1) = 1;
p35_protect_shr(t,j,prot_type)$(p35_protect_shr(t,j,prot_type) < 0) = 0;

* protection scenarios
$ifthen "%c35_protect_scenario%" == "none"
  p35_save_primforest(t,j) = 0;
  p35_save_secdforest(t,j) = 0;
  p35_save_other(t,j) = 0;
$elseif "%c35_protect_scenario%" == "full"
  p35_save_primforest(t,j) = pcm_land(j,"primforest");
  p35_save_secdforest(t,j) = pcm_land(j,"secdforest");
  p35_save_other(t,j) = pcm_land(j,"other");
$elseif "%c35_protect_scenario%" == "forest"
	  p35_save_primforest(t,j) = pcm_land(j,"primforest");
	  p35_save_secdforest(t,j) = pcm_land(j,"secdforest");
	  p35_save_other(t,j) = 0;
$elseif "%c35_protect_scenario%" == "WDPA"
  p35_save_primforest(t,j) = p35_protect_shr(t,j,"WDPA")*pm_land_start(j,"primforest");
  p35_save_secdforest(t,j) = p35_protect_shr(t,j,"WDPA")*pm_land_start(j,"secdforest");
  p35_save_other(t,j) = p35_protect_shr(t,j,"WDPA")*pm_land_start(j,"other");
$elseif "%c35_protect_scenario%" == "HalfEarth"
  p35_save_primforest(t,j) = p35_protect_shr(t,j,"HalfEarth")*pm_land_start(j,"primforest");
  p35_save_secdforest(t,j) = p35_protect_shr(t,j,"HalfEarth")*pm_land_start(j,"secdforest");
  p35_save_other(t,j) = p35_protect_shr(t,j,"HalfEarth")*pm_land_start(j,"other");
$else
* conservation priority scenarios start in 2020, in addition to WDPA protection
  if (m_year(t) <= sm_fix_SSP2,
  p35_save_primforest(t,j) = p35_protect_shr(t,j,"WDPA")*pm_land_start(j,"primforest");
  p35_save_secdforest(t,j) = p35_protect_shr(t,j,"WDPA")*pm_land_start(j,"secdforest");
  p35_save_other(t,j) = p35_protect_shr(t,j,"WDPA")*pm_land_start(j,"other");
  else
  p35_save_primforest(t,j) = (p35_protect_shr(t,j,"WDPA")+p35_protect_shr(t,j,"%c35_protect_scenario%"))*pm_land_start(j,"primforest");
  p35_save_secdforest(t,j) = (p35_protect_shr(t,j,"WDPA")+p35_protect_shr(t,j,"%c35_protect_scenario%"))*pm_land_start(j,"secdforest");
  p35_save_other(t,j) = (p35_protect_shr(t,j,"WDPA")+p35_protect_shr(t,j,"%c35_protect_scenario%"))*pm_land_start(j,"other");
  p35_save_primforest(t,j)$(p35_save_primforest(t,j) > pcm_land(j,"primforest")) = pcm_land(j,"primforest");
  p35_save_secdforest(t,j)$(p35_save_secdforest(t,j) > pc35_secdforest(j,ac)) = pc35_secdforest(j,ac);
  p35_save_other(t,j)$(p35_save_other(t,j) > pc35_other(j,ac)) = pc35_other(j,ac);
  );
$endif

* Within the optimization, primary and secondary forests can only decrease
* (e.g. for cropland expansion).
* In contrast, other natural land can decrease and increase within the optimization.
* For instance, other natural land increases if agricultural land is abandoned.

** Setting bounds for only allowing s35_natveg_harvest_shr percentage of available primf to be harvested (highest age class)
** Allowing selective logging only after historical period
if (sum(sameas(t_past,t),1) = 1,
vm_land.lo(j,"primforest") = p35_save_primforest(t,j);
else
vm_land.lo(j,"primforest") = max((1-s35_natveg_harvest_shr) * pcm_land(j,"primforest"), p35_save_primforest(t,j));
);
vm_land.up(j,"primforest") = pcm_land(j,"primforest");
m_boundfix(vm_land,(j,"primforest"),l,10e-5);

*reset bounds
v35_secdforest.lo(j,ac) = 0;
v35_secdforest.up(j,ac) = Inf;
** Setting bounds for only allowing s35_natveg_harvest_shr percentage of available primf to be harvested (highest age class)
if (sum(sameas(t_past,t),1) = 1,
v35_secdforest.lo(j,"acx") = p35_save_secdforest(t,j);
else
v35_secdforest.lo(j,"acx") = max((1-s35_natveg_harvest_shr) * pc35_secdforest(j,"acx"), p35_save_secdforest(t,j));
);
v35_secdforest.up(j,ac_sub) = pc35_secdforest(j,ac_sub);
m_boundfix(v35_secdforest,(j,ac_sub),l,10e-5);

*reset bounds
v35_other.lo(j,ac) = 0;
v35_other.up(j,ac) = Inf;
*set bounds
v35_other.lo(j,"acx") = p35_save_other(t,j);
v35_other.up(j,ac_sub) = pc35_other(j,ac_sub);
m_boundfix(v35_other,(j,ac_sub),l,10e-5);

* calculate carbon density
* highest carbon density 1st time step to account for reshuffling

p35_carbon_density_secdforest(t,j,ac,ag_pools) = pm_carbon_density_ac(t,j,ac,ag_pools);
p35_carbon_density_other(t,j,ac,ag_pools) = pm_carbon_density_ac(t,j,ac,ag_pools);

**delete?
*if((ord(t) = 1 AND s35_secdf_distribution=0),
*	p35_carbon_density_secdforest(t,j,ac,ag_pools) = pm_carbon_density_ac(t,j,"acx",ag_pools);
*	p35_carbon_density_other(t,j,ac,ag_pools) = pm_carbon_density_ac(t,j,"acx",ag_pools);
*);

p35_min_forest(t,j)$(p35_min_forest(t,j) > pcm_land(j,"primforest") + pcm_land(j,"secdforest")) = pcm_land(j,"primforest") + pcm_land(j,"secdforest");
p35_min_other(t,j)$(p35_min_other(t,j) > pcm_land(j,"other")) = pcm_land(j,"other");


if(ord(t)=1,
*******************************************************************************
** Calibrate plantations yields
*******************************************************************************

p35_primforest_dummy(t,j,ac) = 0;
p35_primforest_dummy(t,j,"acx") = pcm_land(j,"primforest");

** What is the existing Growing stock in MAgPIE for initialization in MtDM
** Area is Mha and yield is tDM/ha
  p35_gs_reg_secdf(i,ac) = sum(cell(i,j),p35_secdforest(t,j,ac)       * pm_timber_yield("y1995",j,ac,"secdforest")) ;
	p35_gs_reg_primf(i,ac) = sum(cell(i,j),p35_primforest_dummy(t,j,ac) * pm_timber_yield("y1995",j,ac,"primforest")) ;
** Sum over age class because we don't want to have growing stocks distributed to cells with no plantations.
  p35_gs_secdf(i) = sum(ac,p35_gs_reg_secdf(i,ac));
  p35_gs_primf(i) = sum(ac,p35_gs_reg_primf(i,ac));

** Convert FAO Growing stock (Mm3) to MtDM (Not allowed less than 10 Mm3 in any world region)
** This will be the target growing stock which we try to match
  f35_gs_absolutetarget(i)$(f35_gs_absolutetarget(i)<10) = 10;
  f35_gs_absolutetarget(i) = f35_gs_absolutetarget(i) * 0.6;

** How is the growing stock distributed in each region over each ac
  p35_gs_distribution(i,ac)$(p35_gs_secdf(i)+p35_gs_primf(i)>0) = (p35_gs_reg_secdf(i,ac) + p35_gs_reg_primf(i,ac)) / (p35_gs_secdf(i) + p35_gs_primf(i)) ;

** We only know our target values at regional level. This has to be divided correctly in each region for each age class
** We multiply this regional target of growing stock with a region and age-class specific share from the modeled growing stock
  p35_target_gs_reg(i,ac)$(p35_gs_reg_secdf(i,ac) + p35_gs_reg_primf(i,ac) > 0) =  f35_gs_absolutetarget(i) * p35_gs_distribution(i,ac);

* Calculate Scaling factor
  p35_gs_scaling_reg(i,ac) = 1;
  p35_gs_scaling_reg(i,ac)$(p35_gs_reg_secdf(i,ac) + p35_gs_reg_primf(i,ac) > 0) = p35_target_gs_reg(i,ac) / (p35_gs_reg_secdf(i,ac) + p35_gs_reg_primf(i,ac));
  p35_gs_scaling_reg(i,ac)$(p35_gs_scaling_reg(i,ac)<0.2) = 0.2;
  );

** Update timber yield
pm_timber_yield(t,j,ac,land_natveg) = pm_timber_yield(t,j,ac,land_natveg) * sum(cell(i,j),p35_gs_scaling_reg(i,ac));
