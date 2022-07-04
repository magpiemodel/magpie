
# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [Unreleased]

### changed
- **config** Update of regional and grid inputs from 4.68 to rev4.69, and additional files to 4.17. Removed free/dynamic sticky switch, and added scalars used in mixed_regional factor costs realization.
- **11_costs** Split of production costs per sector, addded new separated costs to the costs function.
- **18_residues**  The variable that include production costs vm_cost_prod for residues changed to a new independent variable called vm_cost_prod_kres
(specific to residues).
- **31_past**  The variable that include production costs vm_cost_prod for pasture changed to a new independent variable called vm_cost_prod_past
(specific to past).
- **38_factor_costs** Sticky free/dynamic switch was removed and the realization was split into two realizations: the new per_ton_fao_may22 (free) and sticky_feb18 (dynamic). vm_cost_prod(i,kall) is now vm_cost_prod_crop(i,req) for crops factor costs. The results are now given differentiating between capital and labor for all realizations (new set req).
- **70_livestock** vm_cost_prod(i,kall) is now vm_cost_prod_livst(i,req) for livestock factor costs (req indicates differentiation between capital and labor) and vm_cost_prod_fish(i) for fish.
- **scripts** clean up of the recalibrate_realizations.R script, project_LAMACLIMA_WP4.R, and sticky.R to remove sticky dynamic/free switch.
- **scripts** bugfix in disaggregation.R, disaggregation_BII.R with respect to urban scenario
- **scripts** added FSEC modeling start script (global runs)
 - **config** added s13_max_gdp_shr setting for tech cost upper bound as share of GDP PPP
 - **13_tc** changed vm_tech_cost upper bound to share of regional GDP PPP (s13_max_gdp_shr)
 - **scripts** The disaggregation_LUH2.R was extended to include the changes used to generate ISIMIP3b maps for LUH harmonization. The largest changes are: 1) The convertLUH function now breaks the grid level magpie objects by groups of years, then creates the raster for the groups and aggregates them to create the final map at a quarter of a degree resolution (this speeds up the process). 2) The mapping between LUH and MAgPIE is now defined by country and magpie-LUH types (not 1 to 1 anymore). 3) The split of MAgPIE's pasture land type between pasture and rangeland changed. Rangeland is assumed to stay constant after 2015, and changes in MAgPIE's pasture are due to pasture. 4) IFs were added so if a certain map already exists in the output folder, it will not generate it once again. 5) Flooded land now corresponds to a share of rice cropland, based on historical values. 6) To speed calculations, yields are read at the cell level, the crops are aggregated based on the new MAgPIE-LUH mapping, and then disaggregated to grid level.
 - **56_ghg_policy** additional scenarios for c56_emis_policy
 - **09_drivers** separation of GDP and population scenarios
 - **scripts** added new disaggregation script to provide grid cell level BII
 - **inputs** updated non-agricultural water use scenarios (watdem_nonagr_grper.cs3)
 - **config** included switch for non-agricultural water demand (s42_watdem_nonagr_scenario) in scenario_config.csv
 - **config** included SHAPE SDP scenarios in scenario_config.csv
 - **config** Update default tau realization from endo_jan18 to endo_jan22
 - **config** Added new SSP scenario switch for pasture suitability cfg$gms$c31_past_suit_scen
 - **config** Added new switch to limiting calibration to relative or absolute managed pastures yields: cfg$gms$s31_limit_calib.
  - **13_tc** Replace endo_jan18 realization by endo_jan22. The new realization adds a new dimension to vm_tau separating crop from managed pastures tau.
 - **31_past** added new realization implementing the separation of rangelands and managed pastures for the production of grass biomass.
 - **15_food** added more options to define convergence towards exogenous food intake and waste scenarios accounting for different transition periods
 - **30_crop** renamed switch `s30_set_aside_shr`, `s30_set_aside_shr_noselect` and `c30_set_aside_target` to `s30_snv_shr`, `s30_snv_shr_noselect` and `c30_snv_target`.
 - **34_urban** added set urban_scen34 and the switch c34_urban_scenario
 - **35_natveg** corrected naming of Frontier Forests (FF) to Intact Forest Landscapes (IFL) and changed input data for BH_IFL implementation.
 - **scripts** replaced redundant files config.log and config.Rdata with a config.yml
 - **scripts** removed test script "irrig_dep_test" from "start" folder to "extra" folder
 - **scripts** Added script to folder projects paper_grassland.R
 - **44_biodiversity** Improved documentation, simplification of equations and flexible options for price on biodiversity loss
 - **35_natveg** implementation of land protection moved to new module `22_land_conservation`
 - **modules** Moved interface `vm_carbon_stock` from 52_carbon to 56_ghg_policy
 - **scripts** scripts/output/extra/emulator.R Remove dependency on deprecated R package "magpie"
 - **56_ghg_policy** Deactivated GHG emission policies were not accounted for in the MACCs module. This has been corrected by an extension of the interface `im_pollutant_prices`, which now has an additional dimension for emission sources `emis_source`. In this context some equations in `56_ghg_policy` have been simplified (sets: `emis_source_reg`, `emis_source_cell`). Also, GHG emissions from peatlands have been fully integrated into `56_ghg_policy`.
