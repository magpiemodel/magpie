*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' We model regrowth of natural vegetation (natural succession) by shifting age-classes according to time step length.
s35_shift = m_yeardiff(t)/5;
if((ord(t) = 1),
	p35_secdforest(t,j,ac,"before") = i35_secdforest(j,ac);
	p35_other(t,j,ac,"before") = i35_other(j,ac);
else
	p35_other(t,j,ac,"before") =
	    0$(ord(ac) = 1)
        + p35_other(t-1,j,ac-s35_shift,"after")$(ord(ac) > 1 AND ord(ac) < card(ac))
        + p35_other(t-1,j,ac,"after")$(ord(ac) = card(ac));
	p35_secdforest(t,j,ac,"before") =
		0$(ord(ac) = 1)
        + p35_secdforest(t-1,j,ac-s35_shift,"after")$(ord(ac) > 1 AND ord(ac) < card(ac))
        + p35_secdforest(t-1,j,ac,"after")$(ord(ac) = card(ac));
);
*' @stop

*' @code
*' If the vegetation carbon density in a simulation unit due to regrowth 
*' exceeds a threshold of 20 tC/ha we shift the respective area from other natural land to secondary forest.
p35_recovered_forest(t,j,ac)$(not sameas(ac,"acx")) = 
			p35_other(t,j,ac,"before")$(pm_carbon_density_ac(t,j,ac,"vegc") > 20);
p35_other(t,j,ac,"before") = p35_other(t,j,ac,"before") - p35_recovered_forest(t,j,ac);
p35_secdforest(t,j,ac,"before") = 
			p35_secdforest(t,j,ac,"before") + p35_recovered_forest(t,j,ac);
*' @stop

*' @code
*' Age-classes exist only between the optimization time steps. 
*' For the optimization, we aggregate age-classes to 3 group defined in `land35`.
pc35_secdforest(j,land35) = sum(ac_land35(ac,land35), p35_secdforest(t,j,ac,"before"));
v35_secdforest.l(j,land35) = pc35_secdforest(j,land35);
vm_land.l(j,"secdforest") = sum(land35, pc35_secdforest(j,land35));
pcm_land(j,"secdforest") = sum(land35, pc35_secdforest(j,land35));
*' 
pc35_other(j,land35) = sum(ac_land35(ac,land35), p35_other(t,j,ac,"before"));
v35_other.l(j,land35) = pc35_other(j,land35);
vm_land.l(j,"other") = sum(land35, pc35_other(j,land35));
pcm_land(j,"other") = sum(land35, pc35_other(j,land35));
*' @stop

*' @description
*' Land protection policies. 
*' By default, we protect areas in primary forest, secondary forest or other natural land
*' based on the World Database on Protected Areas (WDPA). We protect areas based on IUCN catI+II 
*' (IUCN = International Union for Conservation of Nature), which reflect areas currently 
*' under protection (e.g. strict nature reserve and national park). 
*' On top of the WDPA land protection, there are options to protect different conservation priority areas
*' such as biodiversity hotspots (BH), centers of plant diversity (CBD), frontier forests (FF) and last of the wild (LW). 
*' @stop

*** Forest protection (WDPA areas and different conservation priority areas)
* calc protection share for primforest, secdforest and other land
pc35_natveg_old(j) = vm_land.l(j,"primforest") + pc35_secdforest(j,"old") + pc35_other(j,"old");
p35_protect_shr(t,j,prot_type)$(pc35_natveg_old(j) > 0) = f35_protect_area(j,prot_type)/pc35_natveg_old(j);
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
$elseif "%c35_protect_scenario%" == "WDPA"
  p35_save_primforest(t,j) = p35_protect_shr(t,j,"WDPA")*vm_land.l(j,"primforest");
  p35_save_secdforest(t,j) = p35_protect_shr(t,j,"WDPA")*pc35_secdforest(j,"old");
  p35_save_other(t,j) = p35_protect_shr(t,j,"WDPA")*pc35_other(j,"old");
