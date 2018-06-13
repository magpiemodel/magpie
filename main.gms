*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

$title magpie

*##################### R SECTION START (VERSION INFO) ##########################
* 
* Used data set: isimip_rcp-IPSL_CM5A_LR-rcp2p6-noco2_rev32_h200_8a828c6ed5004e77d1ba2025e8ea2261.tgz
* md5sum: 6d5b7f89dfc09eb2868e87f6b56262a7
* Repository: scp://cluster.pik-potsdam.de/p/projects/landuse/data/input/archive
* 
* Used data set: rev3.21_8a828c6ed5004e77d1ba2025e8ea2261_magpie.tgz
* md5sum: ffab6b604a51fd327d52a1c20b08a23f
* Repository: scp://cluster.pik-potsdam.de/p/projects/rd3mod/inputdata/output
* 
* Used data set: rev3.21_8a828c6ed5004e77d1ba2025e8ea2261_validation.tgz
* md5sum: a57440d652136cc51c26545e5f07e33c
* Repository: scp://cluster.pik-potsdam.de/p/projects/rd3mod/inputdata/output
* 
* Used data set: additional_data_rev3.34.tgz
* md5sum: dcb715b53cb6506dc78834c09811b3d9
* Repository: scp://cluster.pik-potsdam.de/p/projects/landuse/data/input/archive
* 
* Low resolution: h200
* High resolution: 0.5
* 
* Total number of cells: 200
* 
* Number of cells per region:
*   SSA  MEA  OAS  CHA  IND  REF  NEU  EUR  LAM  USA  CAZ
*    10   15   22   19    8    5    8   15   57   11   30
* 
* Regionscode: 8a828c6ed5004e77d1ba2025e8ea2261
* 
* Regions data revision: 3.21
* 
* lpj2magpie settings:
* * LPJmL data folder: /p/projects/landuse/data/input/lpj_input/isimip_rcp/IPSL_CM5A_LR/rcp2p6/noco2
* * Additional input folder: /p/projects/landuse/data/input/other/rev32
* * Revision: 32
* * Call: lpj2magpie(input_folder = path(cfg$lpj_input_folder, gsub("-",     "/", cfg$input)), input2_folder = path(cfg$additional_input_folder,     paste("rev", floor(cfg$revision), sep = "")), output_file = lpj2magpie_file,     rev = cfg$revision)
* 
* aggregation settings:
* * Input resolution: 0.5
* * Output resolution: h200
* * Input file: /p/projects/landuse/data/input/archive/isimip_rcp-IPSL_CM5A_LR-rcp2p6-noco2_rev32_0.5.tgz
* * Output file: /p/projects/landuse/data/input/archive/isimip_rcp-IPSL_CM5A_LR-rcp2p6-noco2_rev32_h200_8a828c6ed5004e77d1ba2025e8ea2261.tgz
* * Regionscode: 8a828c6ed5004e77d1ba2025e8ea2261
* * (clustering) n-repeat: 5
* * (clustering) n-redistribute: 0
* * Call: aggregation(input_file = paste0(cfg$base_folder, "/", set_folder,     "_", cfg$high_res, ".tgz"), regionmapping = paste0("../",     cfg$regionmapping), output_file = aggregation_file, rev = cfg$revision,     res_high = cfg$high_res, res_low = cfg$low_res, hcells = cfg$highres_cells,     weight = cfg$cluster_weight, nrepeat = cfg$nrepeat, nredistribute = cfg$nredistribute,     sum_spam_file = NULL, debug = FALSE)
* 
* 
* 
* Last modification (input data): Wed Jun 13 10:05:44 2018
* 
*###################### R SECTION END (VERSION INFO) ###########################

$offupper
$offsymxref
$offsymlist
$offlisting

********************************************************************************
*** WARNING **** WARNING **** WARNING **** WARNING **** WARNING **** WARNING ***
********************************************************************************

* PLEASE DO NOT PERFORM ANY CHANGES HERE! ALL SETTINGS WILL BE AUTOMATICALLY
* SET BY MAGPIE_START.R BASED ON THE SETTINGS OF THE CORRESPONDING CFG FILE
* PLEASE DO ALL SETTINGS IN THE CORRESPONDING CFG FILE (e.g. config/default.cfg)

********************************************************************************
*** WARNING **** WARNING **** WARNING **** WARNING **** WARNING **** WARNING ***
********************************************************************************

**************************MODEL SPECIFIC SCALARS********************************
*                    Key parameters during model runs

$setglobal c_timesteps  coup2100

scalars
  s_use_gdx   use of gdx files                                       / 2 /
;
********************************************************************************

*******************************MODULE SETUP*************************************

$setglobal drivers  aug17
$setglobal land  feb15
$setglobal costs  default
$setglobal interest_rate  reg_feb18
$setglobal tc  endo_JUN16
$setglobal yields  dynamic_apr18

$setglobal food  anthropometrics_jan18
$setglobal demand  sector_may15
$setglobal production  flexreg_apr16

$setglobal residues  flexreg_apr16
$setglobal processing  coupleproducts_feb17

$setglobal trade  selfsuff_flexreg_cost

$setglobal crop  endo_jun13
$setglobal past  endo_jun13
$setglobal forestry  affore_vegc_dec16
$setglobal urban  static
$setglobal natveg  dynamic_may18

$setglobal factor_costs  mixed_feb17
$setglobal landconversion  gdp_vegc_may18

$setglobal transport  gtap_nov12
$setglobal area_equipped_for_irrigation  endo_apr13
$setglobal water_demand  agr_sector_aug13
$setglobal water_availability  total_water_aug13
$setglobal climate  static

$setglobal nr_soil_budget  exoeff_aug16
$setglobal nitrogen  ipcc2006_sep16
$setglobal carbon  normal_dec17
$setglobal methane  ipcc2006_flexreg_apr16
$setglobal phosphorus  off
$setglobal awms  ipcc2006_aug16
$setglobal ghg_policy  price_sep16
$setglobal maccs  on_sep16
$setglobal carbon_removal  off_sep16
$setglobal som  off

$setglobal bioenergy  standard_flexreg_may17
$setglobal material  exo_flexreg_apr16
$setglobal livestock  fbask_jan16

$setglobal optimization  lp_nlp_apr17

****************************END MODULE SETUP************************************

***************************PREDEFINED MACROS************************************
$include "./core/macros.gms"
********************************************************************************

***************************BASIC SETS INDICES***********************************
$include "./core/sets.gms"
$batinclude "./modules/include.gms" sets
********************************************************************************

**********INTRODUCE CALCULATION PARAMETERS, VARIABLES AND EQUATIONS*************
$include "./core/declarations.gms"
$batinclude "./modules/include.gms" declarations
********************************************************************************

*****************************IMPORT DATA FILES**********************************
$batinclude "./modules/include.gms" input
********************************************************************************

********************OBJECTIVE FUNCTION & CONSTRAINTS****************************
$batinclude "./modules/include.gms" equations
********************************************************************************

*******************MODEL DEFINITION & SOLVER OPTIONS****************************
model magpie / all - m15_food_demand /;

option iterlim    = 1000000 ;
option reslim     = 1000000 ;
option sysout     = Off ;
option limcol     = 0 ;
option limrow     = 0 ;
option decimals   = 3 ;
option savepoint  = 1 ;
********************************************************************************

*****************************VARIABLE SCALING***********************************
$batinclude "./modules/include.gms" scaling
********************************************************************************

***************************GENERAL CALCULATIONS*********************************
$include "./core/calculations.gms"
********************************************************************************

*** EOF magpie.gms ***
