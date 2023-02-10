*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


* SOM pools and densities will be updated after natural regrowth and disturbance loss accounting.
* The secondary forest pool will receive carbon from primary forest (due to natural disturbance)
* and from other land (due to regrowth).
* Note: This will only account for transitions of primary forest to secondary forest and
* other land to secondary forest. See current version of 35_natveg to check consistency.

p59_som_pool(j,"secdforest") = p59_som_pool(j,"secdforest") +
                               (p59_land_before(j,"primforest") - pcm_land(j,"primforest")) *
                                                p59_carbon_density(t-1,j,"primforest") +
                               (p59_land_before(j,"other") - pcm_land(j,"other")) *
                                                p59_carbon_density(t-1,j,"other");

p59_som_pool(j,"other") = p59_som_pool(j,"other") -
                          (p59_land_before(j,"other") - pcm_land(j,"other")) *
                                             p59_carbon_density(t-1,j,"other");

p59_som_pool(j,"primforest") = p59_som_pool(j,"primforest") -
                               (p59_land_before(j,"primforest") - pcm_land(j,"primforest")) *
                                                p59_carbon_density(t-1,j,"primforest");

p59_carbon_density(t,j,land)$(pcm_land(j,land)>1e-40) = p59_som_pool(j,land) / pcm_land(j,land);
