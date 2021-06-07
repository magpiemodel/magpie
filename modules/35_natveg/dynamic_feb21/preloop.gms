*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

****** Regional share of land protection policies in selective countries:
* Country switch to determine countries for which land protection shall be applied.
* In the default case, the land protection affects all countries when activated.
p35_country_dummy(iso) = 0;
p35_country_dummy(policy_countries35) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p35_region_prot_shr(t_all,i) = sum(i_to_iso(i,iso), p35_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));

** Land protection scenarios (WDPA and different conservation priority areas)
p35_protect_shr_ini(j,prot_type_all) = 0;
p35_protect_shr_ini(j,prot_type)$(sum(land_natveg, pm_land_start(j,land_natveg)) > 0) = f35_protect_area(j,prot_type)/sum(land_natveg, pm_land_start(j,land_natveg));

* WDPA is the default protection layer
p35_protect_shr(t,j,"WDPA",land_natveg) = p35_protect_shr_ini(j,"WDPA") * f35_protection_fader(t,"none");

p35_protect_shr(t,j,"PrimForest",land_natveg) = p35_protect_shr(t,j,"WDPA",land_natveg);
p35_protect_shr(t,j,"PrimForest","primforest") = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + 1*f35_protection_fader(t,"%c35_protect_fadein%");

p35_protect_shr(t,j,"Secdforest",land_natveg) = p35_protect_shr(t,j,"WDPA",land_natveg);
p35_protect_shr(t,j,"Secdforest","secdforest") = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + 1*f35_protection_fader(t,"%c35_protect_fadein%");

p35_protect_shr(t,j,"Forest",land_natveg) = p35_protect_shr(t,j,"WDPA",land_natveg);
p35_protect_shr(t,j,"Forest","primforest") = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + 1*f35_protection_fader(t,"%c35_protect_fadein%");
p35_protect_shr(t,j,"Forest","secdforest") = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + 1*f35_protection_fader(t,"%c35_protect_fadein%");

p35_protect_shr(t,j,"Forest_Other",land_natveg) = p35_protect_shr(t,j,"WDPA",land_natveg);
p35_protect_shr(t,j,"Forest_Other","primforest") = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + 1*f35_protection_fader(t,"%c35_protect_fadein%");
p35_protect_shr(t,j,"Forest_Other","secdforest") = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + 1*f35_protection_fader(t,"%c35_protect_fadein%");
p35_protect_shr(t,j,"Forest_Other","other") = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + 1*f35_protection_fader(t,"%c35_protect_fadein%");

p35_protect_shr(t,j,"BH",land_natveg) = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + (p35_protect_shr_ini(j,"WDPA") + p35_protect_shr_ini(j,"BH"))*f35_protection_fader(t,"%c35_protect_fadein%");
p35_protect_shr(t,j,"FF",land_natveg) = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + (p35_protect_shr_ini(j,"WDPA") + p35_protect_shr_ini(j,"FF"))*f35_protection_fader(t,"%c35_protect_fadein%");
p35_protect_shr(t,j,"CPD",land_natveg) = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + (p35_protect_shr_ini(j,"WDPA") + p35_protect_shr_ini(j,"CPD"))*f35_protection_fader(t,"%c35_protect_fadein%");
p35_protect_shr(t,j,"LW",land_natveg) = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + (p35_protect_shr_ini(j,"WDPA") + p35_protect_shr_ini(j,"LW"))*f35_protection_fader(t,"%c35_protect_fadein%");

p35_protect_shr(t,j,"FF_BH","primforest") = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + 1*f35_protection_fader(t,"%c35_protect_fadein%");
p35_protect_shr(t,j,"FF_BH","secdforest") = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + (p35_protect_shr_ini(j,"WDPA") + max(p35_protect_shr_ini(j,"FF"),p35_protect_shr_ini(j,"BH")))*f35_protection_fader(t,"%c35_protect_fadein%");
p35_protect_shr(t,j,"FF_BH","other") = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + (p35_protect_shr_ini(j,"WDPA") + p35_protect_shr_ini(j,"BH"))*f35_protection_fader(t,"%c35_protect_fadein%");

