*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
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
*For the initialization of age-classes in secondary forest, forest area in 5-year age-classes based on GFAD is used 
 p35_secdf_ageclass(j,ac) = im_forest_ageclass(j,ac);
* Young forest (`ac_young`) includes plantations and might be (strongly) affected by disturbances such as fire. 
* Therefore, young forest (`ac_young`) is disregarded for the initialization of age-classes in secondary forest. 
* Instead, age-class areas from `ac35` are used as a proxy for `ac_young`.
 p35_secdf_ageclass(j,ac_young) = p35_secdf_ageclass(j,"ac35");
* `acx` includes primary forest. Therefore, primary forest is subtracted from `acx`.
 p35_secdf_ageclass(j,"acx") = p35_secdf_ageclass(j,"acx") - pcm_land(j,"primforest");
 p35_secdf_ageclass(j,"acx")$(p35_secdf_ageclass(j,"acx") < 0) = 0;

* Distribution of age-classes in secondary forest. In case of missing area information, `acx` is assumed.
 p35_secdf_ageclass_dist(j,ac) = 0;
 p35_secdf_ageclass_dist(j,"acx") = 1;
 p35_secdf_ageclass_dist(j,ac)$(sum(ac2,p35_secdf_ageclass(j,ac2))>0) = 
           p35_secdf_ageclass(j,ac)/sum(ac2,p35_secdf_ageclass(j,ac2));
 i35_secdforest(j,ac)$(not sameas(ac,"ac0")) = pcm_land(j,"secdforest")*p35_secdf_ageclass_dist(j,ac);
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

* Initialize biodiversity value
vm_bv.l(j,"primforest",potnatveg) = 
  pcm_land(j,"primforest") * fm_bii_coeff("primary",potnatveg) * fm_luh2_side_layers(j,potnatveg);

vm_bv.l(j,"secdforest",potnatveg) = 
  sum(bii_class_secd, sum(ac_to_bii_class_secd(ac,bii_class_secd), i35_secdforest(j,ac)) *
  fm_bii_coeff(bii_class_secd,potnatveg)) * fm_luh2_side_layers(j,potnatveg);

vm_bv.l(j,"other",potnatveg) = 
  sum(bii_class_secd, sum(ac_to_bii_class_secd(ac,bii_class_secd), sum(othertype35, i35_land_other(j,othertype35,ac))) *
  fm_bii_coeff(bii_class_secd,potnatveg)) * fm_luh2_side_layers(j,potnatveg);
