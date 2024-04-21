*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


$setglobal phase %1
$onrecurse
*######################## R SECTION START (MODULES) ############################
$include "./modules/09_drivers/module.gms"
$include "./modules/10_land/module.gms"
$include "./modules/11_costs/module.gms"
$include "./modules/12_interest_rate/module.gms"
$include "./modules/13_tc/module.gms"
$include "./modules/14_yields/module.gms"
$include "./modules/15_food/module.gms"
$include "./modules/16_demand/module.gms"
$include "./modules/17_production/module.gms"
$include "./modules/18_residues/module.gms"
$include "./modules/20_processing/module.gms"
$include "./modules/21_trade/module.gms"
$include "./modules/22_land_conservation/module.gms"
$include "./modules/28_ageclass/module.gms"
$include "./modules/29_cropland/module.gms"
$include "./modules/30_croparea/module.gms"
$include "./modules/31_past/module.gms"
$include "./modules/32_forestry/module.gms"
$include "./modules/34_urban/module.gms"
$include "./modules/35_natveg/module.gms"
$include "./modules/36_employment/module.gms"
$include "./modules/37_labor_prod/module.gms"
$include "./modules/38_factor_costs/module.gms"
$include "./modules/39_landconversion/module.gms"
$include "./modules/40_transport/module.gms"
$include "./modules/41_area_equipped_for_irrigation/module.gms"
$include "./modules/42_water_demand/module.gms"
$include "./modules/43_water_availability/module.gms"
$include "./modules/44_biodiversity/module.gms"
$include "./modules/45_climate/module.gms"
$include "./modules/50_nr_soil_budget/module.gms"
$include "./modules/51_nitrogen/module.gms"
$include "./modules/52_carbon/module.gms"
$include "./modules/53_methane/module.gms"
$include "./modules/54_phosphorus/module.gms"
$include "./modules/55_awms/module.gms"
$include "./modules/56_ghg_policy/module.gms"
$include "./modules/57_maccs/module.gms"
$include "./modules/58_peatland/module.gms"
$include "./modules/59_som/module.gms"
$include "./modules/60_bioenergy/module.gms"
$include "./modules/62_material/module.gms"
$include "./modules/70_livestock/module.gms"
$include "./modules/71_disagg_lvst/module.gms"
$include "./modules/73_timber/module.gms"
$include "./modules/80_optimization/module.gms"
*######################## R SECTION END (MODULES) ##############################
$offrecurse
*** EOF include.gms ***
