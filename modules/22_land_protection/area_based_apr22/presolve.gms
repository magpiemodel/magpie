*** |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* ------------------
* Land protection
* -----------------

if(m_year(t) <= sm_fix_SSP2,
* from 1995 to 2020 land protection is based on
* observed trends as derived from WDPA
 pm_land_protection(t,j,land) = f22_wdpa_baseline(t,j,land);

else

** future land protection only pertains to natural vegetation classes (land_natveg)

$ifthen "%c22_protect_scenario%" == "HalfEarth"
pm_land_protection(t,j,land) = f22_wdpa_baseline(t,j,land);
* WDPA data is already included in the HalfEarth data set
* therefore the approach slightly deviates
pm_land_protection(t,j,land_natveg) =
	pm_land_start(j,land_natveg) * sum(cell(i,j),
	p22_protect_shr(t,j,"HalfEarth",land_natveg) * p22_country_weight(i)
	+ p22_protect_shr(t,j,"%c22_protect_scenario_noselect%",land_natveg) * (1-p22_country_weight(i)));
* make sure that area covered by WDPA data is included in areas where the HalfEarth data reports less
	pm_land_protection(t,j,land_natveg)$(pm_land_protection(t,j,land_natveg) < f22_wdpa_baseline(t,j,land_natveg)) = f22_wdpa_baseline(t,j,land_natveg);
$else
pm_land_protection(t,j,land) = f22_wdpa_baseline(t,j,land);
* future options for land protection are added to the WDPA baseline
 pm_land_protection(t,j,land_natveg) = f22_wdpa_baseline(t,j,land_natveg) +
	pm_land_start(j,land_natveg) * sum(cell(i,j),
	p22_protect_shr(t,j,"%c22_protect_scenario%",land_natveg) * p22_country_weight(i)
	+ p22_protect_shr(t,j,"%c22_protect_scenario_noselect%",land_natveg) * (1-p22_country_weight(i)));
$endif

);

** Where land area under protection is reported higher than in the
** land initialisation data (based on LUH2v2) set area to remaining land area

* WDPA baseline
pm_land_protection(t,j,land)$(pm_land_protection(t,j,land) > pcm_land(j,land)) = pcm_land(j,land);

* NPI/NDC
p22_min_forest(t,j)$(p22_min_forest(t,j) > pcm_land(j,"primforest") + pcm_land(j,"secdforest")) = pcm_land(j,"primforest") + pcm_land(j,"secdforest");
p22_min_other(t,j)$(p22_min_other(t,j) > pcm_land(j,"other")) = pcm_land(j,"other");