- **09_drivers** changed `i09_gdp_pc_mer_iso` to `im_gdp_pc_mer_iso`

### added
- **scripts** output/projects/FSEC_StevenLord.R to create output for Steven Lord in the FSEC context
- **scripts** output/projects/FSEC_costs.R to create costs ouput for the FSEC project
- **scripts** output/projects/FSEC_dietaryIndicators.R to create output datasets for the FSEC project
- **scripts** output/projects/FSEC_nitrogenPollution.R to create output datasets of nitrogen pollutants for the FSEC project
- **scripts** Added script to folder projects paper_grassland.R
- **scripts** Extended dissagregation.R script to replace single "past" land class by LHU range and pastr classes when grassland_apr22 realization is used.
- **52_carbon** added land carbon sink adjustment factors, needed in R post-processing
- **core** macros for linear and sigmoidal time interpolation
- **22_land_conservation** added new module and realisation for land conservation. The realisation also includes a new WDPA initialisation data set (from 1995 to 2020) for protected areas under legal protection, meeting IUCN and CBD protected area definitions. The module also adds the interface `pm_land_conservation`.
- **inputs** New input files added:
    f13_pastr_tau_hist.csv -> historical tau for managed pastures.
    f31_pastr_suitability.cs3 -> Managed pasture suitability
    f31_LUH2v2.cs3 -> LUH2v2 land classes separating rangelands from managed pastures
    f31_grassl_yld.cs3 -> Rangelands and managed pastures grass yields
    f31_grass_bio_hist.cs3 -> Historical grass biomass demand
- **modules** New dimension in `vm_carbon_stock` for different carbon stock types (actual, previousLandPattern, previousCarbonDensity)
- **config** added option for CO2 emission pricing `cfg$gms$c56_carbon_stock_pricing`
- **config** added cfg$gms$s70_past_mngmnt_factor_fix with default 2005 (previous default was 2010). The previous setting caused a strong spike in CO2 emissions from pasture expansion in SSA. With 2005, this can be avoided.
- **30_crop** new module realizations including crop rotation scenarios by strict constraints (`rotation_apr22`) and by penalties (`penalty_apr22`)
- **scripts** `start/projects/test_rotations.R` testscript for different rotation scenario settings
- **38_factor_costs** mixed_reg_feb17 realization added. This realization includes differences in productions costs between irrigated and rainfed crops, with the option of regional differentiation as well. per_ton_fao_may22 realization added. This realization corresponds to the old sticky_feb18 free.
 - **44_biodiversity** added new realization `bii_target`, which calculates the BII at the level of 71 biomes and allows to set targets for BII (e.g. no decrease in the future)
 - **36_employment** added new module to calculate agricultural employment. Includes one realization (`exo_may22`) in which employment is calculated based on the total labor costs (for crop and livestock production)
 - **config and 38_factor_costs** added switch `c38_fac_req` to choose between global and regional crop factor requirements. The default is "glo" (which corresponds to the previous implementation)
 - **config and 70_livestock** added switch `c70_fac_req_regr` to choose between global and regionally calibrated regression to calculate livestock factor requirements. The default is "glo" (which corresponds to the previous implementation)


### removed
- **38_factor_costs** mixed_feb17 and fixed_per_ton_mar18 realizations removed because they are not being used at the moment.

### fixed
- **inputs** included data for Sudan
- **09_drivers** bugfix concerning the use of the switch c09_gdp_scenario for defining population assumptions
- **09_drivers**  introduced new sets for PAL and demography scenarios to account for only partial coverage of available socio-economic gdp and population scenarios
- **18_residues** off realization; missing variable declarations
- **34_urban** exo_nov21 realization; bugfix in calculation of biodiversity value
- **50_nr_soil_budget** off realization; missing variable declarations
- **59_som** static realization; avoid division by zero
- **62_material** exo_flexreg_apr16 realization; avoid division by zero
- **80_optimization** nlp_par realization; bugfix i2 in submission loop
- **scripts** calibration; set NA values to 1
- **scripts** fixed misleading warning in check_config
- **scripts** fixed configuration error in FSEC output scripts, FSEC_dietaryIndicators.R and FSEC_environmentalPollutants.R
- **56_ghg_policy** Some equations in `56_ghg_policy` have been simplified. Also, GHG emissions from peatlands have been fully integrated into `56_ghg_policy`.
- **scripts** scripts/start/extra/emulator.R  Throw an error if no file can be found to take the GHG prices from
 - **56_ghg_policy and config** removed switch `s56_reward_neg_emis`
 - **44_biodiversity** fixed accounting for time step length in realization `bv_btc_mar21`
 - **41_area_equipped_for_irrigation** static realization. bugfix in presolve.gms: f41_irrig_luh("y1995",j)

## [4.4.0] - 2021-12-13

