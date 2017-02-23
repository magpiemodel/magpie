*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$title magpie

*##################### R SECTION START (VERSION INFO) ##########################
*
* Used data set: GLUES2-sresa2-constant_co2-miub_echo_g_ERB_rev22.1_n200_690d3718e151be1b450b394c1064b1c5.tgz
* md5sum: 763374ea06f7e3092b62381a4edf6493
* Repository: scp://cluster.pik-potsdam.de/p/projects/landuse/data/input/archive
*
* Used data set: magpie_690d3718e151be1b450b394c1064b1c5_rev2.05.tgz
* md5sum: 363eebcab40d4d4d4ae57f6f6101a363
* Repository: scp://cluster.pik-potsdam.de/p/projects/rd3mod/inputdata/output
*
* Used data set: additional_data_rev1.0.tgz
* md5sum: 498d060facd4d7099d206c335a29f218
* Repository: scp://cluster.pik-potsdam.de/p/projects/landuse/data/input/archive
*
* Low resolution: n200
* High resolution: 0.5
*
* Total number of cells: 200
*
* Number of cells per region:
*   SSA  MEA  OAS  CHA  NEU  EUR  REF  LAM  USA  CAZ  JPN  IND
*    25   17   11   13    4    8   46   24   15   32    1    4
*
* Regionscode: 690d3718e151be1b450b394c1064b1c5
*
* Regions data revision: 2.05
*
* lpj2magpie settings:
* * LPJmL data folder: /p/projects/landuse/data/input/lpj_input/GLUES2/sresa2/constant_co2/miub_echo_g
* * Additional input folder: /p/projects/landuse/data/input/other/rev22
* * Land input data set: ERB
* * Revision: 22.1
* * Call: lpj2magpie(input_folder = path(cfg$lpj_input_folder, gsub("-",     "/", cfg$input)), input2_folder = path(cfg$additional_input_folder,     paste("rev", floor(cfg$revision), sep = "")), output_file = lpj2magpie_file,     rev = cfg$revision, land_input = cfg$land_input)
*
* aggregation settings:
* * Input resolution: 0.5
* * Output resolution: n200
* * Input file: /p/projects/landuse/data/input/archive/GLUES2-sresa2-constant_co2-miub_echo_g_ERB_rev22.1_0.5.tgz
* * Output file: /p/projects/landuse/data/input/archive/GLUES2-sresa2-constant_co2-miub_echo_g_ERB_rev22.1_n200_690d3718e151be1b450b394c1064b1c5.tgz
* * Regionscode: 690d3718e151be1b450b394c1064b1c5
* * (clustering) n-repeat: 5
* * (clustering) n-redistribute: 0
* * Call: aggregation(input_file = paste0(cfg$base_folder, "/", set_folder,     "_", cfg$high_res, ".tgz"), regionmapping = paste0("../",     cfg$regionmapping), output_file = aggregation_file, rev = cfg$revision,     res_high = cfg$high_res, res_low = cfg$low_res, hcells = cfg$highres_cells,     nrepeat = cfg$nrepeat, nredistribute = cfg$nredistribute,     sum_spam_file = NULL, debug = FALSE)
*
*
*
* Last modification (input data): Fri Feb 17 15:38:04 2017
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

$setglobal c_timesteps  11

scalars sm_use_gdx   use of gdx files                                      / 2 /
        sm_maxiter   maximal solve iterations if modelstat is > 2        / 100 /
        s_maxdiff    max diff between lp and nlp solution  (mio. USD)   / 1000 /
;
********************************************************************************

*******************************MODULE SETUP*************************************

$setglobal land  feb15
$setglobal costs  default
$setglobal interest_rate  glo_jan16
$setglobal tc  endo_JUN16
$setglobal yields  biocorrect

$setglobal food  exo_flexreg_apr16
$setglobal demand  sector_may15
$setglobal production  flexreg_apr16

$setglobal residues  off
$setglobal processing  off

$setglobal trade  selfsuff_flexreg_dev

$setglobal crop  endo_jun13
$setglobal past  endo_jun13
$setglobal forestry  static_sep16
$setglobal forest  endo_threshold_aug15
$setglobal urban  static
$setglobal other  endo_threshold_aug15
$setglobal land_tax  off_jul16

$setglobal factor_costs  mixed_feb17
$setglobal landconversion  gdp_scaled_jun13

$setglobal transport  gtap_nov12
$setglobal area_equipped_for_irrigation  endo_apr13
$setglobal water_demand  agr_sector_aug13
$setglobal water_availability  total_water_aug13
$setglobal climate  static

$setglobal nr_soil_budget  exoeff_aug16
$setglobal nitrogen  ipcc2006_sep16
$setglobal carbon  normal_sep16
$setglobal methane  ipcc2006_flexreg_apr16
$setglobal phosphorus  off
$setglobal awms  ipcc2006_aug16
$setglobal ghg_policy  price_sep16
$setglobal maccs  on_sep16
$setglobal carbon_removal  off_sep16
$setglobal som  off

$setglobal bioenergy  standard_flexreg_apr16
$setglobal material  exo_flexreg_apr16
$setglobal livestock  fbask_jan16

$setglobal optimization  lp_nlp_glo_jan15

$setglobal presolve  off

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

magpie.optfile   = 0 ;
magpie.scaleopt  = 1 ;
magpie.solprint  = 0 ;
magpie.holdfixed = 1 ;

option lp         = cplex ;
option qcp        = cplex ;
option nlp        = conopt ;
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