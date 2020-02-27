$setglobal c32_aff_mask  noboreal
* options: unrestricted, noboreal, onlytropical
$setglobal c32_aff_policy  npi
$setglobal c32_rot_length  rlGTM
$setglobal c32_rot_length_estb  rlGTM
$setglobal c32_bef  ipccBEF

scalars
  c32_reESTBcost Reestablishment cost in USD per ha / 2000 /
  c32_recurring_cost Recurring costs in USD per ha / 100 /
  c32_harvesting_cost Harvesting cost in USD per ha / 200 /
  s32_planing_horizon Afforestation planing horizon (years)            / 80 /
  s32_recurring_cost_multiplier Cost multiplier for recurring costs only for testing (1)            / 100 /
  c32_rotation_extension Rotation extension / 0 /
;

scalars
        s32_max_aff_area         maximum total global afforestation in Mha    / Inf /
;

parameter f32_aff_mask(j) afforestation mask (binary)
/
$ondelim
$Ifi "%c32_aff_mask%" == "unrestricted" $include "./modules/32_forestry/input/aff_unrestricted.cs2"
$Ifi "%c32_aff_mask%" == "noboreal" $include "./modules/32_forestry/input/aff_noboreal.cs2"
$Ifi "%c32_aff_mask%" == "onlytropical" $include "./modules/32_forestry/input/aff_onlytropical.cs2"
$offdelim
/;

table f32_fac_req_ha(i,fcosts32) Afforestation factor requirement costs (US Dollar 2004 per ha per annum)
$ondelim
$include "./modules/32_forestry/input/f32_fac_req_ha.csv"
$offdelim
;
f32_fac_req_ha(i,"recur") = f32_fac_req_ha(i,"recur") * s32_recurring_cost_multiplier;

parameter fm_harvest_cost_ha(i) Harvesting cost (US Dollar 2004 per ha)
/
$ondelim
$include "./modules/32_forestry/input/f32_harvestingcost.cs4"
$offdelim
/
;

table f32_aff_pol(t_all,j,pol32) npi+indc afforestation policy (Mha new forest wrt to 2010)
$ondelim
$include "./modules/32_forestry/input/npi_ndc_aff_pol.cs3"
$offdelim
;

table f32_production_ratio(t_all,i) percentage of supply coming from plantations (percentage)
$ondelim
$include "./modules/32_forestry/input/f32_production_ratio.csv"
$offdelim
;
f32_production_ratio(t_all,"JPN") = f32_production_ratio("y1995","JPN");
f32_production_ratio(t_all,"MEA") = f32_production_ratio("y1995","MEA");

table f32_forestry_management(i,forest_type) upscaling factor for forestry plantations
$ondelim
$include "./modules/32_forestry/input/f32_forestry_management.csv"
$offdelim
;
