*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

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
p35_protect_shr(t,j,prot_type) = 0;
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
p35_land_start_ac(j,ac,land_natveg) = 0;
p35_land_start_ac(j,"acx","primforest") = pcm_land(j,"primforest");
p35_land_start_ac(j,ac,"secdforest") = i35_secdforest(j,ac);
p35_observed_gs_reg(i) = 0;
p35_observed_gs_reg(i)$(f35_gs_relativetarget(i)>0)  = (sum((cell(i,j),ac,land_natveg),(pm_timber_yield_initial(j,ac,land_natveg)$(not sameas(ac,"ac0")) / sm_wood_density) * p35_land_start_ac(j,ac,land_natveg)$(not sameas(ac,"ac0")))/ sum((cell(i,j),ac,land_natveg),p35_land_start_ac(j,ac,land_natveg)$(not sameas(ac,"ac0"))));
p35_gs_scaling_reg(i) = 1;
p35_gs_scaling_reg(i)$(f35_gs_relativetarget(i)>0) = f35_gs_relativetarget(i) / p35_observed_gs_reg(i);
*p35_gs_scaling_reg(i)$(p35_gs_scaling_reg(i) < 1) = 1;
*p35_gs_scaling_reg(i)$(p35_gs_scaling_reg(i)>10) = 10;
display p35_land_start_ac,f35_gs_relativetarget,p35_observed_gs_reg,p35_gs_scaling_reg;

** Update c-densitiy
pm_carbon_density_ac(t_all,j,ac,"vegc") = pm_carbon_density_ac(t_all,j,ac,"vegc") * sum(cell(i,j),p35_gs_scaling_reg(i));
