*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

if((ord(t) = 1),
  pc35_secdforest(j,ac) = i35_secdforest(j,ac);
  pc35_youngsecdf(j,ac) = i35_youngsecdf(j,ac);
  pc35_other(j,ac) = i35_other(j,ac);
else
  pc35_secdforest(j,ac) = p35_secdforest(t-1,j,ac);
  pc35_youngsecdf(j,ac) = p35_youngsecdf(t-1,j,ac);
  pc35_other(j,ac) = p35_other(t-1,j,ac);
);

* ----------------------------------------------------
* Shift ageclasses due to shifting agriculture fires
* ----------------------------------------------------

* first calculate damages
if(s35_forest_damage=1,
  p35_disturbance_loss_secdf(t,j,ac_sub) = pc35_secdforest(j,ac_sub) * sum(cell(i,j),f35_forest_lost_share(i,"shifting_agriculture"))*m_timestep_length_forestry;
  p35_disturbance_loss_primf(t,j) = pcm_land(j,"primforest") * sum(cell(i,j),f35_forest_lost_share(i,"shifting_agriculture"))*m_timestep_length_forestry;
  );

* shifting cultivation is faded out
if(s35_forest_damage=2,
  p35_disturbance_loss_secdf(t,j,ac_sub) = pc35_secdforest(j,ac_sub) * sum(cell(i,j),f35_forest_lost_share(i,"shifting_agriculture"))*m_timestep_length_forestry*(1 - p35_damage_fader(t));
  p35_disturbance_loss_primf(t,j) = pcm_land(j,"primforest") * sum(cell(i,j),f35_forest_lost_share(i,"shifting_agriculture"))*m_timestep_length_forestry*(1 - p35_damage_fader(t));
  );

if(s35_forest_damage=3,
  p35_disturbance_loss_secdf(t,j,ac_sub) = pc35_secdforest(j,ac_sub) * sum((cell(i,j),combined_loss),f35_forest_lost_share(i,combined_loss))*m_timestep_length_forestry;
  p35_disturbance_loss_primf(t,j) = pcm_land(j,"primforest") * sum((cell(i,j),combined_loss),f35_forest_lost_share(i,combined_loss))*m_timestep_length_forestry;
  );

* generic disturbance scenarios
if(s35_forest_damage=4,
  p35_disturbance_loss_secdf(t,j,ac_sub) = pc35_secdforest(j,ac_sub) * f35_forest_shock(t,"%c35_shock_scenario%") * m_timestep_length;
  p35_disturbance_loss_primf(t,j) = pcm_land(j,"primforest") * f35_forest_shock(t,"%c35_shock_scenario%") * m_timestep_length;
  );

* Distribution of damages correctly
pc35_secdforest(j,ac_est) = pc35_secdforest(j,ac_est) + sum(ac_sub,p35_disturbance_loss_secdf(t,j,ac_sub))/card(ac_est2) + p35_disturbance_loss_primf(t,j)/card(ac_est2);

pc35_secdforest(j,ac_sub) = pc35_secdforest(j,ac_sub) - p35_disturbance_loss_secdf(t,j,ac_sub);
pcm_land(j,"primforest") = pcm_land(j,"primforest") - p35_disturbance_loss_primf(t,j);
vm_land.l(j,"primforest") = pcm_land(j,"primforest");


* -------------------------------------------------
* Calculate area of secondary forest recovery
* -------------------------------------------------

*** Distribute forestry abandonement
pc35_youngsecdf(j,ac_est) = vm_lu_transitions.l(j,"forestry","other")/card(ac_est2);
pc35_youngsecdf(j,ac_est)$(sum(ac_est2,pc35_youngsecdf(j,ac_est2)) > pcm_max_forest_est(j)) = pcm_max_forest_est(j)/card(ac_est2);

