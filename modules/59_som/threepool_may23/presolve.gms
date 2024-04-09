*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* For the first time steps:
* Initializating of SOC pools in the different land types using the input from mrsoil

* For all other time steps:
* SOM pools and densities will be updated after natural regrowth and disturbance loss accounting.
* The secondary forest pool will receive carbon from primary forest (due to natural disturbance)
* and from other land (due to regrowth).
* Note: This will only account for transitions of primary forest to secondary forest and
* other land to secondary forest. See current version of 35_natveg to check consistency.
* The helper parameter `p59_topsoilc_actualstate` is used  to update `p59_topsoilc_density_pre`

if((ord(t) = 1),

  p59_topsoilc_density_pre("y1995", i, land, sPools59) =
    sum(lutypes59_land(land, lutypes59),
      f59_topsoilc_actualstate(i, "actualstate", sPools59, lutypes59)  /
        sum((cell(i,j), lutypes59_land2(land2,lutypes59)), pm_land_start(j, land2)));

  p59_topsoilc_density_post(t, i, land, sPools59) = 0

else

  p59_topsoilc_actualstate(i, "secdforest", sPools59) = 
    p59_topsoilc_actualstate(i, "secdforest", sPools59) + 
    sum(cell(i,j), p59_land_before(j, "primforest") - pcm_land(j, "primforest")) *
      p59_topsoilc_density_post(t-1, i, "primforest", sPools59) + 
    sum(cell(i,j), p59_land_before(j, "other") - pcm_land(j, "other")) *
      p59_topsoilc_density_post(t-1, i, "other", sPools59);

  p59_topsoilc_actualstate(i, "other", sPools59) = 
    p59_topsoilc_actualstate(i, "other", sPools59) - 
    sum(cell(i,j), p59_land_before(j, "other") - pcm_land(j, "other")) *
      p59_topsoilc_density_post(t-1, i, "other", sPools59);

  p59_topsoilc_actualstate(i, "primforest", sPools59) = 
    p59_topsoilc_actualstate(i, "primforest", sPools59) - 
    sum(cell(i,j), p59_land_before(j, "primforest") - pcm_land(j, "primforest")) *
      p59_topsoilc_density_post(t-1, i, "primforest", sPools59);

  p59_topsoilc_density_pre(t, i, land, sPools59)$(sum(cell(i,j), pcm_land(j,land)) > 1e-20) =
    p59_topsoilc_actualstate(i, land, sPools59) / sum(cell(i,j), pcm_land(j,land));

);
