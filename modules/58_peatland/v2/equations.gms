*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Constraint for constant total peatland area:

 q58_peatland(j2)$(sum(ct, m_year(ct)) > s58_fix_peatland) ..
  sum(land58, v58_peatland(j2,land58)) =e= sum(land58, pc58_peatland(j2,land58));

*' Constraints for peatland area expansion and reduction:

 q58_expansion(j2,land58) ..
        v58_expansion(j2,land58) =g= v58_peatland(j2,land58)-pc58_peatland(j2,land58);
 
 q58_reduction(j2,land58) ..
        v58_reduction(j2,land58) =g= pc58_peatland(j2,land58)-v58_peatland(j2,land58);

*' Future peatland degradation (`v58_peatland`) depends on managed land (`vm_land`, `vm_land_forestry`),
*' scaled with the ratio of total peatland area and total land area (`p58_scaling_factor`).
*' By multiplying changes in managed land with the scaling factor we implicitly assume
*' that intact peatlands are distributed equally within a grid cell.
*' The following example illustrates the mechanism used for projecting peatland dynamics:
*' In a given grid cell, the total land area is 50 Mha and the total peatland area is 10 Mha.
*' Therefore, the scaling factor is 0.2 (10 Mha divided by 50 Mha).
*' If cropland expands by 5 Mha, 1 Mha of intact peatland is converted to degraded peatland (5 Mha x 0.2).
*' If the total cell would become cropland, degraded peatland would equal to the total peatland area (50 Mha x 0.2 = 10 Mha).

 q58_peatland_crop(j2)$(sum(ct, m_year(ct)) > s58_fix_peatland) ..
  v58_peatland(j2,"crop") =e=
    pc58_peatland(j2,"crop")
    + ((vm_land(j2,"crop")-pcm_land(j2,"crop"))*p58_scaling_factor(j2)*sum(ct, p58_calib_factor(ct,j2,"crop")));

 q58_peatland_past(j2)$(sum(ct, m_year(ct)) > s58_fix_peatland) ..
  v58_peatland(j2,"past") =e=
    pc58_peatland(j2,"past")
    + ((vm_land(j2,"past")-pcm_land(j2,"past"))*p58_scaling_factor(j2)*sum(ct, p58_calib_factor(ct,j2,"past")));

 q58_peatland_forestry(j2)$(sum(ct, m_year(ct)) > s58_fix_peatland) ..
  v58_peatland(j2,"forestry") =e=
    pc58_peatland(j2,"forestry")
    + ((vm_land_forestry(j2,"plant")-pcm_land_forestry(j2,"plant"))*p58_scaling_factor(j2)*sum(ct, p58_calib_factor(ct,j2,"forestry")));

*' This constraint avoids the conversion of intact peatland into rewetted peatland. 
*' In each cluster, rewetted peatland area can only increase if no intact peatland area is lost. 
*' Therefore, rewetted peatland area can only increase if degraded peatland area (`landDrained58`) declines.

 q58_peatland_rewet(j2) ..
 v58_expansion(j2,"rewetted") * v58_reduction(j2,"intact") =e= 0;

*' Costs for peatland degradation and rewetting

 q58_peatland_cost_full(j2) ..
  vm_peatland_cost(j2) =e= v58_peatland_cost(j2);

 q58_peatland_cost(j2) ..
  v58_peatland_cost(j2) =e= v58_peatland_cost_annuity(j2)
              + v58_peatland(j2,"rewetted") * sum(ct, i58_cost_rewet_recur(ct))
              + sum(landDrainedUsed58, v58_peatland(j2,landDrainedUsed58)) * sum(ct, i58_cost_degrad_recur(ct));

 q58_peatland_cost_annuity(j2) ..
  v58_peatland_cost_annuity(j2) =e=
    (v58_expansion(j2,"rewetted") * sum(ct, i58_cost_rewet_onetime(ct))
    +  v58_reduction(j2,"intact") * sum(ct, i58_cost_degrad_onetime(ct)))
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
