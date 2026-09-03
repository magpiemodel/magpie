*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The sum of costs for land expansion and land reduction is multiplied with
*' an annuity factor to distribute these costs over time.
*' Cluster-level parameters `i39_cost_establish_j` and `i39_reward_reduction_j`
*' are used directly, avoiding a region-to-cluster mapping inside the equation.
*' For clusters in selected countries these parameters reflect cluster-level
*' calibration for both cropland and pasture; for all other clusters they equal
*' the corresponding regional calibration values.

q39_cost_landcon(j2,land) .. vm_cost_landcon(j2,land) =e=
  (vm_landexpansion(j2,land) * sum(ct, i39_cost_establish_j(ct,j2,land))
  - vm_landreduction(j2,land) * sum(ct, i39_reward_reduction_j(ct,j2,land)))
  * sum((cell(i2,j2),ct), pm_interest(ct,i2)/(1+pm_interest(ct,i2)));
