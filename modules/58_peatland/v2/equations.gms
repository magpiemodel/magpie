*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Constraint for constant total peatland area over time:

 q58_peatland(j2) ..
  sum(land58, v58_peatland(j2,land58)) =e= sum(land58, pc58_peatland(j2,land58));

*' Peatland area change:

 q58_peatlandChange(j2,land58) ..
  v58_peatlandChange(j2,land58) =e= v58_peatland(j2,land58)-pc58_peatland(j2,land58);
 
*' Managed land area:

 q58_manLand(j2,manPeat58) ..
  v58_manLand(j2,manPeat58) =e= m58_LandMerge(vm_land,vm_land_forestry,"j2");

*' Managed land area expansion and reduction:

 q58_manLandExp(j2,manPeat58) ..
  v58_manLandExp(j2,manPeat58) =e= m58_LandMerge(vm_landexpansion,vm_landexpansion_forestry,"j2");

 q58_manLandRed(j2,manPeat58) ..
  v58_manLandRed(j2,manPeat58) =e= m58_LandMerge(vm_landreduction,vm_landreduction_forestry,"j2");

*' Future peatland dynamics (`v58_peatland`) for drained peatlands used as cropland, pasture or forestry (`manPeat58`) 
*' depend on changes in managed agricultural and forestry land (`v58_manLandExp`, `v58_manLandRed`), 
*' multiplied with corresponding scaling factors for expansion (`p58_scalingFactorExp`) and reduction (`p58_scalingFactorRed`). 
*' Both scaling factors are time-dynamic, i.e. the scaling factors vary depending on changes in drained peatland and managed land.
*' The scaling factor for expansion reflects the ratio of available area for peatland drainage and managed land expansion, 
*' based on the assumption that the expansion of drained peatland is proportional to the expansion of managed land.
*' The scaling factor for reduction reflects the ratio of drained peatland and total peatland area, 
*' based on the assumption that the likelihood of peatland rewetting increases with a higher share of 
*' drained peatland over total peatland area. 
*' Therefore, the scaling factor for peatland reduction increases with an increasing share of drained peatland 
*' and decreases with a decreasing share of drained peatland. 
*' In case managed land remains unchanged, also drained peatland remains unchanged. 

 q58_peatlandMan(j2,manPeat58)$(sum(ct, m_year(ct)) > s58_fix_peatland) ..
  v58_peatland(j2,manPeat58) =e= 
    pc58_peatland(j2,manPeat58) 
    + v58_manLandExp(j2,manPeat58) * sum(ct, p58_scalingFactorExp(ct,j2)) - v58_balance(j2,manPeat58)
    - v58_manLandRed(j2,manPeat58) * sum(ct, p58_scalingFactorRed(ct,j2,manPeat58)) + v58_balance2(j2,manPeat58);

*' Drained peatland used for agriculture and forestry cannot exceed corresponding managed land.

 q58_peatlandMan2(j2,manPeat58)$(sum(ct, m_year(ct)) > s58_fix_peatland) ..
  v58_peatland(j2,manPeat58) =l= v58_manLand(j2,manPeat58);

*' Costs for peatland degradation and rewetting

 q58_peatland_cost(j2) ..
  vm_peatland_cost(j2) =e= sum(cost58, v58_peatland_cost_annuity(j2,cost58))
              + v58_peatland(j2,"rewetted") * sum(ct, i58_cost_rewet_recur(ct))
              + sum(manPeat58, v58_peatland(j2,manPeat58)) * sum(ct, i58_cost_drain_recur(ct))
              + sum(manPeat58, v58_balance(j2,manPeat58)+v58_balance2(j2,manPeat58)) * s58_balance_penalty;

 q58_peatland_cost_annuity(j2,cost58) ..
  v58_peatland_cost_annuity(j2,cost58) =g=
    (- v58_peatlandChange(j2,"intact") * sum(ct, i58_cost_drain_intact_onetime(ct)))$sameas(cost58,"drain_intact")
   + (- v58_peatlandChange(j2,"rewetted") * sum(ct, i58_cost_drain_rewet_onetime(ct)))$sameas(cost58,"drain_rewetted")
   + (v58_peatlandChange(j2,"rewetted") * sum(ct, i58_cost_rewet_onetime(ct)))$sameas(cost58,"rewet")
  * sum((cell(i2,j2),ct),pm_interest(ct,i2)/(1+pm_interest(ct,i2)));

*' Detailed peatland GHG emissions

 q58_peatland_emis_detail(j2,land58,emis58) ..
  v58_peatland_emis(j2,land58,emis58) =e=
  sum(clcl58, v58_peatland(j2,land58) *
  p58_mapping_cell_climate(j2,clcl58) * f58_ipcc_wetland_ef(clcl58,land58,emis58));

*' Aggregation of detailed peatland GHG emissions for interface `vm_emissions_reg`

 q58_peatland_emis(i2,poll58) ..
  vm_emissions_reg(i2,"peatland",poll58) =e=
  sum((cell(i2,j2),land58,emisSub58_to_poll58(emisSub58,poll58)),
    v58_peatland_emis(j2,land58,emisSub58));
