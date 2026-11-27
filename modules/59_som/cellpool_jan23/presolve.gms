*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
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

pc59_som_pool(j,"secdforest") = pc59_som_pool(j,"secdforest") +
                               (pc59_land_before(j,"primforest") - pcm_land(j,"primforest")) *
                                                pc59_carbon_density(j,"primforest") +
                               (pc59_land_before(j,"other") - pcm_land(j,"other")) *
                                                pc59_carbon_density(j,"other");

pc59_som_pool(j,"other") = pc59_som_pool(j,"other") -
                          (pc59_land_before(j,"other") - pcm_land(j,"other")) *
                                             pc59_carbon_density(j,"other");

pc59_som_pool(j,"primforest") = pc59_som_pool(j,"primforest") -
                               (pc59_land_before(j,"primforest") - pcm_land(j,"primforest")) *
                                                pc59_carbon_density(j,"primforest");

p59_carbon_density(t,j,land)$(pcm_land(j,land) > 1e-10) = pc59_som_pool(j,land) / pcm_land(j,land);

* soil carbon management (SCM), two modes selected by s59_scm_mode
if (s59_scm_mode = 0,
* share mode: create soil carbon management target scenario as a
* share of each cell's cropland area, applied to cropareas and fallow land
  i59_scm_target(t,j) = i59_scm_scenario_fader(t) * 
    (s59_scm_target * sum(cell(i,j), p59_country_weight(i))
    + s59_scm_target_noselect * sum(cell(i,j), 1-p59_country_weight(i)));
else
* area mode: convert share target to absolute area target at regional level
* and allocate SCM area endogenously, also on fallow land
* Mode selection for the reference area:
*   s59_scm_reference_year = -1: Use previous timestep total cropland area (dynamic mode)
*   s59_scm_reference_year > 0:  Use fixed reference year total cropland area (fixed year mode)
* Reference area is total cropland including fallow and treecover (consistent with
* treecover target, avoids perverse incentive)
* The reference year area for fixed year mode is stored in postsolve
  if (s59_scm_reference_year <= 0,
    i59_scm_target_area(t,i) = i59_scm_scenario_fader(t) *
      (s59_scm_target * p59_country_weight(i) * sum(cell(i,j), pcm_land(j,"crop"))
      + s59_scm_target_noselect * (1-p59_country_weight(i)) * sum(cell(i,j), pcm_land(j,"crop")));
  else
    i59_scm_target_area(t,i) = i59_scm_scenario_fader(t) *
      (s59_scm_target * p59_country_weight(i) * sum(cell(i,j), p59_land_scm_reference(j))
      + s59_scm_target_noselect * (1-p59_country_weight(i)) * sum(cell(i,j), p59_land_scm_reference(j)));
  );
* SCM on cropareas is applied only on annual crops (kscm59) - not perennials or rice
* SCM practices (cover crops, reduced tillage) are not compatible with perennial crops or flooded rice
  v59_area_scm.fx(j,knoscm59,w,"scm") = 0;
);
