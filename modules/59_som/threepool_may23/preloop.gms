*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*****************************
*** SOC initialisation    ***
*****************************

i59_subsoilc_density(t_all, j) = 
  fm_carbon_density(t_all, j, "secdforest", "soilc") - f59_topsoilc_density(t_all, j);

p59_topsoilc_density(t_all, i, land, soilPools59) = 1;  
p59_topsoilc_actualstate(i, land, soilPools59) = 
  p59_topsoilc_density("y1995", i, land, soilPools59) * sum(cell(i,j), pm_land_start(j, land));

vm_carbon_stock.l(j, land, "soilc", stockType) =
  fm_carbon_density("y1995", j, land, "soilc") * pm_land_start(j, land);

p59_land_before(j,land) = pm_land_start(j,land);

*****************************
*** parameter dummies     ***
*****************************

i59_litter_recycling(t, i) = 5;

* i59_cinput_multiplier(t, i, cSource59, tillage59, w, soilPools59) -> fill with input
i59_cinput_multiplier(t, i, cSource59, tillage59, w, "active")  = 0.46;
i59_cinput_multiplier(t, i, cSource59, tillage59, w, "slow")    = 0.26;
i59_cinput_multiplier(t, i, cSource59, tillage59, w, "passive") = 0.05;

* i59_topsoilc_decay(t, i, tillage59, w, soilPools59) -> fill with input
i59_topsoilc_decay(t, i, tillage59, "irrigated", "active")       = 3.4;
i59_topsoilc_decay(t, i, tillage59, "rainfed", "active")         = 1.9;
i59_topsoilc_decay(t, i, "full_tillage", "irrigated", "active")  = 8.7;
i59_topsoilc_decay(t, i, "full_tillage", "rainfed", "active")    = 4.2;

i59_topsoilc_decay(t, i, tillage59, "irrigated", "slow")         = 0.15;
i59_topsoilc_decay(t, i, tillage59, "rainfed", "slow")           = 0.08;
i59_topsoilc_decay(t, i, "full_tillage", "irrigated", "slow")    = 0.41;
i59_topsoilc_decay(t, i, "full_tillage", "rainfed", "slow")      = 0.20;

i59_topsoilc_decay(t, i, tillage59, "irrigated", "passive")      = 0.005;
i59_topsoilc_decay(t, i, tillage59, "rainfed", "passive")        = 0.003;

i59_topsoilc_decay_max1(t, i, tillage59, w, soilPools59) = 
  min(1, i59_topsoilc_decay(t, i, tillage59, w, soilPools59)); 