* The proportion of secondary forest recovery in total natveg recovery is derived
* from the remaining forest recovery area
p35_max_forest_recovery(j) = pcm_max_forest_est(j) - sum(ac, pc35_youngsecdf(j,ac));
p35_forest_recovery_shr(j) = p35_max_forest_recovery(j) / (sum(land_ag, pcm_land(j,land_ag))+pcm_land(j,"urban")+1e-10);
p35_forest_recovery_shr(j)$(p35_forest_recovery_shr(j) > 1) = 1;
* Abandoned land pc35_other(j,ac_est) is then distributed propotionally using the forest recovery share.
p35_recovered_forest(t,j,ac_est) = pc35_other(j,ac_est) * p35_forest_recovery_shr(j);
p35_recovered_forest(t,j,ac_est)$(sum(ac_est2,p35_recovered_forest(t,j,ac_est2)) > p35_max_forest_recovery(j)) = p35_max_forest_recovery(j)/card(ac_est2);
pc35_other(j,ac_est) = pc35_other(j,ac_est) - p35_recovered_forest(t,j,ac_est);
pc35_youngsecdf(j,ac_est) = pc35_youngsecdf(j,ac_est) + p35_recovered_forest(t,j,ac_est);

* ------------------------------------------------
* Natural vegetation growth (age-class shift)
* ------------------------------------------------

* Regrowth of natural vegetation (natural succession) is modelled by shifting age-classes according to time step length.
s35_shift = m_timestep_length_forestry/5;
* example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s35_shift = 1)
    p35_other(t,j,ac)$(ord(ac) > s35_shift) = pc35_other(j,ac-s35_shift);
* account for cases at the end of the age class set (s35_shift > 1) which are not shifted by the above calculation
    p35_other(t,j,"acx") = p35_other(t,j,"acx")
                  + sum(ac$(ord(ac) > card(ac)-s35_shift), pc35_other(j,ac));

* example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s35_shift = 1)
    p35_youngsecdf(t,j,ac)$(ord(ac) > s35_shift) = pc35_youngsecdf(j,ac-s35_shift);
* account for cases at the end of the age class set (s35_shift > 1) which are not shifted by the above calculation
    p35_youngsecdf(t,j,"acx") = p35_youngsecdf(t,j,"acx")
                  + sum(ac$(ord(ac) > card(ac)-s35_shift), pc35_youngsecdf(j,ac));

* Usual shift
* example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s35_shift = 1)
    p35_secdforest(t,j,ac)$(ord(ac) > s35_shift) = pc35_secdforest(j,ac-s35_shift);
* account for cases at the end of the age class set (s35_shift > 1) which are not shifted by the above calculation
    p35_secdforest(t,j,"acx") = p35_secdforest(t,j,"acx")
                  + sum(ac$(ord(ac) > card(ac)-s35_shift), pc35_secdforest(j,ac));


* -------------------------------------------------------
* Carbon threshold for secondary forest maturation
* -------------------------------------------------------

*' @code
*' If the vegetation carbon density in a simulation unit due to regrowth
*' exceeds a threshold of 20 tC/ha the respective area is shifted from young secondary
*' forest, which is still considered other land, to secondary forest land.
p35_maturesecdf(t,j,ac)$(not sameas(ac,"acx")) =
      p35_youngsecdf(t,j,ac)$(pm_carbon_density_secdforest_ac(t,j,ac,"vegc") > 20);
p35_youngsecdf(t,j,ac) = p35_youngsecdf(t,j,ac) - p35_maturesecdf(t,j,ac);
p35_secdforest(t,j,ac) = p35_secdforest(t,j,ac) + p35_maturesecdf(t,j,ac);
*' @stop

pc35_secdforest(j,ac) = p35_secdforest(t,j,ac);
v35_secdforest.l(j,ac) = pc35_secdforest(j,ac);
vm_land.l(j,"secdforest") = sum(ac, pc35_secdforest(j,ac));
pcm_land(j,"secdforest") = sum(ac, pc35_secdforest(j,ac));

