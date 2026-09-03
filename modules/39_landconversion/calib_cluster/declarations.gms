*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
 q39_cost_landcon(j,land)              Calculation of cellular landconversion costs (mio. USD17MER per yr)
;

variables
 vm_cost_landcon(j,land)               Costs for land expansion and reduction (mio. USD17MER per yr)
;

parameters
* ---- Regional calibration factors -------------------------------------------
 i39_calib(t,i,type39)                 Regional calibration factor for cropland expansion costs (1)
 i39_calib_past(t,i,type39)            Regional calibration factor for pasture expansion costs (1)

* ---- Regional cost parameters (non-selected countries) ----------------------
 i39_cost_establish(t,i,land)          Land expansion costs at regional level (USD17MER per hectare)
 i39_reward_reduction(t,i,land)        Reward for land reduction at regional level (USD17MER per hectare)

* ---- Cluster-level calibration factors (selected countries) -----------------
 i39_calib_cluster(t,j,type39)         Cluster-level calibration factor for cropland expansion costs (1)
 i39_calib_past_cluster(t,j,type39)    Cluster-level calibration factor for pasture expansion costs (1)

* ---- Unified cluster-level cost parameters (all clusters, all land types) ---
 i39_cost_establish_j(t,j,land)        Land expansion costs at cluster level (USD17MER per hectare)
 i39_reward_reduction_j(t,j,land)      Reward for land reduction at cluster level (USD17MER per hectare)

* ---- Country / cluster selection --------------------------------------------
 p39_country_switch(iso)               Binary switch: 1 = cluster-level calibration active for this country (1)
 p39_cell_switch(j)                    Binary switch: 1 = cluster-level calibration active for this cluster (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_landcon(t,j,land,type)   Costs for land expansion and reduction (mio. USD17MER per yr)
 oq39_cost_landcon(t,j,land,type) Calculation of cellular landconversion costs (mio. USD17MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
