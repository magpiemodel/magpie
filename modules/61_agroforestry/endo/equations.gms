*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Total agroforestry cost. 
*' Cost for bioenergy trees are accounted for in the [30_crop] module. 
q61_cost_agroforestry(j2) ..
 vm_cost_agroforestry(j2) =e= 
 v61_cost_treecover_est(j2) + v61_cost_treecover_recur(j2) 
 - v61_reward_treecover(j2) - v61_reward_betr(j2);

*' Tree cover establishment cost
q61_cost_treecover_est(j2) ..
 v61_cost_treecover_est(j2) =e= 
 sum(ac_est, v61_treecover(j2,ac_est)) * s61_cost_treecover_est * 
 sum((cell(i2,j2),ct),pm_interest(ct,i2)/(1+pm_interest(ct,i2)));

*' Tree cover recurring cost
q61_cost_treecover_recur(j2) ..
 v61_cost_treecover_recur(j2) =e= 
 sum(ac_sub, v61_treecover(j2,ac_sub)) * s61_cost_treecover_recur;

*' Tree cover reward
q61_reward_treecover(j2) ..
  v61_reward_treecover(j2) =e= 
  sum(ac, v61_treecover(j2,ac)) * i61_reward_treecover;

*' Bioenergy tree reward
q61_reward_betr(j2) ..
  v61_reward_betr(j2) =e= 
  sum(ac, v61_treecover(j2,ac)) * i61_reward_betr;

*' Tree cover establishment
q61_treecover_est(j2,ac_est) ..
  v61_treecover(j2,ac_est) =e= sum(ac_est2, v61_treecover(j2,ac_est2))/card(ac_est2);

*' Tree cover area interface
q61_treecover_area(j2) ..
  vm_treecover_area(j2) =e= sum(ac, v61_treecover(j2,ac));

*' Tree cover carbon stock interface
q61_treecover_carbon(j2,ag_pools,stockType) ..
  vm_treecover_carbon(j2,ag_pools,stockType) =e=
  m_carbon_stock_ac(v61_treecover,p61_carbon_density_ac,"ac","ac_sub");

*' Tree cover biodiversity value
q61_treecover_bv(j2,potnatveg) .. 
  vm_bv(j2,"crop_tree",potnatveg) =e=
  sum(bii_class_secd, sum(ac_to_bii_class_secd(ac,bii_class_secd), v61_treecover(j2,ac)) * 
  p61_treecover_bii_coeff(bii_class_secd,potnatveg)) * fm_luh2_side_layers(j2,potnatveg);
