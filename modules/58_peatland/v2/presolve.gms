*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


if (m_year(t) <= s58_fix_peatland,  
* For initialization, degraded peatland is estimated by multiplication of managed land (cropland, pasture, forestry) with the peatland scaling factor (p58_scaling_factor) 
* and simultaneously constrained by observed degraded peatland area (f58_peatland_area).
  p58_scaling_factor(j)$(sum(land, pcm_land(j,land)) > 1e-20) = sum(land58, f58_peatland_area(j,land58)) / sum(land, pcm_land(j,land));
  p58_calib_factor(j,"crop")$(pcm_land(j,"crop") * p58_scaling_factor(j) > 1e-20) = f58_peatland_area(j,"crop") / (pcm_land(j,"crop") * p58_scaling_factor(j));
  p58_calib_factor(j,"past")$(pcm_land(j,"past") * p58_scaling_factor(j) > 1e-20) = f58_peatland_area(j,"past") / (pcm_land(j,"past") * p58_scaling_factor(j));
  p58_calib_factor(j,"forestry")$(pcm_land_forestry(j,"plant") * p58_scaling_factor(j) > 1e-20) = f58_peatland_area(j,"forestry") / (pcm_land_forestry(j,"plant") * p58_scaling_factor(j));
*  pc58_peatland(j,"crop") = min(f58_peatland_area(j,"crop"),pcm_land(j,"crop") * p58_scaling_factor(j));
*  pc58_peatland(j,"past") = min(f58_peatland_area(j,"past"), pcm_land(j,"past") * p58_scaling_factor(j));
*  pc58_peatland(j,"forestry") = min(f58_peatland_area(j,"forestry"), pcm_land_forestry(j,"plant") * p58_scaling_factor(j));
  pc58_peatland(j,"crop") = f58_peatland_area(j,"crop");
  pc58_peatland(j,"past") = f58_peatland_area(j,"past");
  pc58_peatland(j,"forestry") = f58_peatland_area(j,"forestry");
  pc58_peatland(j,"unused") = 0;
* The residual is added to an "unused" category, which represents degraded but unused peatland.
*  pc58_peatland(j,"unused") = sum(landDrainedUsed58, f58_peatland_area(j,landDrainedUsed58) - pc58_peatland(j,landDrainedUsed58));
* Area used for peat extraction 
  pc58_peatland(j,"peatExtract") = f58_peatland_area(j,"peatExtract");
* Intact peatland area
  pc58_peatland(j,"intact") = f58_peatland_area(j,"intact");

* Peatland area is fixed to `pc58_peatland` until the year given by s58_fix_peatland 
  v58_peatland.fx(j,land58) = pc58_peatland(j,land58);
  i58_cost_rewet_recur(t) = 0;
  i58_cost_rewet_onetime(t) = 0;
  i58_cost_degrad_recur(t) = 0;
  i58_cost_degrad_onetime(t) = 0;
else
* Define bounds and costs for peatland area after the year given by s58_fix_peatland 
  v58_peatland.lo(j,land58) = 0;
  v58_peatland.l(j,land58) = pc58_peatland(j,land58);
  v58_peatland.up(j,landDrained58) = Inf;
  v58_peatland.up(j,"rewetted") = s58_rewetting_switch;
  v58_peatland.up(j,"intact") = pc58_peatland(j,"intact");
  v58_peatland.fx(j,"peatExtract") = pc58_peatland(j,"peatExtract");
  i58_cost_rewet_recur(t) = s58_cost_rewet_recur;
  i58_cost_rewet_onetime(t) = s58_cost_rewet_onetime;
  i58_cost_degrad_recur(t) = s58_cost_degrad_recur;
  i58_cost_degrad_onetime(t) = s58_cost_degrad_onetime;
);
