*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The total land requirements for cropland are calculated as
*' the sum of crop and water supply type specific land requirements:

 q30_cropland(j2)  ..
   sum((kcr,w), vm_area(j2,kcr,w)) =e= vm_land(j2,"crop");

*' We assume that crop production can only take place on suitable cropland area.
*' We use a suitability index (SI) map from @zabel_global_2014 to exclude areas
*' from cropland production that have a low suitability, e.g. due to steep slopes,
*' to estimate the available cropland area. The cultivated area therefore has
*' to be smaller than the available cropland area. Moreover, the available cropland
*' can be reduced by constraining the cropland area in favour of other land types,
*' in order to increase compositional heterogeneity of land types at the cell level.

 q30_avl_cropland(j2) ..
   vm_land(j2,"crop") =l= sum(ct, p30_avl_cropland(ct,j2));

*' The semi-natural land constraint in cropland areas for sustaining critical regulating NCP
*' for agricultural production is added on top of land conserved for other reasons
*' (e.g. conservation of intact ecosystems or protection of biodiversity hotspots).
 q30_land_snv(j2) ..
            sum(land_snv, vm_land(j2,land_snv))
            =g=
            sum(ct, p30_snv_shr(ct,j2)) * vm_land(j2,"crop")
          + sum((ct,land_snv,consv_type), pm_land_conservation(ct,j2,land_snv,consv_type));

*' The semi-natural vegetation constraint for cropland areas has been suggested at the per square
*' kilometer scale. The amount of cropland requiring relocation has therefore been derived from
*' exogeneous high-resolution land cover information from the Copernicus Global Land Service
*' (@buchhorn_copernicus_2020).

 q30_land_snv_trans(j2) ..
         sum(land_snv, vm_lu_transitions(j2,"crop",land_snv)) =g= sum(ct, p30_snv_relocation(ct,j2));

*' As additional constraints minimum and maximum rotational constraints limit
*' the placing of crops. On the one hand, these rotational constraints reflect
*' crop rotations limiting the share a specific crop can cover of the total area
*' of a cluster:

 q30_rotation_max(j2,crpmax30,w) ..
   sum((crp_kcr30(crpmax30,kcr)), vm_area(j2,kcr,w)) =l=
     sum(kcr, vm_area(j2,kcr,w)) * f30_rotation_max_shr(crpmax30);

*' On the other hand, it reflects boundary conditions such as minimum self
*' sufficiency constraints:

 q30_rotation_min(j2,crpmin30,w) ..
   sum((crp_kcr30(crpmin30,kcr)), vm_area(j2,kcr,w)) =g=
     sum(kcr, vm_area(j2,kcr,w)) * f30_rotation_min_shr(crpmin30);

*' Agricultural production is calculated by multiplying the area under
*' production with corresponding yields. Production from rainfed and irrigated
*' areas is summed up:

 q30_prod(j2,kcr) ..
  vm_prod(j2,kcr) =e= sum(w, vm_area(j2,kcr,w) * vm_yld(j2,kcr,w));

*' The carbon content of the above ground carbon pools are calculated as a total
*' for all cropland :

 q30_carbon(j2,ag_pools,stockType) ..
 vm_carbon_stock(j2,"crop",ag_pools,stockType) =e=
   m_carbon_stock(vm_land,fm_carbon_density,"crop");

*' The biodiversity value for cropland is calculated separately for annual and perennial crops:
 q30_bv_ann(j2,potnatveg) .. vm_bv(j2,"crop_ann",potnatveg)
          =e=
          sum((crop_ann30,w), vm_area(j2,crop_ann30,w)) * fm_bii_coeff("crop_ann",potnatveg) * fm_luh2_side_layers(j2,potnatveg);

 q30_bv_per(j2,potnatveg) .. vm_bv(j2,"crop_per",potnatveg)
          =e=
          (vm_land(j2,"crop") - sum((crop_ann30,w), vm_area(j2,crop_ann30,w)))
          * fm_bii_coeff("crop_per",potnatveg) * fm_luh2_side_layers(j2,potnatveg);
