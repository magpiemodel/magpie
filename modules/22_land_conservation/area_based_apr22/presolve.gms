*** |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* ------------------
* Land conservation
* -----------------

if(m_year(t) <= sm_fix_SSP2,
* from 1995 to 2020 land conservation is based on
* observed trends as derived from WDPA
 pm_land_conservation(t,j,land,"protect") = f22_wdpa_baseline(t,j,land);

else

** Future land conservation only pertains to natural vegetation classes (land_natveg)

$ifthen "%c22_protect_scenario%" == "HalfEarth"
pm_land_conservation(t,j,land,"protect") = f22_wdpa_baseline(t,j,land);
* WDPA data is already included in the HalfEarth data set
* therefore the approach slightly deviates
pm_land_conservation(t,j,land_natveg,"protect") =
		pm_land_start(j,land_natveg)
	  		* sum(cell(i,j),
			  p22_consv_shr(t,j,"HalfEarth",land_natveg) * p22_country_weight(i)
	  		+ p22_consv_shr(t,j,"%c22_protect_scenario_noselect%",land_natveg) * (1-p22_country_weight(i))
	  		  );
* make sure that area covered by WDPA data is included in areas where the HalfEarth data reports less
pm_land_conservation(t,j,land_natveg,"protect")$(pm_land_conservation(t,j,land_natveg,"protect") < f22_wdpa_baseline(t,j,land_natveg)) = f22_wdpa_baseline(t,j,land_natveg);
$else
pm_land_conservation(t,j,land,"protect") = f22_wdpa_baseline(t,j,land);
* future options for land conservation are added to the WDPA baseline
pm_land_conservation(t,j,land_natveg,"protect") =
		f22_wdpa_baseline(t,j,land_natveg)
	  + pm_land_start(j,land_natveg)
	  		* sum(cell(i,j),
			  p22_consv_shr(t,j,"%c22_protect_scenario%",land_natveg) * p22_country_weight(i)
			+ p22_consv_shr(t,j,"%c22_protect_scenario_noselect%",land_natveg) * (1-p22_country_weight(i))
			  );
$endif

);

** Land restoration

pm_land_conservation(t,j,land,"restore") = 0;

if(s22_restore_land=1,

pm_land_conservation(t,j,"secdforest","restore") =
			+ pm_land_conservation(t,j,"secdforest","protect")$(pm_land_conservation(t,j,"secdforest","protect") > pcm_land(j,"secdforest"))
			- pcm_land(j,"secdforest")$(pm_land_conservation(t,j,"secdforest","protect") > pcm_land(j,"secdforest"));

pm_land_conservation(t,j,"other","restore") =
			  pm_land_conservation(t,j,"other","protect")$(pm_land_conservation(t,j,"other","protect") > pcm_land(j,"other"))
			- pcm_land(j,"other")$(pm_land_conservation(t,j,"other","protect") > pcm_land(j,"other"));

pm_land_conservation(t,j,"past","restore") =
			  pm_land_conservation(t,j,"past","protect")$(pm_land_conservation(t,j,"past","protect") > pcm_land(j,"past"))
			- pcm_land(j,"past")$(pm_land_conservation(t,j,"past","protect") > pcm_land(j,"past"));

);

** Protect remaining land

* Note: protected area reported in the WDPA baseline data can be higher
* than what is reported in the LUH2v2 data.

* WDPA baseline
pm_land_conservation(t,j,land,"protect")$(pm_land_conservation(t,j,land,"protect") > pcm_land(j,land)) = pcm_land(j,land);

* NPI/NDC
p22_min_forest(t,j)$(p22_min_forest(t,j) > pcm_land(j,"primforest") + pcm_land(j,"secdforest")) = pcm_land(j,"primforest") + pcm_land(j,"secdforest");
p22_min_other(t,j)$(p22_min_other(t,j) > pcm_land(j,"other")) = pcm_land(j,"other");