### changed
- **additional_data** NDCs for Chinas afforestation now start earlier (1995) in line with observed afforestation.
- **config** comments added for correct use of nitrogen switches
- **inputs** new default LPJmL version with growing season adaptation (gsadapt) on
- **51_nitrogen** parameter change in rescaled_jan21, now including regionalized climate-dependent leaching factors
- **config** Update default configuration to new input data (especially cellular inputs) including all module realization updates (14_yield, 22_processing, 30_crop, 38_factor_costs, 39_landconversion). Moreover, climate impatcs (cc options for biophysical inputs) are activiated as default. New best_calib calibration routine is activated as default.
- **config** peatland module on by default (cfg$gms$peatland <- "on")
- **config** update default setting for 2nd generation bioenergy demand and GHG prices
- **config** update default setting for the 42_water_demand module (to all_sectors_aug13)
- **scripts** output/extra/disaggregation.R updated to account for country-specific set-aside shares in post-processing
- **scripts** output/extra/disaggregation.R updated to account for sub-categories of "forestry"
- **scripts** Default recalibration routine does not read in previous calibration factors anymore
- **09_drivers** Update sets in drivers to include new SDP and Ariadne GDP and Pop scenarios
- **21_trade** In the exo and off realization, equations corrected to be consistent with the mapping between supreg h and regions i. Bugfixes in trade exo and off realizations. Added scaling factor for exo realization.
- **inputs** Update of GDP and population scenarios based upon recent historic data from WDI (complemented with growth rates given by the James2019 dataset), short term projections until 2025 from IMF (for GDPpc) and WB (for pop) and reconverge to the original SSP GDPpc levels by 2100.
- **inputs** Update of all input data that are based on FAO, using the most up-to-date version of FAOSTAT datasets available at the date of input calculations via automated download.
- **inputs** Update of additional data to rev4.07
- **scripts** scripts/start/projects/project_LAMACLIMA.R -> scripts/start/projects/project_LAMACLIMA_WP4.R
- **58_peatland** "On" realization: Degraded peatland is estimated differently, based on an additional calibration factor.
- **43_water_availability** changed scaling factor
- **10_land** Converted "v10_landreduction" to interface "vm_landreduction", used in "modules/39_landconversion/calib"
- **52_carbon** Removed interface "vm_carbon_stock_change", no longer needed
- **scripts** recalibrate_realizations.R and recalibrate.R adjusted for land conversion cost calibration + default time steps for convenient validation of results
- **scripts** start_functions adjustments for land conversion cost calibration
- **scripts** start.R added SLURM medium as choice
- **scripts** yield calibration, "best" setting uses factors from iteration with lowest standard deviation
- **14_yield** read-in file f14_yld_calib.csv if exists. Set default calibration factors to 1 in case f14_yld_calib.csv does not exist
- **13_tc** different educated guess for vm_tau in 1995
- **scaling** Update of scaling factors. removed duplicates
- **32_foresty** Avoid division by zero (observed under higher regional resolutions)
- **35_natveg** Avoid division by zero (observed under higher regional resolutions)
- **70_livestock** Avoid division by zero (observed under higher regional resolutions)
- **60_bioenergy** Minimum dedicated 2nd generation bioenergy demand assumed in each region raised from 0.01 to 1 mio. GJ per yr, and added as option in the config file (s60_2ndgen_bioenergy_dem_min)
- **config** Remove elements from the parameter list of start_run(), instead include them as regular settings in the default.cfg.
- **scripts** Add option to take ghg prices from different file than the regular reporting file (used in the REMIND coupling)
- **60_bioenergy** Switch off fixing the bioenergy demand to SSP2 until 2020 if MAgPIE runs coupled (to REMIND) or for emulator runs (to derive biomass supply crurves).
- **56_ghg_policy** Switch off fixing the GHG prices to SSP2 until 2020 if MAgPIE runs coupled (to REMIND) or for emulator runs (to derive biomass supply crurves).
- **scripts** start/test_runs.R added SSP1, SSP2 and SSP5 as default test runs

### added
- **34_urban** New exo_nov21 exogenous realization of urban land expansion
- **21_trade** Missing interface parameter for failing exo realization runs
- **59_som** exogenous pathway for vm_nr_som via f59_som_exogenous
- **config** Addition of a new scenario column (Tland) in scenario_config.csv
- **config** Added option c32_max_aff_area, which allows to provide a file with regional limits for afforestation
- **14_yield** parameter created to save historical cellular yields and to be used in the sticky realization of 38_factor_costs and in the 17_production module
- **17_production** switch added to decide if initialization of cellular crop production is needed or not. Also, a parameter to calculate initial production based on input cellular crop patterns and semicalibrated yields (potential yields calibrated to FAO values).
- **scripts** Added calibration script to generate default calibration for different factor costs realization
- **scripts** scripts/output/extra/disaggregation_LUH2.R script for exporting spatial output in LUH2 format (NetCDF)
- **37_labor_prod** labor productivity module with two realizations: off and exo
- **38_factor_costs** new realization "sticky_labor", based on "sticky_feb18" but accounting for changes in labor productivity
- **15_food** Added additional solve with CONOPT3 in case of modelstat 7
- **scripts** Added script "landconversion_cost.R" for land conversion cost calibration in scripts/calibration, for matching historic cropland in 2015
- **39_landconversion_cost** added new realization "calib", which uses the calibration factors derived by "landconversion_cost.R"
- **scripts** Added start script for yield and land conversion cost calibration "recalibrate_all.R"
- **scripts** added script validation_short.R with aggregated crop types (cutting the PDF size in half) -> replaces validation.R in default.cfg
- **scripts** added start script "scripts/start/Rprofile.R" for adding a R snapshot to the ".Rprofile" file
- **config** file "land_carbon_sink_adjust_grassi.mz" added to cfg$files2export$start
- **config** Inclusion of LAMACLIMA scenarios in scenario_config.csv
- **output.R** added SLURM standby maxMem and SLURM priority maxMem; needed for some output scripts (e.g. disaggregation_LUH2.R)