* Correction of Half Earth protection share
* Note: Half Earth already contains WDPA protection
p35_protect_shr_ini(j,"HalfEarth")$(p35_protect_shr_ini(j,"HalfEarth") < p35_protect_shr_ini(j,"WDPA")) = p35_protect_shr_ini(j,"WDPA");
p35_protect_shr(t,j,"HalfEarth",land_natveg) = p35_protect_shr_ini(j,"WDPA") * (1-f35_protection_fader(t,"%c35_protect_fadein%")) + p35_protect_shr_ini(j,"HalfEarth")*f35_protection_fader(t,"%c35_protect_fadein%");

* remove implausible values
p35_protect_shr(t,j,prot_type_all,land_natveg)$(p35_protect_shr(t,j,prot_type_all,land_natveg) > 1) = 1;
p35_protect_shr(t,j,prot_type_all,land_natveg)$(p35_protect_shr(t,j,prot_type_all,land_natveg) < 0) = 0;

* calculate protected areas
p35_save_natveg(t,j,land_natveg) = 
	pm_land_start(j,land_natveg) * sum(cell(i,j), 
	p35_protect_shr(t,j,"%c35_protect_scenario%",land_natveg) * p35_region_prot_shr(t,i)
	+ p35_protect_shr(t,j,"%c35_protect_scenario_noselect%",land_natveg) * (1-p35_region_prot_shr(t,i)));


i35_other(j,ac) = 0;
i35_other(j,"acx") = pcm_land(j,"other");

* initialize secdforest area depending on switch.
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

** Initialize values to be used in presolve
p35_recovered_forest(t,j,ac) = 0;

** Initialize forest protection
p35_min_forest(t,j) = f35_min_land_stock(t,j,"%c35_ad_policy%","forest");
p35_min_other(t,j) = f35_min_land_stock(t,j,"%c35_ad_policy%","other");

*initialize parameter
p35_other(t,j,ac) = 0;
p35_secdforest(t,j,ac) = 0;

* initialize forest disturbance losses
p35_disturbance_loss_secdf(t,j,ac) = 0;
p35_disturbance_loss_primf(t,j) = 0;

**************************************************************************
*******************************************************************************
** Calibrate Natural vegetation yields
*******************************************************************************
** Initialize with 0 cvalues
p35_land_start_ac(j,ac,land_natveg) = 0;
** Capture natural forest values (primary forest + secondary forest)
p35_land_start_ac(j,"acx","primforest") = pcm_land(j,"primforest");
p35_land_start_ac(j,ac,"secdforest") = i35_secdforest(j,ac);

** Wherever FAO reports >0 growing stock, we calculate how much growing stock MAGPIE
** sees even before optimization starts
p35_observed_gs_reg(i) = 0;
p35_observed_gs_reg(i)$(f35_gs_relativetarget(i)>0)  = (sum((cell(i,j),ac,land_natveg),(pm_timber_yield_initial(j,ac,land_natveg)$(not sameas(ac,"ac0")) / sm_wood_density) * p35_land_start_ac(j,ac,land_natveg)$(not sameas(ac,"ac0")))/ sum((cell(i,j),ac,land_natveg),p35_land_start_ac(j,ac,land_natveg)$(not sameas(ac,"ac0"))));

** Initialze calibration factor for growing stocks as 1
** we dont set it to 0 as we don't want to modify carbon densities by multiplication with 0 later
p35_gs_scaling_reg(i) = 1;
** Calculate the ratio between target growing stock (reported by FAO) and observed growing stock (value at initialization in MAgPIE)
p35_gs_scaling_reg(i)$(f35_gs_relativetarget(i)>0) = f35_gs_relativetarget(i) / p35_observed_gs_reg(i);

** Update c-densitiy based on calibration factor for growing stocks
pm_carbon_density_ac(t_all,j,ac,"vegc") = pm_carbon_density_ac(t_all,j,ac,"vegc") * sum(cell(i,j),p35_gs_scaling_reg(i));
