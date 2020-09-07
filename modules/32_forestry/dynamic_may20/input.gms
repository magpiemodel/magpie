$setglobal c32_timber_plantations  plantations
* option: natveg, plantations
$setglobal c32_aff_mask  noboreal
* options: unrestricted, noboreal, onlytropical
$setglobal c32_aff_policy  npi
* options: none, npi, ndc

$setglobal c32_aff_bgp  nobgp
* options: ann,nobgp
$setglobal c32_tcre_ctrl  ann_TCREmean
* options: ann_TCREmean, ann_TCREhigh, ann_TCRElow

scalars
  s32_reESTBcost                  Re establishment cost (USD per ha) / 2000 /
  s32_recurring_cost              Recurring costs (USD per ha) / 500 /
  s32_harvesting_cost             Harvesting cost (USD per ha) / 200 /
  s32_planing_horizon             Afforestation planing horizon (years)            / 50 /
  s32_recurring_cost_multiplier   Cost multiplier for recurring costs only for testing (1)            / 10 /
  s32_rotation_extension          Rotation extension factor 1=original rotations 2=100 percent increase in rotations etc (1) / 1 /
  s32_faustmann_rotation          Switch to activate faustmann rotations (1) / 0 /
  s32_initial_distribution        Switch to Activate ageclass distribution in plantations 1=on 0=off (1) / 0 /
  s32_price                       Price for timber (USD)      / 45 /
  s32_free_land_cost              Very high cost for using non existing land for plantation establishment (USD per ha) /1000000/
  s32_max_aff_area                Maximum total global afforestation (mio. ha)    / Inf /
  s32_aff_plantation              Switch for using growth curves for afforestation 0=natveg 1=plantations (1) / 0 /
  s32_timber_plantation           Switch for using growth curves for timber plantations 0=natveg 1=plantations (1) / 1 /
  s32_plant_carbon_foresight      Switch to allow plantations to be used as incentives for CDR (1) / 1 /
  s32_tcre_local switch for local (1) or global (0) TRCE factors / 1 /
;

parameter f32_aff_mask(j) afforestation mask (binary)
/
$ondelim
$Ifi "%c32_aff_mask%" == "unrestricted" $include "./modules/32_forestry/input/aff_unrestricted.cs2"
$Ifi "%c32_aff_mask%" == "noboreal" $include "./modules/32_forestry/input/aff_noboreal.cs2"
$Ifi "%c32_aff_mask%" == "onlytropical" $include "./modules/32_forestry/input/aff_onlytropical.cs2"
$offdelim
/;

table f32_aff_pol(t_all,j,pol32) npi+ndc afforestation policy (Mha new forest wrt to 2010)
$ondelim
$include "./modules/32_forestry/input/npi_ndc_aff_pol.cs3"
$offdelim
;

parameter f32_plant_prod_share(t_all) Share of overall production coming from plantations (1)
/
$ondelim
$include "./modules/32_forestry/input/f32_plant_prod_share.csv"
$offdelim
/
;

table f32_aff_bgp(j,bgp32) Biogeophysical temperature change of afforestation (degree C)
$ondelim
$include "./modules/32_forestry/input/f32_bph_effect_noTCRE.cs3"
$ondelim
;

table f32_tcre(j,tcre32) Transient surface temperature response to CO2 emission (degree C per tC per ha)
$ondelim
$include "./modules/32_forestry/input/f32_localTCRE.cs3"
$ondelim
;
