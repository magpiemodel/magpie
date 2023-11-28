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
  pc58_peatland(j,"forestry") = min(f58_peatland_area(j,"forestry"), pcm_land(j,"forestry"));
* The residual is added to an "unused" category, which represents drained but unused peatland.
  pc58_peatland(j,"unused") = sum(manPeat58, f58_peatland_area(j,manPeat58) - pc58_peatland(j,manPeat58));
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
  v58_peatland.up(j,drained58) = Inf;
  v58_peatland.up(j,"rewetted") = s58_rewetting_switch;
  v58_peatland.up(j,"intact") = pc58_peatland(j,"intact");
  v58_peatland.fx(j,"peatExtract") = pc58_peatland(j,"peatExtract");
  i58_cost_rewet_recur(t) = s58_cost_rewet_recur;
  i58_cost_rewet_onetime(t) = s58_cost_rewet_onetime;
  i58_cost_degrad_recur(t) = s58_cost_degrad_recur;
  i58_cost_degrad_onetime(t) = s58_cost_degrad_onetime;
);

* Peatland scaling factors for estimating future peatland dynamics; see macros for details.
p58_scaling_factor_exp(t,j) = m_peatland_scaling_factor_exp(pc58_peatland,pcm_land);
p58_scaling_factor_red(t,j) = m_peatland_scaling_factor_red(pc58_peatland,pcm_land);

* Peatland weight for distribution of total peatland changes to managed peatland categories
p58_weight(t,j,manPeat58)$(sum(manPeat58_alias, pc58_peatland(j,manPeat58_alias)) > 1e-10) = 
   pc58_peatland(j,manPeat58) / sum(manPeat58_alias, pc58_peatland(j,manPeat58_alias));
