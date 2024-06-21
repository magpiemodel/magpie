*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** initialize other land
i35_land_other(j,othertype35,ac) = 0;
i35_land_other(j,"othernat","acx") = pcm_land(j,"other");

** initialize secdforest area depending on switch.
if(s35_secdf_distribution = 0,
  i35_secdforest(j,"acx") = pcm_land(j,"secdforest");
elseif s35_secdf_distribution = 1,
* ac0 is excluded here. Therefore no initial shifting is needed.
  i35_secdforest(j,ac)$(not sameas(ac,"ac0")) = pcm_land(j,"secdforest")/(card(ac)-1);
elseif s35_secdf_distribution = 2,
*classes 1, 2, 3 include plantation and are therefore excluded
*As disturbance history (fire) would affect the age structure
*We use the sahre from class 4 to be in class 1,2,3
*class 15 is primary forest and is therefore excluded
 i35_plantedclass_ac(j,ac) =  im_plantedclass_ac(j,ac);
 i35_plantedclass_ac(j,ac_planted)$(i35_plantedclass_ac(j,ac_planted) > im_plantedclass_ac(j,"ac35")) =  im_plantedclass_ac(j,"ac35");

* Distribute this area correctly
 p35_poulter_dist(j,ac) = 0;
 p35_poulter_dist(j,ac) = (i35_plantedclass_ac(j,ac)/sum(ac2,i35_plantedclass_ac(j,ac2)))$(sum(ac2,i35_plantedclass_ac(j,ac2))>0);
 i35_secdforest(j,ac)$(not sameas(ac,"ac0")) = pcm_land(j,"secdforest")*p35_poulter_dist(j,ac);
);

*use residual approach to avoid rounding errors
i35_secdforest(j,"acx") = i35_secdforest(j,"acx") + (pcm_land(j,"secdforest") - sum(ac, i35_secdforest(j,ac)));

*initialize parameter
p35_land_other(t,j,othertype35,ac) = 0;
p35_secdforest(t,j,ac) = 0;

* initialize forest disturbance losses
p35_disturbance_loss_secdf(t,j,ac) = 0;
p35_disturbance_loss_primf(t,j) = 0;

* -------------------------------------------------------------
* Initialize remaining potential forest establishment area
* -------------------------------------------------------------

* Forest establishment is constrained by the potential forest area in each cluster.
* Hence, the area for forest establishments is given by the potential forest
* area minus all forest areas in the previous time step.
pm_max_forest_est(t,j) = f35_pot_forest_area(t,j) - sum(land_forest, pcm_land(j,land_forest));
pm_max_forest_est(t,j)$(pm_max_forest_est(t,j) < 1e-6) = 0;

* -----------------------------------------
* Land conservation for climate mitigation
* -----------------------------------------

p35_min_forest(t,j) = f35_min_land_stock(t,j,"%c35_ad_policy%","forest");
p35_min_other(t,j) = f35_min_land_stock(t,j,"%c35_ad_policy%","other");


* ----------------------------------------
* Calibrate Natural vegetation yields
* ----------------------------------------

** Initialize with 0 cvalues
p35_land_start_ac(j,ac,land_natveg) = 0;
** Capture natural forest values (primary forest + secondary forest)
p35_land_start_ac(j,"acx","primforest") = pcm_land(j,"primforest");
p35_land_start_ac(j,ac,"secdforest") = i35_secdforest(j,ac);


* -----------------------------
* Set forest damage trajectory
* -----------------------------
m_sigmoid_time_interpol(p35_damage_fader,sm_fix_SSP2,s35_forest_damage_end,0,1);

* ---------------------------------------
* Initialise natveg in first time step
* ---------------------------------------

  pc35_secdforest(j,ac) = i35_secdforest(j,ac);
  pc35_land_other(j,othertype35,ac) = i35_land_other(j,othertype35,ac);
