*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* ==================
* Land conservation
* ==================

* Define natural vegetation conservation options based on
* remaining natural vegation in current time step

* Include all remaining primary forest areas in IFL conservation target
p22_add_consv(t,j,"IFL","primforest") = pcm_land(j,"primforest") * p22_conservation_fader(t);
p22_add_consv(t,j,"BH_IFL","primforest") = pcm_land(j,"primforest") * p22_conservation_fader(t);


if(m_year(t) <= sm_fix_SSP2,
* from 1995 to 2020 land conservation is based on
* historic trends as derived from WDPA
 p22_conservation_area(t,j,land) = sum(cell(i,j),
      p22_wdpa_baseline(t,j,"%c22_base_protect%",land) * p22_country_weight(i)
      + p22_wdpa_baseline(t,j,"%c22_base_protect_noselect%",land) * (1-p22_country_weight(i))
      );

else

** Future land conservation only pertains to natural vegetation classes (land_natveg)
p22_conservation_area(t,j,land) = sum(cell(i,j),
      p22_wdpa_baseline(t,j,"%c22_base_protect%",land) * p22_country_weight(i)
      + p22_wdpa_baseline(t,j,"%c22_base_protect_noselect%",land) * (1-p22_country_weight(i))
      );
* future options for land conservation are added to the WDPA baseline
p22_conservation_area(t,j,land_natveg) =
    sum(cell(i,j),
      p22_wdpa_baseline(t,j,"%c22_base_protect%",land_natveg) * p22_country_weight(i)
      + p22_wdpa_baseline(t,j,"%c22_base_protect_noselect%",land_natveg) * (1-p22_country_weight(i))
      )
    + sum(cell(i,j),
      p22_add_consv(t,j,"%c22_protect_scenario%",land_natveg) * p22_country_weight(i)
      + p22_add_consv(t,j,"%c22_protect_scenario_noselect%",land_natveg) * (1-p22_country_weight(i))
      );
);

* -----------------------
* Protect remaining land
* -----------------------

* Note: protected area reported in the WDPA baseline data can be higher
* than what is reported in the LUH2v2 data.
pm_land_conservation(t,j,land,"protect") = p22_conservation_area(t,j,land);
pm_land_conservation(t,j,land,"protect")$(pm_land_conservation(t,j,land,"protect") > pcm_land(j,land)) = pcm_land(j,land);


* -------------------
* Land restoration
* -------------------

if(s22_restore_land = 1 OR m_year(t) <= sm_fix_SSP2,

** Calculate restoration targets
* Grassland
pm_land_conservation(t,j,"past","restore")$(p22_conservation_area(t,j,"past") > pcm_land(j,"past")) =
        p22_conservation_area(t,j,"past") - pcm_land(j,"past");
* Forest land
* Total forest restoration requirements are attributed to
* secdforest, as primforest cannot be restored by definition
pm_land_conservation(t,j,"secdforest","restore") =
        (p22_conservation_area(t,j,"primforest") + p22_conservation_area(t,j,"secdforest"))
        - (pcm_land(j,"primforest") + pcm_land(j,"secdforest"));
pm_land_conservation(t,j,"secdforest","restore")$(pm_land_conservation(t,j,"secdforest","restore") < 1e-6) = 0;
* Other land
pm_land_conservation(t,j,"other","restore")$(p22_conservation_area(t,j,"other") > pcm_land(j,"other")) =
        p22_conservation_area(t,j,"other") - pcm_land(j,"other");

* Adjust forest, grassland and other land restoration depending on given land available for restoration (restoration potential)

* Secondary forest restoration is limited by secondary forest restoration potential
p22_secdforest_restore_pot(t,j) = sum(land, pcm_land(j, land))
                - pcm_land(j, "urban")
                - sum(land_timber, pcm_land(j, land_timber))
                - pm_land_conservation(t,j,"past","protect")
                - vm_land.lo(j,"crop")
                - vm_treecover.l(j);
p22_secdforest_restore_pot(t,j)$(p22_secdforest_restore_pot(t,j) < 1e-6) = 0;
pm_land_conservation(t,j,"secdforest","restore")$(pm_land_conservation(t,j,"secdforest","restore") > p22_secdforest_restore_pot(t,j)) = p22_secdforest_restore_pot(t,j);

* Grassland restoration is limited by grassland restoration potential
p22_past_restore_pot(t,j) = sum(land, pcm_land(j, land))
              - pcm_land(j, "urban")
              - sum(land_timber, pcm_land(j, land_timber))
              - pm_land_conservation(t,j,"past","protect")
              - pm_land_conservation(t,j,"secdforest","restore")
              - vm_land.lo(j,"crop")
              - vm_treecover.l(j);
p22_past_restore_pot(t,j)$(p22_past_restore_pot(t,j) < 1e-6) = 0;
pm_land_conservation(t,j,"past","restore")$(pm_land_conservation(t,j,"past","restore") > p22_past_restore_pot(t,j)) = p22_past_restore_pot(t,j);

* Other land restoration is limited by other land restoration potential
p22_other_restore_pot(t,j) = sum(land, pcm_land(j, land))
               - pcm_land(j, "urban")
               - sum(land_timber, pcm_land(j, land_timber))
               - sum(consv_type, pm_land_conservation(t,j,"past",consv_type))
               - pm_land_conservation(t,j,"secdforest","restore")
               - vm_land.lo(j,"crop")
               - vm_treecover.l(j);
p22_other_restore_pot(t,j)$(p22_other_restore_pot(t,j) < 1e-6) = 0;
pm_land_conservation(t,j,"other","restore")$(pm_land_conservation(t,j,"other","restore") > p22_other_restore_pot(t,j)) = p22_other_restore_pot(t,j);

else

* set restoration to zero
pm_land_conservation(t,j,land,"restore") = 0;

);


