*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

v11_cost_reg.scale(i) = 10e6;
v13_cost_tc.scale(i) = 10e7;
v13_tech_cost_annuity.scale(i) = 10e4;
v15_income_pc_real_ppp_iso.scale(iso) = 10e5;
v15_kcal_intake_total_regr.scale(iso) = 10e3;
v15_kcal_regr_total.scale(iso) = 10e4;
v32_cost_establishment.scale(i) = 10e5;
v32_cost_recur.scale(i) = 10e4;
v32_hvarea_forestry.scale(j,kforestry,ac_sub,mgmt_type) = 10e-4;
v35_cost_harvest.scale(i) = 10e3;
v35_hvarea_other.scale(j,kforestry,ac_sub) = 10e-3;
v35_hvarea_secdforest.scale(j,kforestry,ac_sub) = 10e-3;
v43_watavail.scale(wat_src,j) = 10e5;
vm_bioenergy_utility.scale(i) = 10e4;
vm_carbon_stock.scale(j,land,c_pools) = 10e3;
vm_cost_AEI.scale(i) = 10e4;
vm_cost_fore.scale(i) = 10e5;
vm_cost_glo.scale = 10e7;
vm_cost_landcon.scale(j,land) = 10e3;
vm_cost_natveg.scale(i) = 10e3;
vm_cost_processing.scale(i) = 10e5;
vm_cost_prod.scale(i,kall) = 10e4;
vm_cost_trade.scale(i) = 10e4;
vm_landdiff.scale = 10e4;
vm_landdiff_forestry.scale = 10e3;
vm_landdiff_natveg.scale = 10e4;
vm_nr_inorg_fert_costs.scale(i) = 10e4;
vm_processing_substitution_cost.scale(i) = 10e4;
vm_tech_cost.scale(i) = 10e5;
vm_watdem.scale(wat_dem,j) = 10e4;