pc35_other(j,ac) = p35_other(t,j,ac);
v35_other.l(j,ac) = pc35_other(j,ac);
pc35_youngsecdf(j,ac) = p35_youngsecdf(t,j,ac);
v35_youngsecdf.l(j,ac) = pc35_youngsecdf(j,ac);
vm_land.l(j,"other") = sum(ac, pc35_other(j,ac)) + sum(ac, pc35_youngsecdf(j,ac));
pcm_land(j,"other") = sum(ac, pc35_other(j,ac)) + sum(ac, pc35_youngsecdf(j,ac));

* -------------------------------------
* Set bounds based on land conservation
* -------------------------------------

* Within the optimization, primary forests can only decrease
* (e.g. due to cropland expansion).
* In contrast, other natural land and secdforest can decrease and increase within the optimization.
* For instance, other natural land increases if agricultural land is abandoned.

* Correct land conservation for damage
pm_land_conservation(t,j,land_natveg,"protect")$(pm_land_conservation(t,j,land_natveg,"protect") > pcm_land(j,land_natveg)) = pcm_land(j,land_natveg);

** Setting bounds for only allowing s35_natveg_harvest_shr percentage of available forest to be harvested (highest age class)

* Primary forest

** Allowing selective logging only after historical period
if (sum(sameas(t_past,t),1) = 1,
vm_land.lo(j,"primforest") = 0;
else
vm_land.lo(j,"primforest") = (1-s35_natveg_harvest_shr) * pcm_land(j,"primforest");
);
* Primary forest conservation
vm_land.lo(j,"primforest")$(vm_land.lo(j,"primforest") < pm_land_conservation(t,j,"primforest","protect")) = pm_land_conservation(t,j,"primforest","protect");
vm_land.up(j,"primforest") = pcm_land(j,"primforest");

* Secondary forest

*reset bound
v35_secdforest.lo(j,ac) = 0;
v35_secdforest.up(j,ac) = Inf;

p35_protection_dist(j,ac_sub) = (pc35_secdforest(j,ac_sub)/sum(ac_sub2,pc35_secdforest(j,ac_sub2)))$(sum(ac_sub2,pc35_secdforest(j,ac_sub2))>0);
if (sum(sameas(t_past,t),1) = 1,
v35_secdforest.lo(j,ac_sub) = pm_land_conservation(t,j,"secdforest","protect") * p35_protection_dist(j,ac_sub);
else
v35_secdforest.lo(j,ac_sub) = max((1-s35_natveg_harvest_shr) * pc35_secdforest(j,ac_sub), pm_land_conservation(t,j,"secdforest","protect") * p35_protection_dist(j,ac_sub));
);
* upper bound
v35_secdforest.up(j,ac_sub) = pc35_secdforest(j,ac_sub);
m_boundfix(v35_secdforest,(j,ac_sub),l,1e-6);

* Secondary forest conservation
* protection bound fix
pm_land_conservation(t,j,"secdforest","protect")$(abs(pm_land_conservation(t,j,"secdforest","protect") - sum(ac_sub, pc35_secdforest(j,ac_sub))) < 1e-6) = sum(ac_sub, pc35_secdforest(j,ac_sub));
* set restoration target
p35_land_restoration(j,"secdforest") = pm_land_conservation(t,j,"secdforest","restore");
* Do not restore secdforest in areas where total natural
* land area meets the total natural land conservation target
p35_land_restoration(j,"secdforest")$(sum(land_natveg, pcm_land(j,land_natveg)) >= sum((land_natveg, consv_type), pm_land_conservation(t,j,land_natveg,consv_type))) = 0;

* Since forest restoration cannot be bigger than the potential area for secdforest recovery,
* any remaining restoration area is substracted and shifted to other land restoration.
p35_restoration_shift(j) = p35_land_restoration(j,"secdforest") - p35_max_forest_recovery(j);
p35_restoration_shift(j)$(p35_restoration_shift(j) < 0) = 0;
p35_land_restoration(j,"secdforest") = p35_land_restoration(j,"secdforest") - p35_restoration_shift(j);
pm_land_conservation(t,j,"other","restore") = pm_land_conservation(t,j,"other","restore") + p35_restoration_shift(j);

