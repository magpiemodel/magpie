*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' Land conversion costs are computed in four steps:
*'
*' Step 1 derives regional cost parameters for crop and pasture using their
*' independent calibration factors, and sets static global costs for forestry
*' and urban land types.
*'
*' Step 2 populates the unified cluster-level parameters `i39_cost_establish_j`
*' and `i39_reward_reduction_j` for ALL clusters and ALL land types from the
*' regional values. This provides correct costs for non-selected countries and
*' acts as the baseline for the overrides in steps 3 and 4.
*'
*' Step 3 overrides the cropland cluster-level parameters for clusters in
*' selected countries (p39_cell_switch=1) using the cluster-specific cropland
*' calibration factor `i39_calib_cluster`.
*'
*' Step 4 overrides the pasture cluster-level parameters for clusters in
*' selected countries using the cluster-specific pasture calibration factor
*' `i39_calib_past_cluster`.

* --- Step 1: Regional cost parameters ----------------------------------------

* Cropland (calibrated independently)
i39_cost_establish(t,i,"crop")    = s39_cost_establish_crop    * i39_calib(t,i,"cost");
i39_reward_reduction(t,i,"crop")  = s39_reward_crop_reduction  * i39_calib(t,i,"reward");

* Pasture (calibrated independently)
i39_cost_establish(t,i,"past")    = s39_cost_establish_past    * i39_calib_past(t,i,"cost");
i39_reward_reduction(t,i,"past")  = s39_reward_past_reduction  * i39_calib_past(t,i,"reward");

* Non-calibrated land types
i39_cost_establish(t,i,"forestry") = s39_cost_establish_forestry;
i39_cost_establish(t,i,"urban")    = s39_cost_establish_urban;

* --- Step 2: Populate cluster-level parameters for ALL clusters ---------------

i39_cost_establish_j(t,j,"crop")     = sum(cell(i,j), i39_cost_establish(t,i,"crop"));
i39_reward_reduction_j(t,j,"crop")   = sum(cell(i,j), i39_reward_reduction(t,i,"crop"));
i39_cost_establish_j(t,j,"past")     = sum(cell(i,j), i39_cost_establish(t,i,"past"));
i39_reward_reduction_j(t,j,"past")   = sum(cell(i,j), i39_reward_reduction(t,i,"past"));
i39_cost_establish_j(t,j,"forestry") = s39_cost_establish_forestry;
i39_cost_establish_j(t,j,"urban")    = s39_cost_establish_urban;

* --- Step 3: Override cropland costs for selected clusters -------------------

i39_cost_establish_j(t,j,"crop")$p39_cell_switch(j) =
  s39_cost_establish_crop * i39_calib_cluster(t,j,"cost");
i39_reward_reduction_j(t,j,"crop")$p39_cell_switch(j) =
  s39_reward_crop_reduction * i39_calib_cluster(t,j,"reward");

* --- Step 4: Override pasture costs for selected clusters --------------------

i39_cost_establish_j(t,j,"past")$p39_cell_switch(j) =
  s39_cost_establish_past * i39_calib_past_cluster(t,j,"cost");
i39_reward_reduction_j(t,j,"past")$p39_cell_switch(j) =
  s39_reward_past_reduction * i39_calib_past_cluster(t,j,"reward");
