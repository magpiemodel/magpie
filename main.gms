*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$title magpie

*' @title MAgPIE - Modelling Framework
*'
*' @description The *Model of Agricultural Production and its Impact on the
*' Environment* (MAgPIE) is developed and used to assess the competition for
*' land and water and the associated consequences for sustainable development
*' under future scenarios of rising food, energy and material demand as well
*' as production, climate change impacts and greenhouse gas mitigation and
*' different land related policies (@dietrich_magpie4).
*'
*' MAgPIE is a global partial equilibrium model of the land-use sector that operates
*' in a recursive dynamic mode and incorporates spatially explicit information on
*' biophysical constraints into an economic decision making process (@lotze-campen_global_2008).
*' It takes regional economic conditions such as elastic demand for agricultural commodities,
*' technological development and production costs as well as spatially explicit data on biophysical
*' constraints into account. Geographically explicit data on biophysical conditions are provided
*' by the Lund-Potsdam-Jena managed land model (LPJmL) (@bondeau_lpjml_2007, @mueller_projecting_2014)
*' on a 0.5 degree resolution and include e.g. carbon densities of different vegetation types,
*' agricultural productivity such as crop yields and water availability for irrigation. Based on
*' the strong interaction with LPJmL, MAgPIE can also help to assess the consequences of climate
*' change and increased CO2 in the atmosphere on the land-use sector (@stevanovic_impact_2016)
*'
*' Available land types in MAgPIE are cropland, pasture area, forest, other land
*' (including non-forest natural vegetation, abandoned agricultural land and deserts)
*' and settlements. Cropland (rainfed and irrigated), pasture, forest and other land
*' are endogenously determined, while settlement areas are assumed to be constant over time.
*' The cropland covers cultivation of different crop types (e.g. temperate and tropical
*' cereals, maize, rice, oilseeds, roots), both rainfed and irrigated systems, and two
*' 2nd generation bioenergy crop types (grassy and woody).
*'
*' Taking into account international trade based on historical trade patterns and economic
*' competitiveness ([21_trade]), global production has to meet demand for food,
*' feed, seed, processing, bioenergy and material demand ([16_demand]). Food demand is
*' derived based on population growth ([09_drivers]) and dietary transitions, accounting
*' for changes in intake and food waste, the shift in the share of animal calories,
*' processed products, fruits and vegetables as well as staples ([15_food]).
*' Primary products can be processed to secondary products such as sugar, oil
*' or ethanol ([20_processing]). The quantity of livestock production in
*' combination with dynamic regional and livestock-specific feed baskets determines the
*' demand for feed ([70_livestock]). The supply of animal-based food commodities is divided into five livestock production
*' activities (ruminant meat, pig meat, poultry meat, eggs and milk) (@weindl_livestock_2017-1).
*' The spatial distribution of crops ([30_crop]), livestock ([71_disagg_lvst])
*' and pasture ([31_past]) in MAgPIE is guided by geographically explicit
*' information on vegetation growth and the balance between crop water
*' demand and water availability, by initial land cover distribution maps
*' as well as by economic conditions like trade barriers ([21_trade]), management intensity ([13_tc])
*' and transport costs ([40_transport]). It therefore integrates information about market access into
*' the model's optimization process that determines where cropping activities and livestock production
*' are allocated to. Parts of forests and other natural land area can be excluded from conversion into
*' agricultural land if designated for wood production or located in protected areas ([32_forestry],
*' [35_natveg]) (@kreidenweis_pasture_2018).
*'
*' Due to computational constraints, all model inputs in 0.5 degree resolution are aggregated
*' to simulation units for the optimization process ([80_optimization]) based on a clustering
*' algorithm (@dietrich_reducing_2013).
*'
*' MAgPIE estimates flows of different land-based greenhouse gases (GHGs). CO2 emissions are computed
*' from land-use change dynamics, i.e. from conversion of different biomes into agricultural land
*' and consequent loss of terrestrial carbon stocks (@popp_land-use_2014), also including the
*' depletion of organic matter in soils ([59_som]). The land also serves as a sink for atmospheric
*' carbon when agricultural land is set aside from production and the associated regrowth of natural
*' vegetation generates negative emissions from land-use change.
*' Nitrogen emissions ([51_nitrogen]) are estimated based on nitrogen budgets for croplands,
*' pastures ([50_nr_budgets]) and the livestock sector ([55_awms]) (@bodirsky_reactive_2014).
*' CH4 emissions are based on
*' livestock feed and rice cultivation areas (@popp_food_2010). In the case of mitigation
*' policies for the land sector, the model can reduce CO2 emissions by restraining land-use
*' conversion and consequent carbon release as well as CH4 and N emissions by applying improved
*' agricultural management (such as anaerobic digesters for CH4 capture from animal waste, or use
*' of fertilizer spreaders) (@popp_land-use_2014, @stevanovic_mitigation_2017). In addition,
*' the model covers land-based carbon removal technologies such as bioenergy with carbon capture
*' and sequestration (CCS) and afforestation (@humpenoder_investigating_2014,
*' @humpenoder_large-scale_2017, @kreidenweis_afforestation_2016).
*'
*' In response to all involved demand for agricultural commodities, costs of production,
*' biophysical constraints and land-related policies, MAgPIE simulates major dynamics of
*' the land-use sector like investments in research and development (R&D) ([13_tc]) (@dietrich_forecasting_2014)
*' and associated increases in both crop yields  ([14_yields]) and biomass removal through grazing on
*' pastures ([31_past]), land use change ([39_landconversion]), interregional trade flows ([21_trade]),
*' and irrigation ([41_area_equipped_for_irrigation]).