$else
* conservation priority scenarios start in 2020, in addition to WDPA protection
  if ((sameas(t,"y1995") or sameas(t,"y2000") or sameas(t,"y2005") or sameas(t,"y2010") or sameas(t,"y2015")),
  p35_save_primforest(t,j) = p35_protect_shr(t,j,"WDPA")*vm_land.l(j,"primforest");
  p35_save_secdforest(t,j) = p35_protect_shr(t,j,"WDPA")*pc35_secdforest(j,"old");
  p35_save_other(t,j) = p35_protect_shr(t,j,"WDPA")*pc35_other(j,"old");
  else
  p35_save_primforest(t,j) = (p35_protect_shr(t,j,"WDPA")+p35_protect_shr(t,j,"%c35_protect_scenario%"))*vm_land.l(j,"primforest");
  p35_save_secdforest(t,j) = (p35_protect_shr(t,j,"WDPA")+p35_protect_shr(t,j,"%c35_protect_scenario%"))*pc35_secdforest(j,"old");
  p35_save_other(t,j) = (p35_protect_shr(t,j,"WDPA")+p35_protect_shr(t,j,"%c35_protect_scenario%"))*pc35_other(j,"old");
  p35_save_primforest(t,j)$(p35_save_primforest(t,j) > vm_land.l(j,"primforest")) = vm_land.l(j,"primforest");
  p35_save_secdforest(t,j)$(p35_save_secdforest(t,j) > pc35_secdforest(j,"old")) = pc35_secdforest(j,"old");
  p35_save_other(t,j)$(p35_save_other(t,j) > pc35_other(j,"old")) = pc35_other(j,"old");
  );
$endif

*' @code
*' Within the optimization, primary and secondary forests can only decrease 
*' (e.g. for cropland expansion).
*' In contrast, other natural land can decrease and increase within the optimization. 
*' For instance, other natural land increases if agricultural land is abandoned.
*' 
vm_land.lo(j,"primforest") = p35_save_primforest(t,j);
vm_land.up(j,"primforest") = vm_land.l(j,"primforest");
m_boundfix(vm_land,(j,"primforest"),l,10e-5);
*' 
v35_secdforest.fx(j,"new") = 0;
v35_secdforest.lo(j,"grow") = 0;
v35_secdforest.up(j,"grow") = pc35_secdforest(j,"grow");
m_boundfix(v35_secdforest,(j,"grow"),l,10e-5);
v35_secdforest.lo(j,"old") = p35_save_secdforest(t,j);
v35_secdforest.up(j,"old") = pc35_secdforest(j,"old");
m_boundfix(v35_secdforest,(j,"old"),l,10e-5);
*' 
v35_other.lo(j,"new") = 0;
v35_other.up(j,"new") = Inf;
v35_other.lo(j,"grow") = 0;
v35_other.up(j,"grow") = pc35_other(j,"grow");
m_boundfix(v35_other,(j,"grow"),l,10e-5);
v35_other.lo(j,"old") = p35_save_other(t,j);
v35_other.up(j,"old") = pc35_other(j,"old");
m_boundfix(v35_other,(j,"old"),l,10e-5);
*' @stop

*calculate carbon density
*highest carbon density 1st time step to account for reshuffling
if((ord(t) = 1),
	p35_carbon_density_secdforest(t,j,land35,c_pools) = pm_carbon_density_ac(t,j,"acx",c_pools);
	p35_carbon_density_other(t,j,land35,c_pools) = pm_carbon_density_ac(t,j,"acx",c_pools);
else
	p35_carbon_density_secdforest(t,j,"new",c_pools) = pm_carbon_density_ac(t,j,"ac0",c_pools);
	p35_carbon_density_secdforest(t,j,"grow",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p35_secdforest(t,j,ac,"before"),(ac_land35(ac,"grow")));
	p35_carbon_density_secdforest(t,j,"old",c_pools) = pm_carbon_density_ac(t,j,"acx",c_pools);
	p35_carbon_density_other(t,j,"new",c_pools) = pm_carbon_density_ac(t,j,"ac0",c_pools);
	p35_carbon_density_other(t,j,"grow",c_pools) = m_weightedmean(pm_carbon_density_ac(t,j,ac,c_pools),p35_other(t,j,ac,"before"),(ac_land35(ac,"grow")));
	p35_carbon_density_other(t,j,"old",c_pools) = pm_carbon_density_ac(t,j,"acx",c_pools);
);

p35_min_forest(t,j)$(p35_min_forest(t,j) > vm_land.l(j,"primforest") + vm_land.l(j,"secdforest")) = vm_land.l(j,"primforest") + vm_land.l(j,"secdforest");
p35_min_cstock(t,j)$(p35_min_cstock(t,j) > sum(c_pools, vm_carbon_stock.l(j,"primforest",c_pools) + vm_carbon_stock.l(j,"secdforest",c_pools))) = sum(c_pools, vm_carbon_stock.l(j,"primforest",c_pools) + vm_carbon_stock.l(j,"secdforest",c_pools));
