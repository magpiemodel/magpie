*** |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


** Land protection

if(m_year(t) <= sm_fix_SSP2,
 pm_land_protection(t,j,land) = f22_wdpa_baseline(t,j,land);

else

$ifthen "%c22_protect_scenario%" == "HalfEarth"
pm_land_protection(t,j,land_natveg) =
	pm_land_start(j,land_natveg) * sum(cell(i,j),
	p22_protect_shr(t,j,"HalfEarth",land_natveg) * p22_country_weight(i)
	+ p22_protect_shr(t,j,"%c22_protect_scenario_noselect%",land_natveg) * (1-p22_country_weight(i)));
* make sure that area covered by WDPA data is included in areas where the HalfEarth data reports less
	pm_land_protection(t,j,land_natveg)$(pm_land_protection(t,j,land_natveg) < f22_wdpa_baseline(t,j,land_natveg)) = f22_wdpa_baseline(t,j,land_natveg);
$else
 pm_land_protection(t,j,land_natveg) = f22_wdpa_baseline(t,j,land_natveg) +
	pm_land_start(j,land_natveg) * sum(cell(i,j),
	p22_protect_shr(t,j,"%c22_protect_scenario%",land_natveg) * p22_country_weight(i)
	+ p22_protect_shr(t,j,"%c22_protect_scenario_noselect%",land_natveg) * (1-p22_country_weight(i)));
$endif

);

pm_land_protection(t,j,land_natveg)$(pm_land_protection(t,j,land_natveg) > pcm_land(j,land_natveg)) = pcm_land(j,land_natveg);


p22_min_forest(t,j)$(p22_min_forest(t,j) > pcm_land(j,"primforest") + pcm_land(j,"secdforest")) = pcm_land(j,"primforest") + pcm_land(j,"secdforest");
p22_min_other(t,j)$(p22_min_other(t,j) > pcm_land(j,"other")) = pcm_land(j,"other");