*##################### R SECTION START (VERSION INFO) ##########################
*
* Used data set: magpie4.1_default_apr19.tgz
* md5sum: 5c38bb1083bd66010c2104c9d40553f4
* Repository: /p/projects/rd3mod/mirror/rse.pik-potsdam.de/data/magpie/public
*
* Used data set: additional_data_rev3.68.tgz
* md5sum: 15d1135625a9f5cfb9c7c6038716a156
* Repository: /p/projects/rd3mod/mirror/rse.pik-potsdam.de/data/magpie/public
*
* Used data set: isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz
* md5sum: e0cb64c918128436bf9a323e57cae81b
* Repository: /p/projects/rd3mod/mirror/rse.pik-potsdam.de/data/magpie/public
*
* Used data set: private_forestry_dec18_20190827.tgz
* md5sum: d037293230e2b20792924ba903ffb364
* Repository: /p/projects/landuse/users/mishra/additional_data_private_forestry
*
* Low resolution: c200
* High resolution: 0.5
*
* Total number of cells: 200
*
* Number of cells per region:
*   CAZ  CHA  EUR  IND  JPN  LAM  MEA  NEU  OAS  REF  SSA  USA
*    28   24   10    7    3   53   17    8   22    7   11   10
*
* Regionscode: 690d3718e151be1b450b394c1064b1c5
*
* Regions data revision: 4.18
*
* lpj2magpie settings:
* * LPJmL data folder: /p/projects/landuse/data/input/lpj_input/isimip_rcp/IPSL_CM5A_LR/rcp2p6/co2
* * Additional input folder: /p/projects/landuse/data/input/other/rev38
* * Revision: 38
* * Call: lpj2magpie(input_folder = path(cfg$lpj_input_folder, gsub("-",     "/", cfg$input)), input2_folder = path(cfg$additional_input_folder,     paste("rev", floor(cfg$revision), sep = "")), output_file = lpj2magpie_file,     rev = cfg$revision)
*
* aggregation settings:
* * Input resolution: 0.5
* * Output resolution: c200
* * Input file: /p/projects/landuse/data/input/archive/isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev38_0.5.tgz
* * Output file: /p/projects/landuse/data/input/archive/isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz
* * Regionscode: 690d3718e151be1b450b394c1064b1c5
* * (clustering) n-repeat: 5
* * (clustering) n-redistribute: 0
* * Call: aggregation(input_file = lpj2magpie_file, regionmapping = paste0("../",     cfg$regionmapping), output_file = aggregation_file, rev = cfg$revision,     res_high = cfg$high_res, res_low = cfg$low_res, hcells = cfg$highres_cells,     weight = cfg$cluster_weight, nrepeat = cfg$nrepeat, nredistribute = cfg$nredistribute,     sum_spam_file = cfg$spamfile, debug = FALSE, seed = cfg$seed)
*
*
*
* Last modification (input data): Sun Sep 15 11:20:29 2019
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

$setglobal c_timesteps  5year

scalars
  s_use_gdx   use of gdx files                                       / 2 /
;
********************************************************************************

*******************************MODULE SETUP*************************************

$setglobal drivers  aug17
$setglobal land  landmatrix_dec18
$setglobal costs  default
$setglobal interest_rate  reg_feb18
$setglobal tc  endo_jun18
$setglobal yields  dynamic_aug18

$setglobal food  anthropometrics_jan18
$setglobal demand  sector_dec18
$setglobal production  flexreg_apr16

$setglobal residues  flexreg_apr16
$setglobal processing  substitution_dec18

$setglobal trade  selfsuff_reduced_ff
$setglobal timber  exo_sep19

$setglobal crop  endo_jun13
$setglobal past  endo_jun13
$setglobal forestry  dynamic_dec18
$setglobal urban  static
$setglobal natveg  dynamic_dec18

$setglobal factor_costs  mixed_feb17
$setglobal landconversion  global_static_aug18

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
$setglobal ghg_policy  price_jan19
$setglobal maccs  on_sep16
$setglobal som  static_jan19

$setglobal bioenergy  1stgen_priced_dec18
$setglobal material  exo_flexreg_apr16
$setglobal livestock  fbask_jan16
$setglobal disagg_lvst  foragebased_aug18

$setglobal optimization  nlp_apr17

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
