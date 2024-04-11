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


*' The semi-natural land constraint in cropland areas for sustaining critical regulating NCP
*' for agricultural production is added on top of land conserved for other reasons
*' (e.g. conservation of intact ecosystems or protection of biodiversity hotspots).

 q29_land_snv(j2) ..
            sum(land_snv, vm_land(j2,land_snv))
            =g=
            sum(ct, p29_snv_shr(ct,j2)) * vm_land(j2,"crop")
          + sum((ct,land_snv,consv_type), pm_land_conservation(ct,j2,land_snv,consv_type));


*' The semi-natural vegetation constraint for cropland areas has been suggested at the per square
*' kilometer scale. The amount of cropland requiring relocation has therefore been derived from
*' exogeneous high-resolution land cover information from the Copernicus Global Land Service
*' (@buchhorn_copernicus_2020).

 q29_land_snv_trans(j2) ..
         sum(land_snv, vm_lu_transitions(j2,"crop",land_snv)) =g= sum(ct, p29_snv_relocation(ct,j2));


*' The carbon stocks of total cropland are calculated as the sum of carbon stocks in cropland, fallow land and tree cover area.

 q29_carbon(j2,ag_pools,stockType) ..
  vm_carbon_stock(j2,"crop",ag_pools,stockType) =e=
  vm_carbon_stock_crop(j2,ag_pools) 
  + vm_fallow(j2) * sum(ct, fm_carbon_density(ct,j2,"crop",ag_pools))
  + m_carbon_stock_ac(v29_treecover,p31_carbon_density_ac,"ac","ac_sub");


*' Total agroforestry cost. 
*' Cost for bioenergy trees are accounted for in the [30_crop] module. 
q61_cost_cropland(j2) ..
 vm_cost_cropland(j2) =e= 
 v61_cost_treecover_est(j2) + v61_cost_treecover_recur(j2);

*' Tree cover establishment cost
q61_cost_treecover_est(j2) ..
 v61_cost_treecover_est(j2) =e= 
 sum(ac_est, v61_treecover(j2,ac_est)) * s61_cost_treecover_est * 
 sum((cell(i2,j2),ct),pm_interest(ct,i2)/(1+pm_interest(ct,i2)));

*' Tree cover recurring cost
q61_cost_treecover_recur(j2) ..
 v61_cost_treecover_recur(j2) =e= 
 sum(ac_sub, v61_treecover(j2,ac_sub)) * s61_cost_treecover_recur;

*' Tree cover minimum share
q61_treecover_shr(j2) ..
  sum(ac, v61_treecover(j2,ac)) =g= 
  sum(ct, p61_treecover_min_shr(ct,j2)) * vm_land(j2,"crop");

*' Bioenergy tree minimum share
q61_betr_shr(j2) ..
  sum(w, vm_area(j2,"betr",w)) =g=
  sum(ct, p61_betr_min_shr(ct,j2)) * vm_land(j2,"crop");

*' Tree cover establishment
q61_treecover_est(j2,ac_est) ..
  v61_treecover(j2,ac_est) =e= sum(ac_est2, v61_treecover(j2,ac_est2))/card(ac_est2);

*' Tree cover biodiversity value
q61_treecover_bv(j2,potnatveg) .. 
  vm_bv(j2,"crop_tree",potnatveg) =e=
  sum(bii_class_secd, sum(ac_to_bii_class_secd(ac,bii_class_secd), v61_treecover(j2,ac)) * 
  p61_treecover_bii_coeff(bii_class_secd,potnatveg)) * fm_luh2_side_layers(j2,potnatveg);
