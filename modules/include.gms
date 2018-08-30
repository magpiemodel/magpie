*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


$setglobal phase %1
$onrecurse
*######################## R SECTION START (MODULES) ############################
$include "./modules/09_drivers/09_drivers.gms"
$include "./modules/10_land/10_land.gms"
$include "./modules/11_costs/11_costs.gms"
$include "./modules/12_interest_rate/12_interest_rate.gms"
$include "./modules/13_tc/13_tc.gms"
$include "./modules/14_yields/14_yields.gms"
$include "./modules/15_food/15_food.gms"
$include "./modules/16_demand/16_demand.gms"
$include "./modules/17_production/17_production.gms"
$include "./modules/18_residues/18_residues.gms"
$include "./modules/20_processing/20_processing.gms"
$include "./modules/21_trade/21_trade.gms"
$include "./modules/30_crop/30_crop.gms"
$include "./modules/31_past/31_past.gms"
$include "./modules/32_forestry/32_forestry.gms"
$include "./modules/34_urban/34_urban.gms"
$include "./modules/35_natveg/35_natveg.gms"
$include "./modules/38_factor_costs/38_factor_costs.gms"
$include "./modules/39_landconversion/39_landconversion.gms"
$include "./modules/40_transport/40_transport.gms"
$include "./modules/41_area_equipped_for_irrigation/41_area_equipped_for_irrigation.gms"
$include "./modules/42_water_demand/42_water_demand.gms"
$include "./modules/43_water_availability/43_water_availability.gms"
$include "./modules/45_climate/45_climate.gms"
$include "./modules/50_nr_soil_budget/50_nr_soil_budget.gms"
$include "./modules/51_nitrogen/51_nitrogen.gms"
$include "./modules/52_carbon/52_carbon.gms"
$include "./modules/53_methane/53_methane.gms"
$include "./modules/54_phosphorus/54_phosphorus.gms"
$include "./modules/55_awms/55_awms.gms"
$include "./modules/56_ghg_policy/56_ghg_policy.gms"
$include "./modules/57_maccs/57_maccs.gms"
$include "./modules/58_carbon_removal/58_carbon_removal.gms"
$include "./modules/59_som/59_som.gms"
$include "./modules/60_bioenergy/60_bioenergy.gms"
$include "./modules/62_material/62_material.gms"
$include "./modules/70_livestock/70_livestock.gms"
$include "./modules/71_disagg_lvst/71_disagg_lvst.gms"
$include "./modules/80_optimization/80_optimization.gms"
*######################## R SECTION END (MODULES) ##############################
$offrecurse
*** EOF include.gms ***