* set conservation bound
vm_land.lo(j,"secdforest") = pm_land_conservation(t,j,"secdforest","protect") + p35_land_restoration(j,"secdforest");

** Other land

*reset bounds
v35_other.lo(j,ac) = 0;
v35_other.up(j,ac) = Inf;
*set upper bound
v35_other.up(j,ac_sub) = pc35_other(j,ac_sub);
m_boundfix(v35_other,(j,ac_sub),l,1e-6);
v35_youngsecdf.lo(j,ac_sub) = 0;
v35_youngsecdf.up(j,ac_sub) = pc35_youngsecdf(j,ac_sub);
m_boundfix(v35_youngsecdf,(j,ac_sub),l,1e-6);
v35_youngsecdf.fx(j,ac_est) = 0;

* Other land conservation
* protection bound fix
pm_land_conservation(t,j,"other","protect")$(abs(pm_land_conservation(t,j,"other","protect") - sum(ac_sub, pc35_other(j,ac_sub))) < 1e-6) = sum(ac_sub, pc35_other(j,ac_sub));
* set restoration target
p35_land_restoration(j,"other") = pm_land_conservation(t,j,"other","restore");
* Do not restore other land in areas where total natural
* land area meets the total natural land conservation target
p35_land_restoration(j,"other")$(sum(land_natveg, pcm_land(j,land_natveg)) >= sum((land_natveg, consv_type), pm_land_conservation(t,j,land_natveg,consv_type))) = 0;
* set conservation bound
vm_land.lo(j,"other") = pm_land_conservation(t,j,"other","protect") + p35_land_restoration(j,"other");

* ----------------------------
* NPI/NDC protection policy
* ----------------------------

p35_min_forest(t,j)$(p35_min_forest(t,j) > pcm_land(j,"primforest") + pcm_land(j,"secdforest")) = pcm_land(j,"primforest") + pcm_land(j,"secdforest");
p35_min_other(t,j)$(p35_min_other(t,j) > pcm_land(j,"other")) = pcm_land(j,"other");

** Display
p35_land(t,j,land_natveg,ac) = 0;
p35_land(t,j,"primforest","acx") = pcm_land(j,"primforest");
p35_land(t,j,"secdforest",ac) = p35_secdforest(t,j,ac);
*p35_land(t,j,"other",ac) = p35_other(t,j,ac):
p35_updated_gs_natfor(t,i) = 0;
p35_updated_gs_natfor(t,i)$(sum((cell(i,j),ac,land_natveg), p35_land(t,j,land_natveg,ac))>0) = (sum((cell(i,j),ac,land_natveg),(pm_timber_yield(t,j,ac,land_natveg) / sm_wood_density) * p35_land(t,j,land_natveg,ac))/ sum((cell(i,j),ac,land_natveg), p35_land(t,j,land_natveg,ac)));

** Youngest age classes are not allowed to be harvested
v35_hvarea_secdforest.fx(j,ac_est) = 0;
v35_hvarea_other.fx(j,ac_est) = 0;
v35_secdforest_reduction.fx(j,ac_est) = 0;
v35_other_reduction.fx(j,ac_est) = 0;

vm_prod_natveg.fx(j,"other","wood") = 0;

if(s35_hvarea = 0,
 v35_hvarea_secdforest.fx(j,ac_sub) = 0;
 v35_hvarea_primforest.fx(j) = 0;
 v35_hvarea_other.fx(j,ac_sub) = 0;
elseif s35_hvarea = 1,
 v35_hvarea_secdforest.fx(j,ac_sub) = (v35_secdforest.l(j,ac_sub) - v35_secdforest.lo(j,ac_sub))*s35_hvarea_secdforest*m_timestep_length_forestry;
 v35_hvarea_primforest.fx(j) = (vm_land.l(j,"primforest") - vm_land.lo(j,"primforest"))*s35_hvarea_primforest*m_timestep_length_forestry;
 v35_hvarea_other.fx(j,ac_sub) = (v35_other.l(j,ac_sub) - v35_other.lo(j,ac_sub))*s35_hvarea_other*m_timestep_length_forestry;
);
