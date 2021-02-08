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
$setglobal c32_interest_rate  regional
* options regional, global
$setglobal c32_dev_scen  abare
* options abare, brown
$setglobal c32_incr_rate  h5s1l05
* options constant,h5s5l5,h5s2l2,h5s2l1,h5s1l1,h5s1l05,h2s1l05

scalars
  s32_reESTBcost                  Re establishment cost (USD per ha) / 2000 /
  s32_recurring_cost              Recurring costs (USD per ha) / 500 /
  s32_harvesting_cost             Harvesting cost (USD per ha) / 2000 /
  s32_planing_horizon             Afforestation planing horizon (years)            / 50 /
  s32_rotation_extension          Rotation extension factor 1=original rotations 2=100 percent increase in rotations etc (1) / 1 /
  s32_faustmann_rotation          Switch to activate faustmann rotations (1=on 0=off) / 0 /
  s32_initial_distribution        Switch to Activate ageclass distribution in plantations 1=on 0=off (1) / 1 /
  s32_price                       Price for timber (USD)      / 45 /
  s32_free_land_cost              Very high cost for using non existing land for plantation establishment (USD per ha) /1000000/
  s32_max_aff_area                Maximum total global afforestation (mio. ha)    / Inf /
  s32_aff_plantation              Switch for using growth curves for afforestation 0=natveg 1=plantations (1) / 0 /
  s32_timber_plantation           Switch for using growth curves for timber plantations 0=natveg 1=plantations (1) / 1 /
  s32_tcre_local                  Switch for local (1) or global (0) TRCE factors (1) / 1 /
  s32_fix_plant                   Fixing plantation area after sm_fix_SSP2 0=Not fixed 1=Fixed (1) / 0 /
  s32_forestry_int_rate           Global interest rate for plantations (percent) / 0.05 /
  s32_investment_cost             Additional investment cost in plantations (USD per tC per ha) / 200 /
  s32_distribution_type           Which type of distribution shall be used for initializing plantations (0=equal distribution 1=FAO distribution 2=Poulter distribution 3=Manual distribution) /3/
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

parameter f32_ac_dist(ac) Age class distribution share (1)
/
$ondelim
$include "./modules/32_forestry/input/f32_ac_dist.csv"
$offdelim
/;

parameter f32_gs_relativetarget(i) Relative growing stock target in each region (m3 per ha)
/
$ondelim
$include "./modules/32_forestry/input/f32_gs_relativetarget.cs4"
$offdelim
/;

table f32_plantation_contribution(t_ext,i,inter32,scen32) Share of roundwood production coming from timber plantations (percent)
$ondelim
$include "./modules/32_forestry/input/f32_plantation_contribution.cs3"
$ondelim
;

parameter f32_plantedforest(i) Share of plantation forest in planted forest (1)
/
$ondelim
$include "./modules/32_forestry/input/f32_plantedforest.cs4"
$offdelim
/;

parameter f32_estb_calib(i) Calibration factor for plantation forest establishment (1)
/
$ondelim
$include "./modules/32_forestry/input/f32_estb_calib.cs4"
$offdelim
/;