### removed
- **32_foresty** Removed static realization
- **35_natveg** Removed static realization
- **scripts** lpjml_addon script is removed and all calls within dependend starting scripts
- **scripts** output/extra/disaggregation_transitions_.R moved to deprecated folder
- **scripts** output/extra/disaggregation_cropsplit.R moved to deprecated folder
- **14_yield** Removed `biocorrect` and `dynamic_aug18` realizations
- **20_processing** Removed `substitution_dec18` realization
- **30_crop** Removed `endo_jun13` realization
- **scripts** scripts/start/extra/highres.R
- **39_landconversion_cost** removed realizations "global_static_aug18" and "devstate"

### fixed
- **80_optimization** Improved solve logic in "nlp_apr17" and "nlp_par" realization, multiple bugfixes and switch to solvelink=3 in "nlp_par"
- **58_peatland** fixed rare infeasibility in "on" realization
- **10_land** fixed rare infeasibility in "landmatrix_dec18" realization
- **38_factor_costs** For the sticky_feb18 realization correction in initial capital stocks, use of production initial values, and 05USDppp units changed to 05USDMER for sticky so it matches the units of the other realizations
- **80_optimization** Bug fixes in the nlp_par (parallel optimization) and improved code to collect failing handles.
- **32_foresty** Avoid division by zero in q32_establishment_dynamic_yield
- **35_natveg** fixed land protection to SSP2 default (WDPA) for historic period
- **15_food** New iteration needs to be started before setting food prices for curr_iter15
- **scripts** scripts/output/extra/highres.R bugfixes
- **38_factor_costs** units in sticky_feb18
- **32_foresty** Global afforestation limit s32_max_aff_area was not effective in case of parallel optimization -> added option c32_max_aff_area, which allows to provide a file with regional limits for afforestation;
- **73_timber** plausible cost for balance variable in case of s73_timber_demand_switch = 0 to avoid cost distortion
- **56_ghg_policy** choose the correct scenario for fixing the GHG prices until sm_fix_SSP2

## [4.3.5] - 2021-09-02

### changed
- **13_tc** added switch to ignore historic tau patterns in historic time steps (new default)
- **16_demand** Moved most of cropping related set definitions (k, kve, kcr) from **16_demand** to **14_yield**
- **32_foresty** Added option to choose a rotation length calculation criteria
- **35_natveg** Calculation of land protection policies revised and moved from presolve.gms to preloop.gms
- **38_factor_costs** Realization `sticky_feb18` extended to differentiate capital requirements between regions and their specific development status (GDP) in each time step of the magpie run. The changes in the `sticky` realization also include an additional switch so it can be operated as `dynamic` (change of each region capital share at each time step) or `free` (capital shares equal to zero and equivalent to the `fixed_per_ton_mar18` realization). Bugfix in the yearly update of the variable input requirements. Addition of the time dimension and clean up of names of parameters used in the realization. Removal of the management factor (this factor was not being used, it was being cancelled out in previous calculations). Correction of the costs, they are given in 05USDppp.
- **39_landconversion** lower costs for expansion of forestry land
- **58_peatland** Peatland area is initialized in 1995 based on levels for the year 2015, and hold fixed depending on `s58_fix_peatland`. This provides a better proxy for peatland area and associated GHG emissions for the historic period, which where assumed zero in previous versions.
- **80_optimization** **nlp_par** parallelizes now on superregional level `h` instead of regional level `i` as before.
- **script** Added forestry run script which used LPJmL addon
- **script** New standard for cluster to region mapping (rds-files) is used in all scripts. If old spam files are provided by input data, rds-mapping file is created.
- **script** updated test run script. Update of the sticky run script.
- **start scripts** improved function for GAMS set creation from R and outsourced it to package `gms`
- **inputs** Changed file format from cs2 to cs2b for cellular input files with a single data column
- **scenario_config** added RCPs as columns for use with setSceanrio function. This required the addition of "gms$" in the 1st column.


