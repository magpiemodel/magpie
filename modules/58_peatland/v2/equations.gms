*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
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
 
*' Managed land area expansion and reduction:

 q58_manLandExp(j2,manLand58) ..
  v58_manLandExp(j2,manLand58) =e= 
   vm_landexpansion(j2,"crop")$(sameas(manLand58,"crop"))
   + vm_landexpansion(j2,"past")$(sameas(manLand58,"past"))
   + vm_landexpansion_forestry(j2,"plant")$(sameas(manLand58,"forestry"));

 q58_manLandRed(j2,manLand58) ..
  v58_manLandRed(j2,manLand58) =e= 
   vm_landreduction(j2,"crop")$(sameas(manLand58,"crop"))
   + vm_landreduction(j2,"past")$(sameas(manLand58,"past"))
   + vm_landreduction_forestry(j2,"plant")$(sameas(manLand58,"forestry"));

*' Future peatland dynamics (`v58_peatland`) depend on changes in managed land (`v58_manLandExp`, `v58_manLandRed`), 
*' multiplied with corresponding scaling factors for expansion (`p58_scaling_factor_exp`) and reduction (`p58_scaling_factor_red`). 
*' The scaling factor for expansion makes sure that in case the full cell area consists of 
*' managed land (cropland, pasture, forestry plantations), the full peatland area is drained. 
*' Likewise, the scaling factor for reduction makes sure that in case no area is used for managed land, 
*' managed peatland (`manPeat58`) is reduced to zero. 
*' In case managed land remains unchanged, also managed peatland remains unchanged. 
*' The distribution of changes in total peatland area to managed peatland categories (`manPeat58`) 
*' depends on the weight of these categories in the previous time step (`p58_weight`). 

 q58_peatlandMan(j2,manPeat58)$(sum(ct, m_year(ct)) > s58_fix_peatland) ..
  v58_peatland(j2,manPeat58) =e= 
    pc58_peatland(j2,manPeat58) 
    + sum(manLand58, v58_manLandExp(j2,manLand58)) * sum(ct, p58_scaling_factor_exp(ct,j2) * p58_weight(ct,j2,manPeat58))
    - sum(manLand58, v58_manLandRed(j2,manLand58)) * sum(ct, p58_scaling_factor_red(ct,j2) * p58_weight(ct,j2,manPeat58));

*' This constraint avoids the conversion of intact peatland into rewetted peatland.

 q58_peatlandRewet(j2) ..
    v58_peatlandChange(j2,"rewetted") =l= -sum(drained58, v58_peatlandChange(j2,drained58)) + v58_peatlandChange(j2,"intact");

*' Costs for peatland degradation and rewetting

 q58_peatland_cost_full(j2) ..
  vm_peatland_cost(j2) =e= v58_peatland_cost(j2);

 q58_peatland_cost(j2) ..
  v58_peatland_cost(j2) =e= v58_peatland_cost_annuity_intact(j2) + v58_peatland_cost_annuity_rewet(j2)
              + v58_peatland(j2,"rewetted") * sum(ct, i58_cost_rewet_recur(ct))
              + sum(manPeat58, v58_peatland(j2,manPeat58)) * sum(ct, i58_cost_degrad_recur(ct));

 q58_peatland_cost_annuity_intact(j2) ..
  v58_peatland_cost_annuity_intact(j2) =e=
    -  v58_peatlandChange(j2,"intact") * sum(ct, i58_cost_degrad_onetime(ct))
  * sum((cell(i2,j2),ct),pm_interest(ct,i2)/(1+pm_interest(ct,i2)));
 
 q58_peatland_cost_annuity_rewet(j2) ..
  v58_peatland_cost_annuity_rewet(j2) =g=
    v58_peatlandChange(j2,"rewetted") * sum(ct, i58_cost_rewet_onetime(ct))
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
