*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


if (m_year(t) <= s58_fix_peatland,  
* Initialization of peatland area. Drained and used peatland area cannot exceed the corresponding managed area
  pc58_peatland(j,"crop") = min(f58_peatland_area(j,"crop"),pcm_land(j,"crop"));
  pc58_peatland(j,"past") = min(f58_peatland_area(j,"past"), pcm_land(j,"past"));
  pc58_peatland(j,"forestry") = min(f58_peatland_area(j,"forestry"), pcm_land_forestry(j,"plant"));
* The residual is added to an "unused" category, which represents drained but unused peatland.
  pc58_peatland(j,"unused") = sum(landDrainedUsed58, f58_peatland_area(j,landDrainedUsed58) - pc58_peatland(j,landDrainedUsed58));
* Area used for peat extraction 
  pc58_peatland(j,"peatExtract") = f58_peatland_area(j,"peatExtract");
* Intact peatland area
  pc58_peatland(j,"intact") = f58_peatland_area(j,"intact");

* Peatland scaling factor for estimating future peatland dynamics
* The peatland scaling factor for cells with drained peatland area depends on the ratio of drained peatland and managed land (remains fixed after s58_fix_peatland)
  p58_scaling_factor(j,landDrainedUsed58) = 0;
  p58_scaling_factor(j,"crop")$(pcm_land(j,"crop") > 1e-20) = pc58_peatland(j,"crop") / pcm_land(j,"crop");
  p58_scaling_factor(j,"past")$(pcm_land(j,"past") > 1e-20) = pc58_peatland(j,"past") / pcm_land(j,"past");
  p58_scaling_factor(j,"forestry")$(pcm_land_forestry(j,"plant") > 1e-20) = pc58_peatland(j,"forestry") / pcm_land_forestry(j,"plant");
* The peatland scaling factor for cells without drained peatland area depends on the ratio of total peatland area and total land area (remains fixed after s58_fix_peatland).
  p58_scaling_factor(j,landDrainedUsed58)$(pc58_peatland(j,landDrainedUsed58) = 0) = sum(land58, f58_peatland_area(j,land58)) / sum(land, pcm_land(j,land));

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