### added
- **73_timber** Added construction wood demand scenarios based on Churkina et al. 2020
- **script(s)** Added scripts to replicate runs for Mishra et al. 2021 (in review : https://doi.org/10.5194/gmd-2021-76)
- **13_tc** Added new interfaces for tau factor of the previous time step (`pcm_tau`)
- **14_yield** Added new realization `managementcalib_aug19` that is able to calibrate yield data coming from uncalibrated crop models (e.g. LPJmL yields for unlimited N supply). The yield calibration is either a purely multipicative factor or is limited to additive change in case of a underestimated FAO yield by the initial crop model yields (based on the switch `s14_limit_calib`). For pastures spillover of crop yield increases due to technological change from the previous time step are allowed and can be scaled using `s14_yld_past_switch`.
- **20_processing** Added new almost identical realization that excludes a calibration of the oil crop demand for oils (Note: old realization can be removed, when old yield realizations are deleted).
- **30_crop** Added new realization `endo_apr21`. The realisation includes new input data for available cropland and a new switch `c30_marginal_land`, which provides different options for including marginal land as cropland. Furthermore, a given share of the available cropland can be set aside for the provisioning of natures contribution to people and to promote biodiversity. The new switches `s30_set_aside_shr` and `c30_set_aside_target` are included to specify the share that should be set aside and the target year.
- **30_crop** Added new interface parameter historic croparea (`fm_croparea`)
- **30_crop** Added new option `policy_countries30` for country specific set aside share
- **35_natveg** Added new option `"FF+BH"` for protected areas.
- **35_natveg** Added new option `policy_countries35` for country specific land protection
- **38_factor_costs** Added scaling factors for improving model run time
- **39_landconversion** new realization `devstate` in which global land conversion costs are scaled with regional development state (0-1)
- **41_area_equipped_for_irrigation** Added switch for using different input data including new LUH2v2 consistent initialisation pattern.
- **41_area_equipped_for_irrigation** Added scalar for depreciation rate that depreciates certain area in every timestep, defined by switch in config.
- **58_peatland** Added option for one-time and recurring costs of peatland degradation (USD05MER per ha)
- **calibration run** has two new features: 1. Upper bound to cropland factor can be added (`crop_calib_max`). 2. Best calibration factor (factor with the lowest divergence) can be picked individually for each regions based on all calibration factors calculated during the calibration run iteration (`best_calib`).
- **disaggregation** Added new disaggregation script that is in line with new crop realisation and can account for cropland availabilty on grid level during disaggregation (see `interpolateAvlCroplandWeighted()` in package `luscale` for further details).
- **sets** added superregional layer `h` as additional spatial layer and moved constraints in **13_tc** and **21_trade** partly to the superregional level.

### removed
- **13_tc** Removed disfuctional setting c13_tccost = "mixed"
- **core** removed sets ac_young and ac_mature (no longer needed due to changes in 44_biodiversity)

### fixed
- **32_foresty** BII coefficients for CO2 price driven afforestation
- **32_foresty** growth curve CO2 price driven afforestation
- **32_foresty** NPI/NDC afforestation infeasibility
- **32_foresty** Correct distribution from LUH data to plantations and ndcs
- **35_natveg** option to fade out damage from shifting agriculture by 2030
- **44_biodiversity** ac0 included in pricing of biodiversity loss


## [4.3.4] - 2021-04-30

### changed
- **51_nitrogen** New calculations for emissions from agricultural residues (vm_res_ag_burn)
- **53_methane** New calculations for emissions from agricultural residues (vm_res_ag_burn)
- **citation file** added new contributors

### added
- **config** The set "kfo_rd" (livst_rum, livst_milk), which is used in the food substitution scenarios c15_rumdairy_scp_scen and c15_rumdairyscen, has been added to the default.cfg file. This allows for sensitivity scenarios (e.g. only livst_milk or only livst_rum).
- A new scenario (nocc_hist) was added to the cc/nocc switch. In this scenario, parameters affected by the cc/nocc switch in **14_yields**,**42_water_demand**,**43_water_availability**,**52_carbon**,**59_som** keep their historical/variable values up to the year defined by sm_fix_cc. Afterwards, sm_fix_cc values are kept constant for the overall run horizon.

### fixed
- **09_drivers** migration of sm_fix_SSP2 and sm_fix_cc declaration from the core declarations to the drivers module. This will allow to set the scalars properly .
- - **15_food** single-cell protein substitution scenarios included in intersolve.gms.
- **20_processing** The "mixed" scenario for single-cell protein production (c20_scp_type) was not working as expected. The corresponding code in 20_processing has been updated.

## [4.3.3] - 2021-03-30

### added
- **15_food*** added 3 sigmoid food substitution scenarios
- **44_biodiversity** New biodiversity module. The realization bv_btc_mar21 now allows to calculate an area-based biodiversity value across all land types. Switch `c44_price_bv_loss` to implement cost for biodiversity loss.
- **56_ghg_policy** Automatic sets for scenarios
- **60_bioenergy** Automatic sets for scenarios
- **70_livestock*** added 3 sigmoid feed substitution scenarios
- **scripts** added output script for disaggregation to GAINS regions
- **scripts** Automatic sets for 56_ghg_policy and 60_bioenergy
- **scripts** Added pre-commit hook

### fixed
- **60_bioenergy** Minimal bioenergy demand


## [4.3.2] - 2021-03-17

### changed
- **12_interest_rate** Interest fader changed to csv
- **15_food** better documentation of parameters over model iterations
- **15_food** added scenario switch for ruminant and dairy replacement by Single-Cell Protein
- **20_processing** added different options for Single-Cell Protein production
- **35_natveg** Fader for HalfEarth protection policy
- **50_nr_soil_budget** added necessary interfaces to 50_nitrogen module
- **70_livestock** added scenario switch for feed replacement (crop and forage) by Single-Cell Protein
- **scripts** Updated AgMIP output scripts.
- **runscripts** adapted to new input data and model version
- **tests** Replaced TravisCI with GithubActions

### added
- **15_food** Added the option to fade out livestock demand towards a target level in kcal/cap/day.
- **21_trade** Added scalar `s21_trade_bal_damper` and new set `k_trade_excl_timber`
- **29_ageclass** New age-class module
- **32_forestry** added new default realization
- **32_forestry** Simplified routine for plantation establishments. Added plantation area initialization based on MODIS data. Calibration to FAO growing stocks via carbon densities. New switches: `s32_distribution_type `, `s32_hvarea`, `s32_establishment_dynamic`, `s32_establishment_static`, `s32_max_self_suff`. New settings `c32_dev_scen`, `c32_incr_rate`, `c32_incr_rate`
- **35_natveg** Added new default realization
- **35_natveg** Added distribution in secondary forest based on Poulter et al. 2019. Added forest damages due to wildfire and shifting agriculture. Bugfix in forest protection calculations. New switches: `s35_secdf_distribution`, `s35_forest_damage`, `s35_hvarea`
- **35_natveg** Added HalfEarth scenario to protection scenarios
- **51_nitrogen** new module realization rescaled_jan21, which rescales n-related emissions with nitrogen surplus to account for lower emissions with higher NUE
- **52_carbon** Simplified routine for carbon stock calculations in timber plantations and cleanup of unused code.
- **56_ghg_policy** Added new scenario to emission policy
- **73_timber** Additive calibration with FAO data for roundwood demand. New switches: `c73_wood_scen`
- **73_timber** Added new realization `default` (modified version of previous realization)
- **default.cfg** New `forestry` scenario which simulates timber production in MAgPIE
- **scenario.csv** Added three plantation scenarios
- **scaling** Updated scaling across the modules
- **scripts** Updated to `forestry` script with general cleanup for publication. Added `forestry_magpie` script for generic forestry runs.
- **scripts** added output script for disaggregation of land transitions

### removed
- **32_forestry** Removed previous default realization
- **35_natveg** Removed previous default realization
- **73_timber** Removed previous default realization

### fixed
- **32_forestry** Bugfixes for "ac_est" and carbon treshold afforestation; removed plantations from "vm_cdr_aff".
- **core** bugfix m_fillmissingyears macro; was running over t before; now running over t_all_

## [4.3.1] - 2020-11-03

### added
- **main** Added Dockerfile for running MAgPIE in a container

### fixed
- **35_natveg** Bugfix "v35_secdforest_expansion"
- **52_carbon** Bugfix "p52_scaling_factor" for climate change runs
- **73_timber** New scenario switch `c73_wood_scen`.


## [4.3.0] - 2020-09-15

### added
- **38_factor_costs** Added the new "sticky" realization to the factor costs module. The realization "sticky_feb18" favors expansion in cells with preexisting farmland and capital based on capital investment decisions.
- **modules** added endogenous implementation of local biophysical (bph) impacts of afforestation to existing realizations in modules 32_forestry (dynamic_oct19) and 56_ghg_policy (price_jan20). default = off
- **73_timber** Added timber module which brings the ability of producing woody biomass for timber plantations and natural vegetation. Default = off. New switch: `s73_foresight`. New scalars : `s73_timber_prod_cost`, `s73_timber_harvest_cost`,`s73_cost_multiplier`,`s73_free_prod_cost`
- **32_forestry** New realization `dynamic_may20` for forestry land use dynamics. This builds up on previous forestry realization for afforestation. New switches: `s32_fix_plant`, `c32_interest_rate`. New scalars : `s32_plant_share`, `s32_forestry_int_rate`, `s32_investment_cost`, `s52_plantation_threshold`.
- **35_natveg** New realization `dynamic_may20` for natural vegetation land use dynamics. New forest protection scenario.
- **52_carbon** Added interface which is used for calculating additional investment needed in plantations when carbon stocks are lower than a specified threshold. New scalar: `s52_plantation_threshold`.
- **57_maccs** Added MACCs from Harmsen PBL 2019
- **15_food** Added the option to include calories from alcohol consumption in healthy and sustainable EAT-Lancet diets.
- **scripts** added start script for making timber production runs (forestry.R).

### changed
- **scripts** updated selection routine for start and output scripts
- **scripts** replaced lucode dependency with newer packages lucode2 and gms
- **32_forestry** include new datasets of the bph effect of afforestation / replaced the bph ageclass switch with a fade-in between ac10 and ac30 in (dynamic_may20)
 - **13_tc**, **39_landconversion**, **41_area_equipped_for_irrigation** and **58_peatland**. For the current time step, the optimization costs only include now the annuity of the present investment. magpie4's reportCosts() function was modified to consider these changes.

### removed
 - **scripts** deleted outdated start and output scripts

### fixed
 - **32_forestry** Rotation length calculation based on correct marginals of growth function in timber plantations. Clearer calculations for harvested area for timber production.
 - **35_natveg** Clearer calculations for harvested area for timber production.
 - **52_carbon** Fix to the Carbon densities received from LPJmL for timber plantations.

## [4.2.1] - 2020-05-15

### added
 - **modules** added option of regional scenario switches in modules 12_interest_rate, 15_food, 42_water_demand, 50_nr_soil_budget, 55_awms, 56_ghg_policy, 60_bioenergy
 - **58_peatland** added peatland module. Two realizations: off (=default) and on.
 - **80_optimization** added realization for parallel optimization of regions in combination with fixed trade patterns.
 - **metadata** added .zenodo.json metadata file for proper metadata information in ZENODO releases

### changed
 - **12_interest_rate** merged the two realizations (glo_jan16 and reg_feb18) into one (select_apr20) with same functionality and add on of option to choose different interest rate scenarios for different regions selected via country switch select_countries12
 - **scripts** streamlined and improved performance of NPI/NDC preprocessing

### fixed
 - **56_ghg_policy and 60_bioenergy** update of GHG prices and 2nd generation bioenergy demand from SSPDB to most recent snapshot
 - **NPI/NDC policy calculations** revision of calculation method



## [4.2.0] - 2020-04-15

This release version is focussed on consistency between the MAgPIE setup and the [REMIND model] and result of a validation exercise of the coupled (REMIND 2.1)-(MAgPIE 4.2) system.

### added
 - **config** Added new socioeconomic scenario (SDP) to scenario_config.csv (which include all switches to define among others the SSP scenarios). For the parametrization of the new SDP (Sustainable Development Pathway) scenario, the list of scenario switches was extended to account for a broad range of sustainability dimensions.
 - **10_land** added new land realization landmatrix_dec18 to directly track land transition between land use types
 - **15_food** stronger ruminant fade out in India
 - **15_food** Added exogenous food substitution scenarios that can be selected via settings in the config-file, defining speed of convergence, scenario targets and transition periods (applied after the food demand model is executed). Among these scenarios are the substitution of livestock products with plant-based food commodities and the substitution of beef or fish with poultry. The food substitution scenarios are based on the model-native, regression-based calculation of food intake and demand.
 - **15_food** Added exogenous EAT Lancet diet scenarios: It is now possible to define in the config-file exogenous diet scenarios that replace the regression-based calculation of food intake and demand. Possible settings are the target for total calorie intake (e.g. according to a healthy BMI) and variants of the EAT Lancet diet (e.g. in addition to the flexitarian a vegetarian or vegan variant).
 - **15_food** Added exogenous food waste scenarios which can be defined via settings in the config-file, including scenario targets for the ratio between food demand and intake and the year in which full transition to the target should be achieved.
 - **30_crop** added crop specific land use initialization pattern (used as interface for other modules)
 - **50_nr_soil_budget and 55_awms** Additional inputs for the GoodPractice Scenario.
 - **52_carbon** Added new forest growth curve parameters based on Braakhekke et al. 2019. Growth curves are now differentiated between natural vegetation (default) and plantations.
 - **59_som** added new realization static_jan19 (new default) including all soil carbon related calculations. Before all carbon pools were updated in the specific land use type modules. This still holds true for the above ground pools (vegetation and litter carbon)
 - **.gitattributes** file added to set line ending handling to auto for all text files
 - **scaling** added scaling.gms files for several modules to improve optimization (based on gdx::calc_scaling)
 - **scripts** added output scripts for global soil carbon maps (SoilMaps.R).

### changed
 - **config** new default ghg emission pricing policy "redd+_nosoil" in c56_emis_policy. Includes all pools included in the previous default "SSP_nosoil", and in addition "forestry".
 - **13_tau** lower bound for vm_tau for historical time steps
 - **50_nr_soil_budget** atmospheric deposition is now estimated on the cluster-level instead of the region level to improve spatial patterns.
 - **56_ghg_policy** updated scenarios in f56_emis_policy: none, all natural (called 'ssp') and all land use change emissions (pure co2) being included in greenhouse gas pricing. ssp and all also featuring additional scenarios excluding soil carbon pricing (marked with '_nosoil' postscript).
 - **56_ghg_policy** Several changes regarding afforestation: use of detailed formula for incentive calculation instead of simplified Hotelling formula, 50 year planning horizon (instead of 80 years), phase-in of GHG prices deactivated by default (now done in REMIND), CO2 price reduction factor deactivated by default, introduced buffer reduction factor of 20% for afforestation.
 - **59_som** updated cellpool_aug16 realization to use new interfaces from land module on land use type specific land expansion and reduction as well as crop type specific land initialization pattern. Additionally added irrigation as stock change factor sub-type. N fertilizer from soil organic matter decomposition is truncated after threshold to avoid unrealistically high fertilization rates.
 - **80_optimization** write extended run information in list file in the case that the final solution is infeasible
 - **modules** modular structure updated from version 1 to version 2
 - **line endings** changed to unix-style for all text files

### fixed
 - **modules** Fixing of all parameters to SSP2 values until 2020 (switch sm_fix_SSP2) for having identical outcomes in all scenarios (SDP, SSP1-5) until 2020.
 - **21_trade** Bugfix kall instead of k in exo realization; Bufix begr/betr trade in default realization; Bugfix sets in free realization
 - **32_forestry** NPI/NDC afforestation targets are now counted towards the global afforestation limit, which can be set for specific scenarios via the switch *s32maxaff_area* and constrains the potential for carbon-price induced endogenous afforestation.
 - **56_ghg_policy** bugfix full soil carbon loss in default setting, renamed it from ssp to ssp_nosoil, indicating, that soil carbon losses are not priced.
 - **56_ghg_policy** bugfix afforestation: vmbtm_cell was a free variable for some sources and pollutants, which could result in GHG cost neutral shifting of age classes to ac0 (e.g. from ac55 to ac0).
 - **80_optimization** added fallback routine for CONOPT4 failure (fatal system error)


## [4.1.1] - 2020-03-09

This version provides the model version used for the publication starved, stuffed and wasteful. It provides a few technical updates compared to the 4.1 release, which include

### added
- **scripts** a startscript that allows the exchange of model parameters as a sensitivity analysis

### changed
- **core** allow for flexible calibration period of the model, which allows for uncalibrated runs of the past for validation purposes
- **15_food** Parameters for bodyheight regressions were included explicitly as input parameters
- **config** updated input data of the drivers and food demand regressions

### fixed
- **15_food** Precision of iteration convergence criterium for magpie-demandmodel-iteration is calculated more precisely, avoiding unnecessary iterations.


## [4.1.0] - 2019-05-02

This release version is focussed on consistency between the MAgPIE setup and the [REMIND model] and result of a validation exercise of the coupled REMIND-MAgPIE system.

### added
 - **80_optimization** added support for GAMS version 26.x.x
 - **scripts** added new start and output scripts
 - **license** added exception to the applied AGPL license to clarify handling of required GAMS environment, solver libraries and R libraries

### changed
 - **56_ghg_policy** apply reduction factor on CO2 price to account for potential negative side effects; lowers the economic incentive for CO2 emission reduction (avoided deforestation) and afforestation
 - **56_ghg_policy** non-linar phase-in of GHG prices over 20 year period
 - **56_ghg_policy** multiply GHG prices with development state to account for institutional requirements needed for implementing a GHG pricing scheme
 - **40_transport** introduced transport costs for monogastric livestock products
 - **NPI/NDC scripts** added forest protection policy for Brazilian Atlantic Forest in default NDC and NPI scenarios
 - **NPI/NDC scripts** harmonized the starting year of the NDC policies 2020.
 - **interpolation scripts** changed output files to seven magpie land use types, added additional cropsplit script for more detailed cropland output
 - **15_food** clean-up and cosmetic changes (correction of comments, parameter names, structure of code); update BMI share calculations with the values of the last consistent MAgPIE/food-demand-model iteration

### fixed
 - **42_water_demand** bugfix environmental flow policy harmonization for historic period
 - **57_maccs** correction of cost calculation; Conversion from USD per ton C to USD per ton N and USD per ton CH4 was missing.
 - **71_diagg_lvst** adjusted monogastric disaggregation for more flexiblity to avoid infeasibilities with EFPs (see 42_water_demand)
 - **15_food** correction regarding the convergence measure of the iterative execution of the food demand model and MAgPIE; correction accounting for unusual time step length in body height calculations; body height regression parameters updated

## [4.0.1] - 2018-10-05

### fixed
 - **FABLE** adapted FABLE-specific configuration so that it works with MAgPIE 4.0


## [4.0.0] - 2018-10-04

First open source release of the framework. See [MAgPIE 4.0 paper](https://doi.org/10.5194/gmd-12-1299-2019) for more information.


[Unreleased]: https://github.com/magpiemodel/magpie/compare/v4.4.0...develop
[4.4.0]: https://github.com/magpiemodel/magpie/compare/v4.3.5...v4.4.0
[4.3.5]: https://github.com/magpiemodel/magpie/compare/v4.3.4...v4.3.5
[4.3.4]: https://github.com/magpiemodel/magpie/compare/v4.3.3...v4.3.4
[4.3.3]: https://github.com/magpiemodel/magpie/compare/v4.3.2...v4.3.3
[4.3.2]: https://github.com/magpiemodel/magpie/compare/v4.3.1...v4.3.2
[4.3.1]: https://github.com/magpiemodel/magpie/compare/v4.3.0...v4.3.1
[4.3.0]: https://github.com/magpiemodel/magpie/compare/v4.2.1...v4.3.0
[4.2.1]: https://github.com/magpiemodel/magpie/compare/v4.2.0...v4.2.1
[4.2.0]: https://github.com/magpiemodel/magpie/compare/v4.1.1...v4.2.0
[4.1.1]: https://github.com/magpiemodel/magpie/compare/v4.1.0...v4.1.1
[4.1.0]: https://github.com/magpiemodel/magpie/compare/v4.0.1...v4.1.0
[4.0.1]: https://github.com/magpiemodel/magpie/compare/v4.0...v4.0.1
[4.0.0]: https://github.com/magpiemodel/magpie/releases/tag/v4.0

[REMIND model]: https://www.pik-potsdam.de/research/transformation-pathways/models/remind
