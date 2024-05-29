*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' Total cropland is calculated as the sum of croparea, fallow land and tree cover area.

 q29_cropland(j2)  ..
   vm_land(j2,"crop") =e= sum((kcr,w), vm_area(j2,kcr,w)) + vm_fallow(j2) + sum(ac, v29_treecover(j2,ac));

*' We assume that crop production can only take place on suitable cropland area.
*' We use a suitability index (SI) map from @zabel_global_2014 to exclude areas
*' from cropland production that have a low suitability, e.g. due to steep slopes,
*' to estimate the available cropland area. The cultivated area therefore has
*' to be smaller than the available cropland area. Moreover, the available cropland
*' can be reduced by constraining the cropland area in favour of other land types,
*' in order to increase compositional heterogeneity of land types at the cell level.

 q29_avl_cropland(j2) ..
  vm_land(j2,"crop") =l= sum(ct, p29_avl_cropland(ct,j2));


*' Total cost for the cropland module.

  q29_cost_cropland(j2) ..
    vm_cost_cropland(j2) =e= 
      v29_cost_treecover_est(j2) + v29_cost_treecover_recur(j2)
      + v29_fallow_missing(j2) * sum(ct, i29_fallow_penalty(ct))
      + v29_treecover_missing(j2) * sum(ct, i29_treecover_penalty(ct));


*' The carbon stocks of total cropland are calculated as the sum of carbon stocks in 
*' cropland, fallow land and tree cover area.

  q29_carbon(j2,ag_pools,stockType) ..
    vm_carbon_stock(j2,"crop",ag_pools,stockType) =e=
      vm_carbon_stock_croparea(j2,ag_pools) 
      + vm_fallow(j2) * sum(ct, fm_carbon_density(ct,j2,"crop",ag_pools))
      + m_carbon_stock_ac(v29_treecover,p29_carbon_density_ac,"ac","ac_sub");


*' The semi-natural land constraint in cropland areas for sustaining critical regulating NCP
*' for agricultural production is added on top of land conserved for other reasons
*' (e.g. conservation of intact ecosystems or protection of biodiversity hotspots).

  q29_land_snv(j2) ..
    sum(land_snv, vm_land(j2,land_snv)) =g=
      sum(ct, p29_snv_shr(ct,j2)) * vm_land(j2,"crop")
      + sum((ct,land_snv,consv_type), pm_land_conservation(ct,j2,land_snv,consv_type));

*' The semi-natural vegetation constraint for cropland areas has been suggested at the per square
*' kilometer scale. The amount of cropland requiring relocation has therefore been derived from
*' exogeneous high-resolution land cover information from the Copernicus Global Land Service
*' (@buchhorn_copernicus_2020).

  q29_land_snv_trans(j2) ..
    sum(land_snv, vm_lu_transitions(j2,"crop",land_snv)) =g= sum(ct, p29_snv_relocation(ct,j2));

*' A penalty is applied for the violation of fallow land rules.
*' The penalty applies to the missing fallow land, i.e. where fallow land 
*' is lower than a certain fraction of total cropland.

  q29_fallow_min(j2)$(sum(ct, i29_fallow_penalty(ct)) > 0) ..
    v29_fallow_missing(j2) =g=
      vm_land(j2,"crop") * sum(ct, i29_fallow_target(ct)) - vm_fallow(j2);

  q29_fallow_max(j2) ..
    vm_fallow(j2) =l=
      vm_land(j2,"crop") * s29_fallow_max;

*' Fallow land biodiversity value is based on perennial crops. 

  q29_fallow_bv(j2,potnatveg) .. 
    vm_bv(j2,"crop_fallow",potnatveg) =e=
      vm_fallow(j2) * fm_bii_coeff("crop_per",potnatveg) * fm_luh2_side_layers(j2,potnatveg);


*' Interface vm_treecover for other modules.

  q29_treecover(j2) ..
    vm_treecover(j2) =e= sum(ac, v29_treecover(j2,ac));

*' A penalty is applied for the violation of treecover rules.
*' The penalty applies to the missing treecover area, i.e. where treecover area 
*' is lower than a certain fraction of total cropland.

  q29_treecover_min(j2)$(sum(ct, i29_treecover_penalty(ct)) > 0) ..
    v29_treecover_missing(j2) =g=
      vm_land(j2,"crop") * sum(ct, i29_treecover_target(ct,j2)) - sum(ac, v29_treecover(j2,ac));

  q29_treecover_max(j2) ..
    sum(ac, v29_treecover(j2,ac)) =l=
      vm_land(j2,"crop") * s29_treecover_max;

*' Depending on `s29_treecover_bii_coeff`, tree cover biodiversity value 
*' is based on natural vegetation or plantation BII coefficients. 

  q29_treecover_bv(j2,potnatveg) .. 
    vm_bv(j2,"crop_tree",potnatveg) =e=
      sum(bii_class_secd, sum(ac_to_bii_class_secd(ac,bii_class_secd), v29_treecover(j2,ac)) * 
      p29_treecover_bii_coeff(bii_class_secd,potnatveg)) * fm_luh2_side_layers(j2,potnatveg);

*' Cropland tree cover annuity cost.

  q29_cost_treecover_est(j2) ..
    v29_cost_treecover_est(j2) =e= 
      sum(ac_est, v29_treecover(j2,ac_est)) * s29_cost_treecover_est * 
      sum((cell(i2,j2),ct),pm_interest(ct,i2)/(1+pm_interest(ct,i2)));

*' Cropland tree cover recurring cost.

  q29_cost_treecover_recur(j2) ..
    v29_cost_treecover_recur(j2) =e= 
      sum(ac_sub, v29_treecover(j2,ac_sub)) * s29_cost_treecover_recur;

*' Cropland tree cover establishment rules for distributing areas equally to age-classes.
*' For a 5-year time step ac_est includes only ac0. But for a 10-year time step ac_est includes ac0 and ac5. 

  q29_treecover_est(j2,ac_est) ..
    v29_treecover(j2,ac_est) =e= sum(ac_est2, v29_treecover(j2,ac_est2))/card(ac_est2);
