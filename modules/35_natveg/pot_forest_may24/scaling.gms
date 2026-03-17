*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_cost_hvarea_natveg.scale(i)$(s35_hvarea = 1 OR s35_hvarea = 2) = 1e4;
*v35_hvarea_primforest.scale(j) = 1e-2;
*v35_hvarea_secdforest.scale(j,ac) = 1e-2;
*v35_other_expansion.scale(j,othertype35) = 1e-2;
*v35_other_reduction.scale(j,othertype35,ac) = 1e-2;
*v35_secdforest.scale(j,ac) = 1e-2;
*v35_secdforest_reduction.scale(j,ac) = 1e-3;
*q35_bv_primforest.scale(j,potnatveg) = 1e-3;
*q35_bv_secdforest.scale(j,potnatveg) = 1e-5;
*q35_carbon_primforest.scale(j,ag_pools,stockType) = 1e-5;
*q35_carbon_secdforest.scale(j,ag_pools,stockType) = 1e-4;
*q35_hvarea_other.scale(j,othertype35,ac) = 1e-3;
*q35_hvarea_primforest.scale(j) = 1e-3;
*q35_hvarea_secdforest.scale(j,ac) = 1e-2;
*q35_land_secdforest.scale(j) = 1e-5;
*q35_landdiff.scale = 1e-4;
*q35_max_forest_establishment.scale(j) = 1e-2;
*q35_min_forest.scale(j) = 1e-2;
*q35_other_est.scale(j,ac) = 1e-2;
*q35_other_reduction.scale(j,othertype35,ac) = 1e-2;
*q35_other_restoration.scale(j) = 1e-2;
*q35_primforest_reduction.scale(j) = 1e-3;
*q35_prod_other.scale(j) = 1e-3;
*q35_prod_primforest.scale(j) = 1e-3;
*q35_prod_secdforest.scale(j) = 1e-2;
*q35_secdforest_reduction.scale(j,ac) = 1e-2;
*q35_secdforest_reduction.scale(j,ac) = 1e-2;
*q35_secdforest_restoration.scale(j) = 1e-2;
