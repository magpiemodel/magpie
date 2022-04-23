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
 p22_conservation_area(t,j,land) = f22_wdpa_baseline(t,j,land);

else

** Future land conservation only pertains to natural vegetation classes (land_natveg)

$ifthen "%c22_protect_scenario%" == "HalfEarth"
p22_conservation_area(t,j,land) = f22_wdpa_baseline(t,j,land);
* WDPA data is already included in the HalfEarth data set
* therefore the approach slightly deviates
p22_conservation_area(t,j,land_natveg) =
		pm_land_start(j,land_natveg)
	  		* sum(cell(i,j),
			  p22_consv_shr(t,j,"HalfEarth",land_natveg) * p22_country_weight(i)
	  		+ p22_consv_shr(t,j,"%c22_protect_scenario_noselect%",land_natveg) * (1-p22_country_weight(i))
	  		  );
* make sure that area covered by WDPA data is included in areas where the HalfEarth data reports less
p22_conservation_area(t,j,land_natveg)$(p22_conservation_area(t,j,land_natveg) < f22_wdpa_baseline(t,j,land_natveg)) = f22_wdpa_baseline(t,j,land_natveg);
$else
p22_conservation_area(t,j,land) = f22_wdpa_baseline(t,j,land);
* future options for land conservation are added to the WDPA baseline
p22_conservation_area(t,j,land_natveg) =
		f22_wdpa_baseline(t,j,land_natveg)
	  + pm_land_start(j,land_natveg)
	  		* sum(cell(i,j),
			  p22_consv_shr(t,j,"%c22_protect_scenario%",land_natveg) * p22_country_weight(i)
			+ p22_consv_shr(t,j,"%c22_protect_scenario_noselect%",land_natveg) * (1-p22_country_weight(i))
			  );
$endif

);

** Protect remaining land
* Note: protected area reported in the WDPA baseline data can be higher
* than what is reported in the LUH2v2 data.
pm_land_conservation(t,j,land,"protect") = p22_conservation_area(t,j,land);
pm_land_conservation(t,j,land,"protect")$(pm_land_conservation(t,j,land,"protect") > pcm_land(j,land)) = pcm_land(j,land);


** Land restoration

pm_land_conservation(t,j,land,"restore") = 0;

if(s22_restore_land=1,

pm_land_conservation(t,j,"past","restore") =
			  p22_conservation_area(t,j,"past")$(p22_conservation_area(t,j,"past") > pcm_land(j,"past"))
			- pcm_land(j,"past")$(p22_conservation_area(t,j,"past") > pcm_land(j,"past"));

pm_land_conservation(t,j,"secdforest","restore") =
			  p22_conservation_area(t,j,"secdforest")$(p22_conservation_area(t,j,"secdforest") > pcm_land(j,"secdforest"))
			- pcm_land(j,"secdforest")$(p22_conservation_area(t,j,"secdforest") > pcm_land(j,"secdforest"));

pm_land_conservation(t,j,"other","restore") =
			  p22_conservation_area(t,j,"other")$(p22_conservation_area(t,j,"other") > pcm_land(j,"other"))
			- pcm_land(j,"other")$(p22_conservation_area(t,j,"other") > pcm_land(j,"other"));
* Primary and secondary forest cannot be converted to other land. Therefore
* other land restoration is contrained by the the remaining agricultural land:
p22_other_restore_pot(t,j) = (vm_land.l(j,"crop") - vm_land.lo(j,"crop")) + (vm_land.l(j,"past") - p22_conservation_area(t,j,"past"));
p22_other_restore_pot(t,j)$(p22_other_restore_pot(t,j) < 0) = 0;
* other land restoration is limited by other land restoration potential
pm_land_conservation(t,j,"other","restore")$(pm_land_conservation(t,j,"other","restore") > p22_other_restore_pot(t,j)) = p22_other_restore_pot(t,j);

);

* NPI/NDC
p22_min_forest(t,j)$(p22_min_forest(t,j) > pcm_land(j,"primforest") + pcm_land(j,"secdforest")) = pcm_land(j,"primforest") + pcm_land(j,"secdforest");
p22_min_other(t,j)$(p22_min_other(t,j) > pcm_land(j,"other")) = pcm_land(j,"other");
