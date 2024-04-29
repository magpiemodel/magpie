*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' Total cropland equals croparea, because fallow land is fixed to zero 
*' and tree cover on cropland does not exist in this realization. 

 q29_cropland(j2)  ..
   vm_land(j2,"crop") =e= sum((kcr,w), vm_area(j2,kcr,w));


*' We assume that crop production can only take place on suitable cropland area.
*' We use a suitability index (SI) map from @zabel_global_2014 to exclude areas
*' from cropland production that have a low suitability, e.g. due to steep slopes,
*' to estimate the available cropland area. The cultivated area therefore has
*' to be smaller than the available cropland area.

 q29_avl_cropland(j2) ..
   vm_land(j2,"crop") =l= sum(ct, p29_avl_cropland(ct,j2));


*' The carbon stocks of total cropland are calculated as the sum of carbon stocks in 
*' cropland, fallow land and tree cover area.

  q29_carbon(j2,ag_pools,stockType) ..
    vm_carbon_stock(j2,"crop",ag_pools,stockType) =e=
      vm_carbon_stock_croparea(j2,ag_pools);


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
