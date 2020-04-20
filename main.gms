*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
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
*'
*' The MAgPIE GAMS code folllows the coding etiquette as described below.
*'
*' Use the following prefixes:
*'
*'  *  q_ eQuations
*'  *  v_ Variables
*'  *  s_ Scalars
*'  *  f_ File parameters - these parameters contain data as it was read from file
*'  *  i_ Input parameters - influencing the optimzation but are not influenced by it
*'  *  p_ Processing parameters - influencing optimization and are being influenced by it
*'  *  o_ Output parameters - only being influenced by optimization but without effect on the optimization
*'  *  x_ eXtremely important output parameters - output parameters, that are necessary for the model to run properly (required by external postprocessing). They must not be removed.
*'  *  c_ switches from the Config.gms - parameters, that are switches to choose different scenarios
*'  *  m_ Macros
*'
*' The prefixes have to be extended in some cases by a second letter
*'
*'  * ?m_ module-relevant object - This object is used by at least one module and the core code. Changes related to this object have to be performed carefully.
*'  * ?00_ (a 2-digit number) module-only object This 2-digit number defines the module the object belongs to. The number is used here to make sure that different modules cannot have the same object
*'
*' Sets
*'
*' Sets are treated slightly different: Instead of adding a prefix sets should get a 2-digit number suffix giving the number
*' of the module in which the set is exclusively used. If the set is used in more than one module no suffix should be given.
*'
*' The prefixes have to be extended by a second letter in some more cases
*'
*'  * ?c_ value for the Current timestep - necessary for constraints. Each *c_-object must have a time-depending counterpart
*'  * ?q_ parameter containing the values of an equation
*'  * ?v_ parameter containing the values of a variable
*'
*' Besides prefixes also suffixes should be used. Suffixes should indicate the level of aggregation of an object:
*'
*'  * (no suffix) highest disaggregation available
*'  * _(setname) aggregation over set
*'  * _reg regional aggregation (exception)
*'  * _glo global aggregation (exception)
*'
*' Units
*'
*'  * Document units at the location of the variable declaration
*'  * Use units that lead to variable values in the range of 0.01 to 100. Keep the option of scaling in mind.
*'  * Use only MAgPIE standard units in GAMS code 10^6, 10^6 ha, 10^6 tDM, 10^6 PJ, 10^6 USD, 10^6 m3
*'  * Make sure that your inputs already have the right unit
*'
*' Input files
*'
*'  * Input file names must be unique, because input files will be downloaded from a data repository and extracted to the same folder so that different files with the same file name would overwrite each other.
*'  * Do not add input files to the git repository. Input files should be copied instead to one of the existing data repositories from which the data is downloaded by the model.
*'
*' Postprocessing
*'
*'  * Processing of model outputs is managed in the corresponding magpie R package (e.g. package "magpie4" for MAgPIE version 4.x).
*'  * If you change something in the GAMS code make sure that all function in the corresponding magpie R package still work and adapt them if necessary to the new model structure.
*'  * When performing modifications in a magpie R package make sure that these changes are downwards compatible.
*'  * Always try to access model outputs through the corresponding magpie package instead of accessing them directly with readGDX. It cannot be guaranteed that your script will work in the future if you do otherwise (as only the corresponding magpie package will be continuously adapted to changes in the GAMS code).

*##################### R SECTION START (VERSION INFO) ##########################
*
* Used data set: magpie4.2_default_apr20.tgz
* md5sum: NA
* Repository: https://rse.pik-potsdam.de/data/magpie/public
*
* Used data set: private_forestry_dec18_20200312.tgz
* md5sum: NA
* Repository: scp://cluster.pik-potsdam.de/p/projects/landuse/users/mishra/additional_data_private_forestry
*
* Used data set: coupling_co2_prices_apr20.tgz
* md5sum: NA
* Repository: scp://cluster.pik-potsdam.de/p/projects/magpie/users/mishra/projects/coupling
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
* Regions data revision: 4.42
*
* lpj2magpie settings:
* * LPJmL data folder: /p/projects/landuse/data/input/lpj_input/isimip_rcp/IPSL_CM5A_LR/rcp2p6/co2
* * Additional input folder: /p/projects/landuse/data/input/other/rev42
* * Revision: 42
* * Call: lpj2magpie(input_folder = path(cfg$lpj_input_folder, gsub("-",     "/", cfg$input)), input2_folder = path(cfg$additional_input_folder,     paste("rev", floor(cfg$revision), sep = "")), output_file = lpj2magpie_file,     rev = cfg$revision)
*
* aggregation settings:
* * Input resolution: 0.5
* * Output resolution: c200
* * Input file: /p/projects/landuse/data/input/archive/isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev42_0.5.tgz
* * Output file: /p/projects/landuse/data/input/archive/isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev42_c200_690d3718e151be1b450b394c1064b1c5.tgz
* * Regionscode: 690d3718e151be1b450b394c1064b1c5
* * (clustering) n-repeat: 5
* * (clustering) n-redistribute: 0
* * Call: aggregation(input_file = lpj2magpie_file, regionmapping = paste0("../",     cfg$regionmapping), output_file = aggregation_file, rev = cfg$revision,     res_high = cfg$high_res, res_low = cfg$low_res, hcells = cfg$highres_cells,     weight = cfg$cluster_weight, nrepeat = cfg$nrepeat, nredistribute = cfg$nredistribute,     sum_spam_file = cfg$spamfile, debug = FALSE, seed = cfg$seed)
*
*
*
* Last modification (input data): Thu Apr 16 22:18:08 2020
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
$setglobal c_title  SSP2_rev42_rev4p37

scalars
  s_use_gdx   use of gdx files                                       / 2 /
;
********************************************************************************

*******************************MODULE SETUP*************************************

$setglobal drivers  aug17
$setglobal land  feb15
$setglobal costs  default
$setglobal interest_rate  select_apr20
$setglobal tc  endo_jun18
$setglobal yields  dynamic_aug18

$setglobal food  anthropometrics_jan18
$setglobal demand  sector_may15
$setglobal production  flexreg_apr16

$setglobal residues  off
$setglobal processing  off

$setglobal trade  selfsuff_reduced

$setglobal crop  endo_jun13
$setglobal past  endo_jun13

$setglobal forestry  dynamic_faustmann

$setglobal urban  static
$setglobal natveg  dynamic_nov19

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
$setglobal ghg_policy  price_jan20
$setglobal maccs  off_jul16
$setglobal som  static_jan19

$setglobal bioenergy  1stgen_priced_dec18
$setglobal material  exo_flexreg_apr16
$setglobal livestock  fbask_jan16

$setglobal disagg_lvst  off

$setglobal timber  biomass_mar20

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
