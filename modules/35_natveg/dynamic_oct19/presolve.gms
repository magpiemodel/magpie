*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Regrowth of natural vegetation (natural succession) is modelled by shifting age-classes according to time step length.
s35_shift = m_yeardiff(t)/5;
if((ord(t) = 1),
	p35_secdforest(t,j,ac) = i35_secdforest(j,ac);
	p35_other(t,j,ac) = i35_other(j,ac);
else
* example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s35_shift = 1)
    p35_other(t,j,ac)$(ord(ac) > s35_shift) = p35_other(t-1,j,ac-s35_shift);
* account for cases at the end of the age class set (s35_shift > 1) which are not shifted by the above calculation
    p35_other(t,j,"acx") = p35_other(t,j,"acx")
                  + sum(ac$(ord(ac) > card(ac)-s35_shift), p35_other(t-1,j,ac));

* example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s35_shift = 1)
    p35_secdforest(t,j,ac)$(ord(ac) > s35_shift) = p35_secdforest(t-1,j,ac-s35_shift);
* account for cases at the end of the age class set (s35_shift > 1) which are not shifted by the above calculation
    p35_secdforest(t,j,"acx") = p35_secdforest(t,j,"acx")
                  + sum(ac$(ord(ac) > card(ac)-s35_shift), p35_secdforest(t-1,j,ac));
);

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
  p35_save_primforest(t,j) = vm_land.l(j,"primforest");
  p35_save_secdforest(t,j) = vm_land.l(j,"secdforest");
  p35_save_other(t,j) = vm_land.l(j,"other");
$elseif "%c35_protect_scenario%" == "forest"
  p35_save_primforest(t,j) = vm_land.l(j,"primforest");
  p35_save_secdforest(t,j) = vm_land.l(j,"secdforest");
  p35_save_other(t,j) = 0;
$elseif "%c35_protect_scenario%" == "WDPA"
  p35_save_primforest(t,j) = p35_protect_shr(t,j,"WDPA")*pm_land_start(j,"primforest");
  p35_save_secdforest(t,j) = p35_protect_shr(t,j,"WDPA")*pm_land_start(j,"secdforest");
  p35_save_other(t,j) = p35_protect_shr(t,j,"WDPA")*pm_land_start(j,"other");
$else
* conservation priority scenarios start in 2020, in addition to WDPA protection
  if ((sameas(t,"y1995") or sameas(t,"y2000") or sameas(t,"y2005") or sameas(t,"y2010") or sameas(t,"y2015")),
  p35_save_primforest(t,j) = p35_protect_shr(t,j,"WDPA")*pm_land_start(j,"primforest");
  p35_save_secdforest(t,j) = p35_protect_shr(t,j,"WDPA")*pm_land_start(j,"secdforest");
  p35_save_other(t,j) = p35_protect_shr(t,j,"WDPA")*pm_land_start(j,"other");
  else
  p35_save_primforest(t,j) = (p35_protect_shr(t,j,"WDPA")+p35_protect_shr(t,j,"%c35_protect_scenario%"))*pm_land_start(j,"primforest");
  p35_save_secdforest(t,j) = (p35_protect_shr(t,j,"WDPA")+p35_protect_shr(t,j,"%c35_protect_scenario%"))*pm_land_start(j,"secdforest");
  p35_save_other(t,j) = (p35_protect_shr(t,j,"WDPA")+p35_protect_shr(t,j,"%c35_protect_scenario%"))*pm_land_start(j,"other");
  p35_save_primforest(t,j)$(p35_save_primforest(t,j) > vm_land.l(j,"primforest")) = vm_land.l(j,"primforest");
  p35_save_secdforest(t,j)$(p35_save_secdforest(t,j) > pc35_secdforest(j,"acx")) = pc35_secdforest(j,"acx");
  p35_save_other(t,j)$(p35_save_other(t,j) > pc35_other(j,"acx")) = pc35_other(j,"acx");
  );
$endif

* Within the optimization, primary and secondary forests can only decrease
* (e.g. for cropland expansion).
* In contrast, other natural land can decrease and increase within the optimization.
* For instance, other natural land increases if agricultural land is abandoned.
vm_land.lo(j,"primforest") = p35_save_primforest(t,j);
vm_land.up(j,"primforest") = vm_land.l(j,"primforest");

v35_secdforest.fx(j,"ac0") = 0;
v35_secdforest.lo(j,"acx") = p35_save_secdforest(t,j);
v35_secdforest.up(j,ac_sub) = pc35_secdforest(j,ac_sub);

v35_other.lo(j,"acx") = p35_save_other(t,j);
v35_other.up(j,ac_sub) = pc35_other(j,ac_sub);

* calculate carbon density
* highest carbon density 1st time step to account for reshuffling
if((ord(t) = 1),
	p35_carbon_density_secdforest(t,j,ac,ag_pools) = pm_carbon_density_ac(t,j,"acx",ag_pools);
	p35_carbon_density_other(t,j,ac,ag_pools) = pm_carbon_density_ac(t,j,"acx",ag_pools);
else
	p35_carbon_density_secdforest(t,j,ac,ag_pools) = pm_carbon_density_ac(t,j,ac,ag_pools);
	p35_carbon_density_other(t,j,ac,ag_pools) = pm_carbon_density_ac(t,j,ac,ag_pools);
);

* update pcm_carbon_stock. Needed for shifting from other land to secdforest (p35_recovered_forest).
pcm_carbon_stock(j,"secdforest",ag_pools) =
           sum(ac, pc35_secdforest(j,ac)
           * p35_carbon_density_secdforest(t,j,ac,ag_pools));

pcm_carbon_stock(j,"other",ag_pools) =
           sum(ac, pc35_other(j,ac)
           * p35_carbon_density_other(t,j,ac,ag_pools));

p35_min_forest(t,j)$(p35_min_forest(t,j) > vm_land.l(j,"primforest") + vm_land.l(j,"secdforest")) = vm_land.l(j,"primforest") + vm_land.l(j,"secdforest");
p35_min_other(t,j)$(p35_min_other(t,j) > vm_land.l(j,"other")) = vm_land.l(j,"other");
