*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$title empty_test_standalone

*##################### R SECTION START (VERSION INFO) ##########################
* 
* Used data set: rev4.77_h12_magpie.tgz
* md5sum: f0fb0888f1f711442377a380887dbbfa
* Repository: /p/projects/rd3mod/mirror/rse.pik-potsdam.de/data/magpie/public
* 
* Used data set: rev4.77_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz
* md5sum: fe9ad2782602695b706836e84f6b569f
* Repository: /p/projects/rd3mod/mirror/rse.pik-potsdam.de/data/magpie/public
* 
* Used data set: rev4.77_h12_validation.tgz
* md5sum: 7bb2104776a43e1f1293f50d08e20877
* Repository: /p/projects/rd3mod/mirror/rse.pik-potsdam.de/data/magpie/public
* 
* Used data set: additional_data_rev4.32.tgz
* md5sum: 721ffbc57edddfb5e9b76546c51906f2
* Repository: /p/projects/rd3mod/mirror/rse.pik-potsdam.de/data/magpie/public
* 
* Used data set: calibration_H12+ir2rf_05Oct22.tgz
* md5sum: 788b8e32ea1bd83c5c8f8987d9f05265
* Repository: /p/projects/rd3mod/mirror/rse.pik-potsdam.de/data/magpie/public
* 
* Low resolution: c200
* High resolution: 0.5
* 
* Total number of cells: 200
* 
* Number of cells per region:
*   CAZ  CHA  EUR  IND  JPN  LAM  MEA  NEU  OAS  REF  SSA  USA
*     6   23    7    6    1   43   27    7   11   12   37   20
* 
* Regionscode: 62eff8f7
* 
* Regions data revision: 4.77
* 
* lpj2magpie settings:
* * LPJmL data: MRI-ESM2-0:ssp370
* * Revision: 4.77
* 
* aggregation settings:
* * Input resolution: 0.5
* * Output resolution: c200
* * Regionscode: 62eff8f7
* * Number of clusters per region:
*   CAZ  CHA  EUR  IND  JPN  LAM  MEA  NEU  OAS  REF  SSA  USA
*     6   23    7    6    1   43   27    7   11   12   37   20
* * Call: withCallingHandlers(expr, message = messageHandler, warning = warningHandler,     error = errorHandler)
* 
* 
* Last modification (input data): Wed Nov 16 17:14:42 2022
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
$setglobal c_past  till_2010
$setglobal c_title  empty_model

scalars
s_use_gdx   use of gdx files                                       / 2 /
;
********************************************************************************

*******************************MODULE SETUP*************************************

$setglobal drivers  aug17
$setglobal land  landmatrix_dec18
$setglobal costs  default
$setglobal interest_rate  select_apr20
$setglobal tc  endo_jan22
$setglobal yields  managementcalib_aug19

$setglobal food  anthro_iso_jun22
$setglobal demand  sector_may15
$setglobal production  flexreg_apr16

$setglobal residues  flexreg_apr16
$setglobal processing  substitution_may21

$setglobal trade  selfsuff_reduced
$setglobal land_conservation  area_based_apr22

$setglobal ageclass  feb21

$setglobal crop  endo_apr21
$setglobal past  endo_jun13

$setglobal forestry  dynamic_feb21

$setglobal urban  exo_nov21
$setglobal natveg  dynamic_feb21

$setglobal employment  exo_may22
$setglobal labor_prod  off
$setglobal factor_costs  per_ton_fao_may22
$setglobal landconversion  calib

$setglobal transport  gtap_nov12
$setglobal area_equipped_for_irrigation  endo_apr13
$setglobal water_demand  all_sectors_aug13
$setglobal water_availability  total_water_aug13
$setglobal biodiversity  bii_target
$setglobal climate  static

$setglobal nr_soil_budget  macceff_aug22
$setglobal nitrogen  rescaled_jan21
$setglobal carbon  normal_dec17
$setglobal methane  ipcc2006_aug22
$setglobal phosphorus  off
$setglobal awms  ipcc2006_aug16
$setglobal ghg_policy  price_aug22
$setglobal maccs  on_aug22
$setglobal peatland  on
$setglobal som  static_jan19

$setglobal bioenergy  1stgen_priced_dec18
$setglobal material  exo_flexreg_apr16
$setglobal livestock  fbask_jan16

$setglobal disagg_lvst  foragebased_aug18

$setglobal timber  default

$setglobal optimization  nlp_apr17

$setglobal c_input_gdx_path  /p/projects/landuse/tests/magpie/output/default_2022-12-30_00.04.43/fulldata.gdx

****************************END MODULE SETUP************************************

***********************TEST USING EMPTY MODEL***********************************
*** empty model just uses input gdx as the result
*** rest of the model is compiled, but not executed
execute "cp %c_input_gdx_path% fulldata.gdx";
abort.noerror "cp %c_input_gdx_path% fulldata.gdx";
********************************************************************************

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
