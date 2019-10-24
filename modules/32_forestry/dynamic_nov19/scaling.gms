*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

v32_cost_establishment.scale(i) = 10e5;
v32_cost_recur.scale(i) = 10e3;
v32_high_mgmt_prod_cost.scale(i) = 10e6;
v32_hvarea_forestry.scale(j,kforestry,ac_sub,mgmt_type) = 10e-4;
v32_land.scale(j,type32,ac) = 10e-3;
v32_land_expansion.scale(j,type32,ac) = 10e-3;
v32_land_reduction.scale(j,type32,ac) = 10e-3;
v35_cost_harvest.scale(i) = 10e3;
v35_hvarea_other.scale(j,kforestry,ac_sub) = 10e-4;
v35_hvarea_secdforest.scale(j,kforestry,ac_sub) = 10e-3;
vm_cost_fore.scale(i) = 10e6;
vm_cost_glo.scale = 10e11;
vm_cost_natveg.scale(i) = 10e3;
vm_cost_trade.scale(i) = 10e4;
vm_emission_costs.scale(i) = 10e5;
vm_landdiff.scale = 10e5;
vm_landdiff_natveg.scale = 10e5;
vm_maccs_costs.scale(i) = 10e4;
vm_nr_inorg_fert_costs.scale(i) = 10e4;
vm_processing_substitution_cost.scale(i) = 10e5;
vm_tech_cost.scale(i) = 10e5;
vm_watdem.scale(wat_dem,j) = 10e4;
