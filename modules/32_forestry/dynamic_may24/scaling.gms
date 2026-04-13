*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

v32_cost_establishment.scale(i) = 1e3;
v32_cost_recur.scale(i) = 1e4;
vm_cost_fore.scale(i) = 1e5;
v32_cost_hvarea.scale(i)$(s32_hvarea = 1 OR s32_hvarea = 2) = 1e3;
*v32_land.scale(j,type32,ac) = 1e-2;
*q32_aff_pol.scale(j) = 1e-2;
q32_bgp_aff.scale(j,ac) = 1e4;
*q32_bv_aff.scale(j,potnatveg) = 1e-2;
*q32_bv_plant.scale(j,potnatveg) = 1e-2;
q32_cdr_aff.scale(j,ac) = 1e4;
q32_cost_recur.scale(i) = 1e4;
*q32_establishment_demand.scale(i) = 1e-2;
*q32_establishment_hvarea.scale(j) = 1e-3;
*q32_forestry_est.scale(j,type32,ac) = 1e-2;
*q32_hvarea_forestry.scale(j,ac) = 1e-3;
*q32_land_diff.scale = 1e-4;
*q32_land_expansion.scale(j,type32) = 1e-2;
*q32_land_expansion_forestry.scale(j,type32) = 1e-2;
*q32_land_reduction.scale(j,type32,ac) = 1e-2;
*q32_land_reduction.scale(j,type32,ac) = 1e-3;
*q32_land_replant.scale(j) = 1e-2;
*q32_land_type32.scale(j,type32) = 1e-2;
*q32_land_type32.scale(j,type32) = 1e-2;
*q32_ndc_aff_limit.scale(j) = 1e-4;
*q32_prod_forestry.scale(j) = 1e-2;
*q32_prod_forestry_future.scale(i) = 1e-2;
