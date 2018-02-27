*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

$title magpie

*##################### R SECTION START (VERSION INFO) ##########################
* 
* Used data set: GLUES2-sresa2-constant_co2-miub_echo_g_rev24_h200_8a828c6ed5004e77d1ba2025e8ea2261.tgz
* md5sum: 8e140aeecb333860275d76b5405c0b63
* Repository: scp://cluster.pik-potsdam.de/p/projects/landuse/data/input/archive
* 
* Used data set: magpie_8a828c6ed5004e77d1ba2025e8ea2261_rev3.6.tgz
* md5sum: a0153d503f9c3a6f1e023e0541f3dcae
* Repository: scp://cluster.pik-potsdam.de/p/projects/rd3mod/inputdata/output
* 
* Used data set: validation_8a828c6ed5004e77d1ba2025e8ea2261_rev3.6.tgz
* md5sum: ec416c9b6d5e551ca7ff93902b3827e5
* Repository: scp://cluster.pik-potsdam.de/p/projects/rd3mod/inputdata/output
* 
* Used data set: calibration_ValidationDefault_01Dec17.tgz
* md5sum: fdbaa1c9f28bbcb40c7c0df951a3df51
* Repository: scp://cluster.pik-potsdam.de/p/projects/landuse/data/input/calibration
* 
* Used data set: additional_data_rev3.18.tgz
* md5sum: 095ca0ce9b66f99d53c35fcf8f9d3ab2
* Repository: scp://cluster.pik-potsdam.de/p/projects/landuse/data/input/archive
* 
* Used data set: indc_rev2.1.tgz
* md5sum: 36c870f772f75ab1da1fa244866901c9
* Repository: scp://cluster.pik-potsdam.de/p/projects/landuse/data/input/archive
* 
* Low resolution: h200
* High resolution: 0.5
* 
* Total number of cells: 200
* 
* Number of cells per region:
*   SSA  MEA  OAS  CHA  NEU  EUR  REF  LAM  USA  CAZ  IND
*    12   18   24   21   12   18    8   35   11   33    8
* 
* Regionscode: 8a828c6ed5004e77d1ba2025e8ea2261
* 
* Regions data revision: 3.6
* 
* lpj2magpie settings:
* * LPJmL data folder: /p/projects/landuse/data/input/lpj_input/GLUES2/sresa2/constant_co2/miub_echo_g
* * Additional input folder: /p/projects/landuse/data/input/other/rev24
* * Revision: 24
* * Call: lpj2magpie(input_folder = path(cfg$lpj_input_folder, gsub("-",     "/", cfg$input)), input2_folder = path(cfg$additional_input_folder,     paste("rev", floor(cfg$revision), sep = "")), output_file = lpj2magpie_file,     rev = cfg$revision)
* 
* aggregation settings:
* * Input resolution: 0.5
* * Output resolution: h200
* * Input file: /p/projects/landuse/data/input/archive/GLUES2-sresa2-constant_co2-miub_echo_g_rev24_0.5.tgz
* * Output file: /p/projects/landuse/data/input/archive/GLUES2-sresa2-constant_co2-miub_echo_g_rev24_h200_8a828c6ed5004e77d1ba2025e8ea2261.tgz
* * Regionscode: 8a828c6ed5004e77d1ba2025e8ea2261
* * (clustering) n-repeat: 5
* * (clustering) n-redistribute: 0
* * Call: aggregation(input_file = paste0(cfg$base_folder, "/", set_folder,     "_", cfg$high_res, ".tgz"), regionmapping = paste0("../",     cfg$regionmapping), output_file = aggregation_file, rev = cfg$revision,     res_high = cfg$high_res, res_low = cfg$low_res, hcells = cfg$highres_cells,     nrepeat = cfg$nrepeat, nredistribute = cfg$nredistribute,     sum_spam_file = NULL, debug = FALSE)
* 
* 
* 
* Last modification (input data): Mon Feb 26 17:33:37 2018
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

$setglobal c_timesteps  quicktest

scalars
  s_use_gdx   use of gdx files                                       / 2 /
;
********************************************************************************

*******************************MODULE SETUP*************************************

$setglobal drivers  aug17
$setglobal land  feb15
$setglobal costs  default
$setglobal interest_rate  glo_jan16
$setglobal tc  endo_JUN16
$setglobal yields  biocorrect

$setglobal food  intake_dez17
$setglobal demand  sector_may15
$setglobal production  flexreg_apr16

$setglobal residues  flexreg_apr16
$setglobal processing  coupleproducts_feb17

$setglobal trade  selfsuff_flexreg

$setglobal crop  endo_jun13
$setglobal past  endo_jun13
$setglobal forestry  affore_vegc_dec16
$setglobal urban  static
$setglobal natveg  dynamic_mai17

$setglobal factor_costs  fixed_per_ton_nov16
$setglobal landconversion  gdp_scaled_jun13

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

magpie.optfile   = 1 ;
magpie.scaleopt  = 1 ;
magpie.solprint  = 0 ;
magpie.holdfixed = 1 ;

option lp         = cplex ;
option qcp        = cplex ;
$onecho > cplex.opt

$offecho

option nlp        = conopt4 ;
$onecho > conopt4.opt
Lin_Method = 1
Tol_Obj_Change = 1.0e-5
Lim_Iteration = 1000
$offecho

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
