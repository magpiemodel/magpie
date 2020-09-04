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
* Used data set: rev4.47+mrmagpie6_h12_magpie_debug.tgz
* md5sum: a2f0ad10977ca0738c4b535c09607aa2
* Repository: /p/projects/rd3mod/inputdata/output
* 
* Used data set: rev4.47+mrmagpie6_h12_238dd4e69b15586dde74376b6b84cdec_cellularmagpie_debug.tgz
* md5sum: 4467a28886c312832597d3991b8724fa
* Repository: /p/projects/rd3mod/inputdata/output
* 
* Used data set: rev4.47+mrmagpie6_h12_validation_debug.tgz
* md5sum: 26d72a9ca2d542ed985fdd609ccc27a4
* Repository: /p/projects/rd3mod/inputdata/output
* 
* Used data set: calibration_H12_c200_26Feb20.tgz
* md5sum: NA
* Repository: https://rse.pik-potsdam.de/data/magpie/public
* 
* Used data set: additional_data_rev3.85.tgz
* md5sum: NA
* Repository: https://rse.pik-potsdam.de/data/magpie/intern
* 
* Low resolution: c200
* High resolution: 0.5
* 
* Total number of cells: 200
* 
* Number of cells per region:
*   SSA  MEA  OAS  CHA  IND  REF  NEU  EUR  LAM  USA  CAZ  JPN
*    42   24   17   22    7   11    6    3   33    7   26    2
* 
* Regionscode: 690d3718e151be1b450b394c1064b1c5
* 
* Regions data revision: 4.47
* 
* lpj2magpie settings:
* * LPJmL data: HadGEM2_ES:rcp2p6:co2
* * Revision: 4.47
* 
* aggregation settings:
* * Input resolution: 0.5
* * Output resolution: c200
* * Regionscode: 690d3718e151be1b450b394c1064b1c5
* * Call: (function (rev = 0.1, dev = "", ctype = "c200", climatetype = "HadGEM2_ES:rcp2p6:co2",     clusterweight = NULL) {    sizelimit <- getOption("magclass_sizeLimit")    options(magclass_sizeLimit = 1e+10)    on.exit(options(magclass_sizeLimit = sizelimit))    setConfig(debug = TRUE)    mag_years_past_short <- c("y1995", "y2000", "y2005", "y2010")    mag_years_past_long <- c("y1995", "y2000", "y2005", "y2010",         "y2015")    mag_years <- findset("time")    short_years <- findset("t_all")    lpj_years <- seq(1995, 2100, by = 5)    climatetype = "HadGEM2_ES:rcp2p6:co2"    harmonize_baseline = "CRU_4"    ref_year = "y2015"    map <- calcOutput("Cluster", ctype = ctype, weight = clusterweight,         aggregate = FALSE)    weightID <- ifelse(is.null(clusterweight), "", paste0("_",         names(clusterweight), clusterweight, collapse = ""))    clustermapname <- sub("\\.[^.]*$", ".rds", paste0("clustermap_rev",         rev, dev, "_", ctype, weightID, "_", getConfig("regionmapping")))    toolStoreMapping(map, clustermapname, type = "regional",         where = c("mappingfolder", "outputfolder"), error.existing = FALSE)    setConfig(extramappings = clustermapname)    calcOutput("Yields", version = "LPJmL5", climatetype = climatetype,         time = "spline", dof = 4, harmonize_baseline = harmonize_baseline,         ref_year = ref_year, aggregate = FALSE, years = "y1995",         file = paste0("lpj_yields_0.5.mz"))    calcOutput("Yields", version = "LPJmL5", climatetype = climatetype,         time = "spline", dof = 4, harmonize_baseline = harmonize_baseline,         ref_year = ref_year, aggregate = "cluster", years = lpj_years,         file = paste0("lpj_yields_", ctype, ".mz"))    calcOutput("GCMClimate", aggregate = "cluster", file = paste0("rcp85.HadGEM2.temperature_",         ctype, ".mz"), GCMModel = "HadGEM2", ClimateVariable = "temperature",         rcp = "rcp85")    calcOutput("GCMClimate", aggregate = "cluster", file = paste0("rcp85.HadGEM2.precipitation_",         ctype, ".mz"), GCMModel = "HadGEM2", ClimateVariable = "precipitation",         rcp = "rcp85")    calcOutput("GCMClimate", aggregate = "cluster", file = paste0("rcp85.HadGEM2.longwave_radiation_",         ctype, ".mz"), GCMModel = "HadGEM2", ClimateVariable = "longwave_radiation",         rcp = "rcp85")    calcOutput("GCMClimate", aggregate = "cluster", file = paste0("rcp85.HadGEM2.shortwave_radiation_",         ctype, ".mz"), GCMModel = "HadGEM2", ClimateVariable = "shortwave_radiation",         rcp = "rcp85")    calcOutput("GCMClimate", aggregate = "cluster", file = paste0("rcp85.HadGEM2.wetdays_",         ctype, ".mz"), GCMModel = "HadGEM2", ClimateVariable = "wetdays",         rcp = "rcp85")    calcOutput("CO2Atmosphere", aggregate = "cluster", file = paste0("calcCO2Atmosphere_",         ctype, ".mz"), rcp = "rcp85", level = "cellular")    calcOutput("SoilCharacteristics", aggregate = "cluster",         file = paste0("SoilCharacteristics_", ctype, ".mz"))    calcOutput("ClimateClass", aggregate = "cluster", years = "y2015",         file = paste0("koeppen_geiger_", ctype, ".mz"))    calcOutput("LanduseInitialisation", aggregate = FALSE, cellular = TRUE,         land = "landmatrix_dec18", input_magpie = TRUE, selectyears = mag_years_past_long,         round = 6, file = "avl_land_t_0.5.mz")    calcOutput("LanduseInitialisation", aggregate = "cluster",         cellular = TRUE, land = "landmatrix_dec18", input_magpie = TRUE, selectyears = mag_years_past_long,         round = 6, file = paste0("avl_land_t_", ctype, ".mz"))    calcOutput("SeaLevelRise", aggregate = FALSE, cellular = TRUE,         years = mag_years, round = 6, file = "f10_SeaLevelRise_0.5.mz")    calcOutput("AvlLandSi", aggregate = FALSE, round = 6, file = "avl_land_si_0.5.mz")    calcOutput("AvlLandSi", aggregate = "cluster", round = 6,         file = paste0("avl_land_si_", ctype, ".mz"))    calcOutput("Croparea", sectoral = "kcr", physical = TRUE,         cellular = TRUE, irrigation = FALSE, aggregate = "cluster",         file = paste0("f30_croparea_initialisation_", ctype,             ".mz"))    calcOutput("Croparea", sectoral = "kcr", physical = TRUE,         cellular = TRUE, irrigation = TRUE, aggregate = "cluster",         file = paste0("f30_croparea_w_initialisation_", ctype,             ".mz"))    calcOutput("AfforestationMask", subtype = "noboreal", aggregate = "cluster",         round = 6, file = paste0("aff_noboreal_", ctype, ".mz"))    calcOutput("AfforestationMask", subtype = "onlytropical",         aggregate = "cluster", round = 6, file = paste0("aff_onlytropical_",             ctype, ".mz"))    calcOutput("AfforestationMask", subtype = "unrestricted",         aggregate = "cluster", round = 6, file = paste0("aff_unrestricted_",             ctype, ".mz"))    calcOutput("NpiNdcAdAolcPol", aggregate = "cluster", round = 6,         file = paste0("npi_ndc_ad_aolc_pol_", ctype, ".mz"))    calcOutput("NpiNdcAffPol", aggregate = "cluster", round = 6,         file = paste0("npi_ndc_aff_pol_", ctype, ".mz"))    calcOutput("AgeClassDistribution", aggregate = "cluster",         round = 6, file = paste0("secdf_age_class_dist_", ctype,             ".mz"))    calcOutput("ProtectArea", aggregate = "cluster", round = 6,         file = paste0("protect_area_", ctype, ".mz"))    calcOutput("UrbanLandFuture", aggregate = FALSE, round = 6,         years = short_years, file = "f34_UrbanLand_0.5.mz")    calcOutput("UrbanLandFuture", aggregate = "cluster", round = 6,         years = short_years, file = paste0("f34_UrbanLand_",             ctype, ".mz"))    calcOutput("TransportDistance", aggregate = "cluster", round = 6,         file = paste0("transport_distance_", ctype, ".mz"))    calcOutput("AreaEquippedForIrrigation", aggregate = "cluster",         cellular = TRUE, source = "Siebert", round = 6, file = paste0("avl_irrig_",             ctype, ".mz"))    calcOutput("AreaEquippedForIrrigation", aggregate = "cluster",         cellular = TRUE, source = "LUH2v2", selectyears = mag_years_past_long,         round = 6, file = paste0("avl_irrig_luh_t_", ctype, ".mz"))    calcOutput("Irrigation", version = "LPJmL5", years = lpj_years,         climatetype = climatetype, harmonize_baseline = harmonize_baseline,         ref_year = ref_year, time = "spline", dof = 4, aggregate = "cluster",         round = 6, file = paste0("lpj_airrig_", ctype, ".mz"))    calcOutput("EnvmtlFlow", version = "LPJmL4", years = lpj_years,         climatetype = climatetype, harmonize_baseline = harmonize_baseline,         ref_year = ref_year, time = "spline", dof = 4, aggregate = "cluster",         round = 6, seasonality = "grper", file = paste0("lpj_envflow_grper_",             ctype, ".mz"))    calcOutput("NonAgWaterDemand", source = "WATCH_ISIMIP_WATERGAP",         years = lpj_years, seasonality = "grper", aggregate = "cluster",         file = "watdem_nonagr_grper_c200.mz")    calcOutput("NonAgWaterDemand", source = "WATERGAP2020", years = lpj_years,         seasonality = "grper", waterusetype = "withdrawal", aggregate = "cluster",         file = paste0("watdem_nonagr_ww_grper_", ctype, ".mz"))    calcOutput("NonAgWaterDemand", source = "WATERGAP2020", years = lpj_years,         seasonality = "grper", waterusetype = "consumption",         aggregate = "cluster", file = paste0("watdem_nonagr_wc_grper_",             ctype, ".mz"))    calcOutput("AvlWater", version = "LPJmL4", years = lpj_years,         climatetype = climatetype, harmonize_baseline = harmonize_baseline,         ref_year = ref_year, time = "spline", dof = 4, seasonality = "grper",         aggregate = "cluster", round = 6, file = paste0("lpj_watavail_grper_",             ctype, ".mz"))    calcOutput("Luh2SideLayers", aggregate = "cluster", round = 6,         file = paste0("luh2_side_layers_", ctype, ".mz"))    calcOutput("RRLayer", aggregate = "cluster", round = 6, file = paste0("rr_layer_",         ctype, ".mz"))    calcOutput("AtmosphericDepositionRates", cellular = TRUE,         aggregate = FALSE, round = 6, file = "f50_AtmosphericDepositionRates_0.5.mz")    calcOutput("NitrogenFixationRateNatural", aggregate = FALSE,         round = 6, file = "f50_NitrogenFixationRateNatural_0.5.mz")    calcOutput("AtmosphericDepositionRates", cellular = TRUE,         aggregate = "cluster", round = 6, file = paste0("f50_AtmosphericDepositionRates_",             ctype, ".mz"))    calcOutput("NitrogenFixationRateNatural", aggregate = "cluster",         round = 6, file = paste0("f50_NitrogenFixationRateNatural_",             ctype, ".mz"))    calcOutput("Carbon", aggregate = FALSE, version = "LPJmL4+5",         climatetype = climatetype, harmonize_baseline = harmonize_baseline,         ref_year = ref_year, time = "spline", dof = 4, round = 6,         years = "y1995", file = "lpj_carbon_stocks_0.5.mz")    calcOutput("TopsoilCarbon", aggregate = FALSE, version = "LPJmL4",         climatetype = climatetype, harmonize_baseline = harmonize_baseline,         ref_year = ref_year, time = "spline", dof = 4, round = 6,         years = "y1995", file = "lpj_carbon_topsoil_0.5.mz")    calcOutput("Carbon", aggregate = "cluster", version = "LPJmL4+5",         climatetype = climatetype, harmonize_baseline = harmonize_baseline,         ref_year = ref_year, time = "spline", dof = 4, round = 6,         years = lpj_years, file = paste0("lpj_carbon_stocks_",             ctype, ".mz"))    calcOutput("TopsoilCarbon", aggregate = "cluster", version = "LPJmL4",         climatetype = climatetype, harmonize_baseline = harmonize_baseline,         ref_year = ref_year, time = "spline", dof = 4, round = 6,         years = lpj_years, file = paste0("lpj_carbon_topsoil_",             ctype, ".mz"))    calcOutput("SOMinitialsiationPools", aggregate = "cluster",         round = 6, file = paste0("f59_som_initialisation_pools_",             ctype, ".mz"))    calcOutput("SOCLossShare", aggregate = "cluster", rate = "loss",         round = 6, years = "y1995", file = paste0("cshare_released_",             ctype, ".mz"))    writeInfo <- function(file, lpjml_data, res_high, res_out,         rev) {        functioncall <- paste(deparse(sys.call(-1)), collapse = "")        map <- toolMappingFile("regional", getConfig("regionmapping"),             readcsv = TRUE)        regionscode <- regionscode(map)        info <- c("lpj2magpie settings:", paste("* LPJmL data:",             lpjml_data), paste("* Revision:", rev), "", "aggregation settings:",             paste("* Input resolution:", res_high), paste("* Output resolution:",                 res_out), paste("* Regionscode:", regionscode),             paste("* Call:", functioncall))        base::cat(info, file = file, sep = "\n")    }    writeInfo(file = paste0(getConfig("outputfolder"), "/info.txt"),         lpjml_data = climatetype, res_high = "0.5", res_out = ctype,         rev = rev)})(rev = structure(list(c(4L, 47L)), class = "numeric_version"),     dev = "+mrmagpie6", ctype = "c200", climatetype = "HadGEM2_ES:rcp2p6:co2")
* 
* 
* Last modification (input data): Thu Sep  3 15:54:51 2020
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
$setglobal c_title  default

scalars
s_use_gdx   use of gdx files                                       / 2 /
;
********************************************************************************

*******************************MODULE SETUP*************************************

$setglobal drivers  aug17
$setglobal land  landmatrix_dec18
$setglobal costs  default
$setglobal interest_rate  select_apr20
$setglobal tc  endo_jun18
$setglobal yields  managementcalib_aug19

$setglobal food  anthropometrics_jan18
$setglobal demand  sector_may15
$setglobal production  flexreg_apr16

$setglobal residues  flexreg_apr16
$setglobal processing  substitution_dec18

$setglobal trade  selfsuff_reduced

$setglobal crop  endo_jun13
$setglobal past  endo_jun13

$setglobal forestry  static_sep16

$setglobal urban  static
$setglobal natveg  dynamic_may20

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
$setglobal maccs  on_sep16
$setglobal peatland  off
$setglobal som  static_jan19

$setglobal bioenergy  1stgen_priced_dec18
$setglobal material  exo_flexreg_apr16
$setglobal livestock  fbask_jan16

$setglobal disagg_lvst  foragebased_aug18

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
