*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


if (m_year(t) <= s58_fix_peatland,  
* Managed land area
  pc58_manLand(j,manPeat58) = m58_LandMerge(pcm_land,pcm_land_forestry,"j");

* Initialization of peatland area. Drained and used peatland area cannot exceed the corresponding managed area
  pc58_peatland(j,manPeat58) = min(f58_peatland_area(j,manPeat58),pc58_manLand(j,manPeat58));
* The residual is added to an "unused" category, which represents drained but unused peatland.
  pc58_peatland(j,"unused") = sum(manPeat58, f58_peatland_area(j,manPeat58) - pc58_peatland(j,manPeat58));
* Area used for peat extraction 
  pc58_peatland(j,"peatExtract") = f58_peatland_area(j,"peatExtract");
* Intact peatland area
  pc58_peatland(j,"intact") = f58_peatland_area(j,"intact");

* Peatland area is fixed to `pc58_peatland` until the year given by s58_fix_peatland 
  v58_peatland.fx(j,land58) = pc58_peatland(j,land58);
  v58_balance.fx(j,manPeat58) = 0;
  v58_balance2.fx(j,manPeat58) = 0;

  i58_cost_rewet_recur(t) = 0;
  i58_cost_drain_recur(t) = 0;
  i58_cost_drain_intact_onetime(t) = 0;
  i58_cost_drain_rewet_onetime(t) = 0;
  i58_cost_rewet_onetime(t) = 0;
else
* Define bounds and costs for peatland area after the year given by s58_fix_peatland 
  v58_peatland.lo(j,land58) = 0;
  v58_peatland.l(j,land58) = pc58_peatland(j,land58);
  v58_peatland.up(j,drained58) = Inf;
  v58_peatland.up(j,"rewetted") = s58_rewetting_switch;
  v58_peatland.up(j,"intact") = pc58_peatland(j,"intact");
  v58_peatland.fx(j,"peatExtract") = pc58_peatland(j,"peatExtract");
  v58_balance.lo(j,manPeat58) = 0;
  v58_balance.up(j,manPeat58) = Inf;
  v58_balance2.lo(j,manPeat58) = 0;
  v58_balance2.up(j,manPeat58) = Inf;

  i58_cost_rewet_recur(t) = s58_cost_rewet_recur;
  i58_cost_drain_recur(t) = s58_cost_drain_recur;
  i58_cost_drain_intact_onetime(t) = s58_cost_drain_intact_onetime;
  i58_cost_drain_rewet_onetime(t) = s58_cost_drain_rewet_onetime;
  i58_cost_rewet_onetime(t) = s58_cost_rewet_onetime;
);

*' @code
*' Peatland scaling factor for expansion: (totalPeatland - manPeatland) / (totalLand - manLand) 
*' 
*'   * p58_availPeatlandExp = totalPeatland - manPeatland
*'   * p58_availLandExp = totalLand - manLand

p58_availPeatlandExp(t,j) = sum(land58, pc58_peatland(j,land58)) - sum(manPeat58, pc58_peatland(j,manPeat58));
p58_availLandExp(t,j) = sum(land, pcm_land(j,land)) - sum(manPeat58, pc58_manLand(j,manPeat58));

p58_scalingFactorExp(t,j) = 
    (p58_availPeatlandExp(t,j) / p58_availLandExp(t,j))
    $(p58_availPeatlandExp(t,j) > 1e-4 AND p58_availLandExp(t,j) > 1e-4)
    + 0$(p58_availPeatlandExp(t,j) <= 1e-4 OR p58_availLandExp(t,j) <= 1e-4);
p58_scalingFactorExp(t,j)$(p58_scalingFactorExp(t,j) > 1) = 1; 

*' Peatland scaling factor for reduction: manPeatland / totalPeatland

p58_scalingFactorRed(t,j,manPeat58) = 
    (pc58_peatland(j,manPeat58) / sum(land58, pc58_peatland(j,land58)))
    $(pc58_peatland(j,manPeat58) > 1e-4 AND sum(land58, pc58_peatland(j,land58)) > 1e-4)
    + 0$(pc58_peatland(j,manPeat58) <= 1e-4 OR sum(land58, pc58_peatland(j,land58)) <= 1e-4);
p58_scalingFactorRed(t,j,manPeat58)$(p58_scalingFactorRed(t,j,manPeat58) > 1) = 1; 

*' @stop
