# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).


## [Unreleased]

### changed
-

### added
-

### removed
-

### fixed
-


## [4.8.2] - 2024-09-24

### changed
- **15_food** revision of MP/SCP implementation for milk and meat alternatives. Added demand for fat and sugar as ingredients for MP-based milk alternatives. Added optional demand for fat as ingredient for MP-based meat alternatives.
- **21_trade** refactor equations for enhanced readablility and improve documentation
- **29_cropland** added option for linear and sigmoidal faders
- **32_forestry** Interfaces `vm_landexpansion_forestry` and `vm_landreduction_forestry` have been corrected by harvested and replanted timber plantation area
- **58_peatland** variable `v58_scalingFactorExp` converted into parameter `p58_scalingFactorExp` to avoid infeasibilites. `p58_scalingFactorRed` has been revised.
- **80_optimization** abort GAMS in case of execution errors, added threads = 1 as default to avoid infeasibilites and Flg_NoDefc = TRUE as option
- **config** `cfg$gms$land_snv`changed from "secdforest, forestry, past, other" to "secdforest, other"
- **config** additional data update additional_data_rev4.53.tgz
- **config** default settings for 58_peatland revised
- **config** initial treecover on cropland starts from zero
- **config** split scenario_config into project-specific configs
- **config** Submissions with high memory requirements now get 16 CPUs and 80GB of memory to account for the new specifications of PIK's new HPC 'Foote'. `maxMem` was renamed to `highMem`, because 80GB of memory does not correspond to the maximum available memory of a compute node.
- **config** The default realization for the 38_factor_costs module was switched to `sticky_feb18`. In this realization, capital stocks and their depreciation are tracked, giving some inertia to random relocation of production, improving high resolution outputs.
- **script** replaced gdx package with gdx2 package calls
- **script** scripts/start_functions.R decide individually for demand and price whether they are read from a REMIND report.
- **script** updated EATLancet project start scripts
- **scripts** `.nc` files are no longer created by default after disaggregation
- **scripts** output/extra/highres.R use default 13_tc realization
- **scripts** rewrite of merge_report.R based on rds files and rbind, which allows for more flexibility when merging reports. Avoid inconsistent use of "GLO" instead of "World" in report.rds files.


### added
- **42_water_demand** added water abstraction type dimension for non-ag uses
- **56_ghg_policy** added optional temporal and regional fader for GHG emission pricing policy
- **70_livestock** added realization `fbask_jan16_sticky`
- **config** added `scenario_config_year_fix.csv` for choosing until when parameters are fixed to SSP2 values
- **cropland** added option for discarding initial treecover on cropland
- **script** added output script for conversion of validation.mif file into validation.rds
- **script** check of variables needed in piamInterfaces in report_rds.R
- **script** for downscaling to 0.25 deg using LUH2v2h as reference via mrdownscale
- **scripts** added out of bounds check as output script
- **scripts** added output report `EU_report.R` that uses `EU_report.Rmd`
- **scripts** added output script converting all grid-level .mz files to .nc (netCDF)
- **scripts** added script for automatic submission of SEALS allocation runs `./extra/runSEALSallocation.R`
- **scripts** added start script for 'Healthly Landscapes' paper `paper_healthyLscps.R`


### fixed
- **15_food** fixing parameter declaration of i15_processed_kcal_structure_iso
- **35_natveg** bugfix secdforest and other land restoration to avoid double-counting of restoration in equation `q29_land_snv`
- **80_optimization** bugfix for variables levels not obeying the bounds in nlp_par, `conopt` changed to `conopt3`
- **scripts** fixing an error in start.R and output.R which occurred if more than one slurm job was submitted at the same time.


## [4.8.1] - 2024-06-19

### changed
- **29_ageclass** module 29_ageclass has been renamed to 28_ageclass to make space for `29_cropland` just before `30_croparea`
- **30_crop** module `30_crop` renamed to `30_croparea`, which now only accounts for crop area.
- **30_crop** Semi-Natural Vegetation (SNV) implementation has been moved from `30_crop` to `29_cropland`
- **30_crop** the previous `30_crop/endo_apr21` realization has been moved to `30_croparea/simple_apr24`
- **30_crop** the two realizations `penalty_apr22` and `rotation_apr22` have been merged into a single `30_croparea/detail_apr24` realization
- **default.cfg** update additional data to rev4.51
- **scripts** adjusted SLURM job handling
- **scripts** updated EL2p0 start scripts

### added
- **10_land** added interface `pm_land_hist` with historic land use patterns
- **29_cropland** new module `29_cropland` accounting for crop area, fallow cropland and tree cover on cropland with two realizations: `detail_apr24` and `simple_apr24` (default).
- **42_water_demand** added non-agricultural water demand for entire year

### removed
- **32_forestry** removed technical balance term `v32_land_missing_ndc`

### fixed
- **22_land_conservation** avoid infeasibilities due to very small numbers, account for cropland tree cover and lower bound of cropland
- **32_forestry** avoid infeasibilities due to very small numbers
- **35_natveg** avoid infeasibilities due to very small numbers
- **44_biodiversity** Fixing to SSP2 parameters until 2025 was not working
- **config** update to input data rev4.109. In the previous rev4.108, MER GDP was wrong and was identical to PPP GDP



## [4.8.0] - 2024-06-10

### changed
- **14_yields** revised timber yield calculations
- **15_food, default.cfg and scenario_config.csv** changed fader setup and introduced new switches for specifying food substitution scenarios and exogeneous food intake scenarios
- **22_land_conservation and default.cfg** Added options for baseline protection
- **32_forestry** renamed interface `pm_demand_ext` to `pm_demand_forestry`
- **32_forestry** revision and simplification of forestry implementation, renamed realization from `dynamic_feb21` to `dynamic_may24`.
- **35_natveg**  `vm_land(j2,"forestry")` included in NPI/NDC constraint `q35_min_forest`
- **35_natveg** replaced the realisation `dynamic_feb21` with realisation `pot_forest_may24`. The new realisation provides additional information on the potential forest area, which is now used to constrain forest and forestry expansion and recovery. The remaining area for forest establishment is provided to the forestry module via the new interface parameter `pcm_max_forest_est`.
- **41_area_equipped_for_irrigation** updated (non-default) AEI data (from Mehta2022 to Mehta2024)
- **52_carbon** Separate carbon densities for forest and other land. Before there was only a single carbon density for natural vegetation land.
- **70_livestock** default.cfg and scenario_config.csv** changed fader setup and introduced new switches for specifying feed substitution with SCP scenarios
- **80_optimization** Simplifed cycling through CONOPT4, CONOPT4 with OPTFILE, CONOPT4 without preprocessing and CONOPT3.
- **default.cfg** changed default realization for 44_biodiversity to new realization `bii_target_apr24`
- **default.cfg** defaults for `cfg$gms$sm_fix_SSP2`, `cfg$gms$sm_fix_cc` and other switches changed from 2020 to 2025
- **default.cfg** Forestry sector included by default by using the `ForestryEndo` settings from `scenario_config.csv`: `s32_initial_distribution = 1`, `s32_demand_establishment = 1`, `s32_hvarea = 2`, `s35_secdf_distribution = 2`, `s35_hvarea = 2`, `s73_timber_demand_switch = 1`
- **default.cfg** update additional data to rev4.50
- **scripts** modified agmip_merge_report to use piamInterfaces
- **scripts** start/test_runs.R added 2 more test runs from FSEC

### added
- **15_food** added additional sigmoid food substition scenarios `sigmoid_75pc_25_50`, `sigmoid_50pc_25_50` and `sigmoid_25pc_25_50`
- **21_trade** Minimum trade margin for forestry products `s21_min_trade_margin_forestry`
- **30_crop** added regional cropland equation `q30_crop_reg` and presolve growth constraint
- **44_biodiversity** added new realization `bii_target_apr24`, taking into account `f44_rr_layer`
- **60_bioenergy** added new realization `1st2ndgen_priced_feb24` to enable price-driven 2nd gen bioenergy production
- **73_timber** added interface `im_timber_prod_cost`
- **citation** added abstract
- **core** added `coup2110`timesteps
- **default.cfg** added cropland growth constraint `cfg$gms$s30_annual_max_growth`
- **default.cfg** added settings for new price-driven bioenergy realization `1st2ndgen_priced_feb24`: `cfg$gms$s60_2ndgen_bioenergy_dem_min_post_fix`, `cfg$gms$c60_bioenergy_subsidy_fix_SSP2`, `s60_bioenergy_gj_price_1st`,
- **default.cfg** added technical cost for missing BII increase `cfg$gms$s44_cost_bii_missing`
- **default.cfg** cfg$gms$s80_secondsolve option for second solve statement with 0=off as default
- **scenario_config.csv** added preset for GENIE project
- **scripts** added "checkSummation" output script for consistency checking a report.mif
- **scripts** added automatic set writer for new bioenergy realization to `start_functions`
- **scripts** added start scripts for the GENIE project
`s60_bioenergy_price_2nd`, `c60_price_implementation`

### removed
- **14_yields** removed interface `pm_timber_yield_initial`
- **21_trade** removed interface `pm_selfsuff_ext`, removed `v21_manna_from_heaven`
- **32_forestry** removed interface `pm_representative_rotation`
- **35_natveg** removed growing stock calculation and calibration, which is no longer needed.
- **62_material/16_demand** Removed double structure for forestry products. `pm_demand_foresty` is now used in `62_material`
- **73_timber** removed interfaces `pm_demand_forestry_future` and `sm_wood_density`
- **scripts** removed support for spam files in start_functions
- **scripts/output/extra** removed scripts disaggregation_cropsplit and disaggregation_transitions

### fixed
- **14_yields** fix division by zero in preloop of managementcalib_aug19
- **44_biodiversity** avoid division by zero
- **58_peatland** Added balance variable to avoid random infeasibilites
- **80_optimization** fixed a bug in nlp_apr17; cycling through CONOPT4, CONOPT4 without preprocessing and CONOPT3 was not working
- **extra/disaggregation** fixed bug in disaggregation of land conservation related to switch from 59k to 67k that produced erroneous outputs
- **scenario_config.csv** same revision for input files as in default.cfg
- **scenario_fsec.csv** scenario settings
- **scripts/start/test_runs.R** include all default output script, in particular disaggregation.R, which is needed for BII
- **start/projects/fsec.R** scenario settings


## [4.7.3] - 2024-04-12

### changed
- **21_trade** Revision of trade module. Replaced `cfg$gms$s21_trade_bal_damper` in favour of `cfg$gms$k_import21`, which allows for additional imports to maintain feasibility
- **21_trade** v21_import_for_feasibility now available for all countries, not just for importers
- **70_livestock** if `c70_fac_req_regr` is set to `reg`: use of USDA/FAO values for historic factor requirements for livestock instead of using regression values and change of calibration year from 2005 to 2010 for regional factor requirements regression
- **config** updated FSEC scenario config for revision and included new calibration file (after cost fix in preprocessing)
- **default.cfg** updated inputdata revision to 4.104 to have NDC scenarios included
- **scripts** cfg$gms$s35_secdf_distribution <- 2 for FSEC
- **scripts** modified output reporting for SEALS to account for forestry plantations
- **scripts/calibration/landconversion_cost.R** Revised calibration approach for conversion costs for cropland. Information from all calibration time steps in combination with a lowpass filter is now used for deriving the calibration factors, which avoids the previous zickzack pattern. The previous option `cfg$damping_factor_landconversion_cost` has been removed in favor of `cfg$lowpass_filter_landconversion_cost`.

### added
- **14_yields** added minimum threshold for wood yields. Below this threshold, wood yields are set to zero.
- **config** added switch for minimum timber yields
- **56_ghg_policy** added NDC scenarios
- **60_bioenergy** added NDC scenarios
- **scripts** start script for EAT2p0 Deep Dive project

### fixed
- **15_food** Small number rather 0 in condition checking calorie balancing
- **34_urban** `static` realization was not working because `vm_carbon_stock` was referenced without the set `stockType`
- **52_carbon** removing jump of carbon content into fully grown forest when a forest changes from second-last age class to last age-class.
- **58_peatland** Equation `q58_scalingFactorExp` revised to avoid division by zero.
- **80_optimization** duplicated solve statement in all instances to avoid non-matchting left- and right-hand sides of equations


## [4.7.2] - 2024-04-02

### changed
- **21_trade** Revision of trade module. Replaced `cfg$gms$s21_trade_bal_damper` in favour of `cfg$gms$k_import21`, which allows for additional imports to maintain feasibility
- **58_peatland** Threshold in equations changed from 1e-10 to 1e-8 to avoid rare divisions by zero
- **70_livestock** if `c70_fac_req_regr` is set to `reg`: use of USDA/FAO values for historic factor requirements for livestock instead of using regression values and change of calibration year from 2005 to 2010 for regional factor requirements regression
- **config** updated FSEC scenario config for revision and included new calibration file (after cost fix in preprocessing)
- **scripts** modified output reporting for SEALS to account for forestry plantations

### added
- **30_crop** Improved representation of cropland requiring relocation in response to introducing semi-natural habitat at the 1 km level based on high-resolution satellite imagery.
- **config** added `.codeCheck` with additonal configuration when running `gms::codeCheck`
- **scripts** add additional BII reporting variables in FSDP_collect.R
- **scripts** added a new validation_cell.R output script that generates a pdf with the comparison of magpie land use and crop type outputs with LUH and MAPSPAM historical data at cellular resolution.

### removed
- **core** removed no longer needed set `si` Suitability classes

### fixed
- **52_carbon** i52_land_carbon_sink was not identical before 2020 for different RCPs. Fixed by setting to RCPBU until the year defined in sm_fix_cc.
- **inputdata** currency fixed in historic value of production for crops and livestock which affects e.g. total labor costs and in turn hourly labor costs, bugfix in aggregation weight of capital cost share out of factor costs


## [4.7.1] - 2024-02-28

### changed
- **15_food** Added improved EAT Lancet diet implementation (EAT 2p0)
- **21_trade** s21_trade_bal_damper for roundwood changed from 0.75 to 0.65
- **31_past** in grasslands_apr22 realization: changed structure of f31_pastr_suitability to align with ssp-rcp specific input data formulation. Changed input filename from cs3 to cs2. Added `cc`, `nocc` and `nocc_hist` options for `i31_manpast_suit` and changed input gams code from table to parameter. Climate scenario assignment moved from preloop.gms to input.gms. Removed pastSuit set in sets.gms as not needed anymore. Adjusted not_used.txt in both grasslands_apr22 and static realizations.
- **default.cfg and scenario_config.csv** Default for cfg$gms$c56_emis_policy changed from `redd+natveg_nosoil` to `reddnatveg_nosoil`,i.e. timber plantations are excluded from carbon pricing by default
- **default.cfg** changed default for `cfg$gms$s32_aff_prot` from 0 to 1
- **default.cfg** changed default for `cfg$gms$s56_buffer_aff` from 0.2 to 0.5
- **default.cfg** Default for cfg$gms$c56_cprice_aff changed from `forestry_vegc` to `secdforest_vegc`
- **default.cfg** Default for cfg$gms$peatland changed from `on` to `v2`
- **default.cfg** update default `cfg$gms$c56_pollutant_prices` and `cfg$gms$c60_2ndgen_biodem` to `R32M46-SSP2EU-NPi`
- **default.cfg** update input data to rev 4.99 (new validation data, new EATLancet recommendations, new semi-natural vegtation cropland data)
- **scenario_config.csv** removed erroneous setting `cc` from column `input`
- **scenario_config.csv** settings for cfg$gms$s35_secdf_distribution in `ForestryEndo` and `ForestryExo` changed from `2` to `0`
- **start_functions** Check if cfg$recalibrate is consistent with cfg$gms$s14_use_yield_calib

### added
- **32_forestry** new interfaces `vm_land_forestry`, `pcm_land_forestry` `vm_landexpansion_forestry` and `vm_landreduction_forestry`
- **56_ghg_policy_** added new trajectories for R32M46
- **60_bioenergy** added new trajectories for R32M46
- **scripts** added peatland to output/extra/disaggregation.R

### removed
- **58_peatland** removed realization "on"
- **default.cfg** Removed description of cfg$gms$c31_past_suit_scen since no longer needed due to changes in 31_past described below. Its function is now done by cfg$gms$c31_grassl_yld_scenario.

### fixed
- **21_trade** introduced s21_manna_from_heaven for fixing v21_manna_from_heaven to zero. Without fixing to zero, v21_manna_from_heaven was used unnecessarily in runs started with highres.R
- **32_forestry** bugfix unit p32_observed_gs_reg
- **32_forestry** keep c-density for timber plantations constant after rotation length to avoid unrealistic carbon sequestration in unharvested timber plantation
- **35_natveg** bugfixes ac_est
- **35_natveg** removed scaling of pm_carbon_density_ac
- **52_carbon** bugfix acx long-term carbon density
- **scripts** bugfix highres.R for bioenergy demand and GHG prices in coupled runs
- **scripts** disaggregation_LUH2.R which no longer relies on the old raster-based write.magpie for nc files
- **scripts** fixed disaggregation.R and disaggregation_LUH2.R to be used with 67k
- **scripts** fixed memory spike leading to crashes in disaggregation.R
- **scripts** fixed writing of NetCDF files in output/reportMAgPIE2SEALS.R


## [4.7.0] - 2023-12-11

### changed
- **14_yields_and_config** The new default is to not use yield calibration factors from a calibration run. The switch s14_use_yield_calib can optionally reenable the use of yield calibration factors.
- **36_employment** regression between hourly labor regression and GDP pc changed from linear to log-log
- **inputdata** Now using inputdata rev4.94 which is based on 67420 cells (67k, previously 59k)
- **scripts** For the emulator scripts select a different bioenergy demand variable that excludes bioenergy sources other than second generation bioenergy crops. Set the minimal bioenergy demand to zero. Both avoid artificial clustering of data points and allow for better fits.
- **scripts** LUH2_disaggregation output script was modified. Specifically, flooded area was made compatible with the LUH definition, cropland and grazing land were added to the states.nc file, and specific naming/details (datatype,  zname, xname, and yname) were added when creating the .nc files.

### added
- **14_yields/config** Added option for considering impacts of land degradation on yields. If `s14_degradation` is switched to 1, MAgPIE will include cluster-specific information on the state of nature's contributions to people relevant for yields `./modules/14_yields/input/f14_yld_ncp_report.cs3`.
- **18_residues** Included cluster-level residue realization, for cluster-level production of residues (but balancing of recycling and burning budgets remains at region-level, for computational lightness)
- **32_forestry** new interface `vm_land_forestry`
- **58_peatland** added realization "v2" with updated peatland map and GHG emission factors

### fixed
- **inputdata** There was a major bug (related to proj/terra) in the rev4.91 inputdata that was fixed with rev4.92
- **inputdata** There was another bug (terra default na.rm changed) in the inputdata that was fixed with rev4.93
- **scripts** Fixed a bug in NPI/NDC calculations leading to missing AD policies when run with 67k


## [4.6.11] - 2023-09-05

### changed
- **scripts** All time steps between 2015 and 2050 are now reported to SEALS

### fixed
- **70_livestock** fixed division by zero that could occur depending on the scenario set-up


## [4.6.10] - 2023-08-16

### changed
- **config**  update preprocessing to newest input data v4.88 with new transport costs
- **GitHub action** the github action is now faster, because it installs binary packages from Posit Package Manager
- **scenario_config.csv** update preprocessing to newest input data v4.88
- **scripts** output.R is now faster, because it no longer searches runfolder renvs for full.gms files

### fixed
- **scripts** check_config does not warn about c_input_gdx_path anymore while running empty model
- **scripts** fixed erronoeous if clause in output.R
- **scripts** fixed output/extra/disaggregation_LUH2.R. The script was not working any more because magpie4::protectedArea was changed to return protected area for all land types. Moreover, the script now also works for runs without dynamic forestry (default run) but with a warning message.


## [4.6.9] - 2023-07-27

### fixed
- **70_livestock** consideration of milk demand in the calculation of the pasture management factor
- **scripts** Fixed inaccuracies and inconsistent application of SNV policies during disaggregation in luscale::interpolateAvlCroplandWeighted(), which is called in extra/disaggregation.R


## [4.6.8] - 2023-07-17

### changed
- **41_area_equipped_for_irrigation** new AEI data (Mehta2022) replacing old Siebert data
- **80_optimization** printing of solprint when solver status is 7 re-activated
- **scripts** start_functions.R can now handle clusters per region flexibly
- **scripts** the REMIND-MAgPIE coupling now uses renv

### added
- **31_past** added `cc`, `nocc` and `nocc_hist` options for `c31_past_suit_scen` and `c31_grassl_yld_scenario`
- **32_carbon** added `nocc` and `nocc_hist` option for `c52_land_carbon_sink_rcp`
- **71_disagg_lvst** added new realisation `foragebased_jul23` which solves GAMS issues at higher spatial resolutions
- **config** added `cfg$results_folder_highres` which allows to modify the output folder used in the `highres.R` output script
- **config** new area equipped for irrigation (AEI) data in preprocessing (4.87)
- **scenario_config.csv** added a scenario for the NGFS project
- **scripts** New output script for reporting disaggregated land use patterns to the SEALS (Spatial Economic Allocation Landscape Simulator) downscaling model

### removed
- **config** `s80_num_nonopt_allowed`
- **scripts** removed .snapshot.Rprofile and the Rprofile.R script, renv now fully supersedes snapshots

### fixed
- **30_crop** corrected q30_cropland in module realization rotation_apr22, where fallow land was on the wrong side of the equation
- **71_disagg_lvst** reworked `foragebased_aug18` (including removal of linear version and correction of balance flow calculation)
- **80_optimization** resolve was not working in nlp_par realization due to `s80_num_nonopt_allowed`
- **config** corrected wrong names of parameters for peatland costs
- **config** updated scenario configs to newest preprocessing (4.87)


## [4.6.7] - 2023-05-10

### changed
- **09_drivers** Harmonization of sets for population, gdp, pal and demography
- **56_ghg_policy** added emission policies without GHG emissions from peatlands
- **config** added scenario `SSP2EU` in scenario_config.csv
- **config** modified `eat_lancet_diet` in scenario_config.csv
- **config** update of additional data to rev4.43
- **config** update of regional and cellular inputs to 4.85 in default.cfg and scenario_config.csv
- **scripts** added output script for forest area change at cluster level
- **scripts** NDC/NPI calculations can now handle 59k and 67k cell inputs

### added
- **15_food** added an option in `s15_exo_diet` to allow for exogenous diet scenario for India


## [4.6.6] - 2023-05-10

### changed
- **config** updated scenario_fsec.csv to reflect new GST validation
- **scripts** included new output indicator for water
- **scripts** updated global surface temperature maps to new RCPs per scenario


## [4.6.5] - 2023-03-29

### changed
- **22_land_conservation** Replaced old options for land conservation by new conservation priority areas. These include among others a new 30by30 template (based on Key Biodiversity Areas, unprotected habitat in Biodiversity Hotspots, Ecoregions with a high beta-diversity from the Global Safety Net (Dinerstein et al. 2020) and critical connectivity areas (Brennan et al. 2022), a new Half Earth template based on the Global Safety Net (Dinerstein et al. 2020) and land conservation of irrecoverable carbon (Noon et al. 2022).
- **56_ghg_policy** renamed `cfg$mute_ghgprices_until` to `cfg$gms$c56_mute_ghgprices_until` and changed the default to `y2030`, i.e. no GHG emission pricing in the AFOLU sector before (and including) 2030. This setting will be also used in coupled REMIND-MAgPIE runs.
- **config** input data revision to rev4.82 to include new conservation priority areas
- **config** new options for conservation priority areas (including new 30 by 30 protection)
- **scripts** calc_calib.R bug fix. If the calibration factor of a region is equal to the maximum allowed value, its divergence is set the maximum allowed divergence.
- **scripts** Disaggregation of BII merged into standard extra/disaggregation.R
- **scripts** Disaggregation of land use to 0.5° now takes land conservation into account - i.e. cropland expansion is not mapped to areas that are subject to land conservation

### added
- **56_ghg_policy** added switch `s56_minimum_cprice`
- **config** minimum CO2 price (`s56_minimum_cprice`) of 5 USD per tCO2 (18 USD per tC) for all future time steps in case of NDC policy to guide land-use decisions
- **scripts** added output script which writes landuse data on cluster resolution to a shapefile

### removed
- **56_ghg_policy** removed `s56_ghgprice_phase_in` and `s56_ghgprice_start`
- **scripts** removed argument `mute_ghgprices_until`, now handeld in GAMS code

### fixed
- **31_past** fixed pasture suitability to SSP2 before and including 2020 (only relevant for grassland implementation)
- **56_ghg_policy** the renamed switch `c56_mute_ghgprices_until` is now always used for coupled as well as standalone runs.
- **scripts** Fixed occasional memory failure in the disaggregation script


## [4.6.4] - 2023-02-22

### changed
- **15_food** Interpret EAT-Lancet guidelines not as target but as lower/upper limits
- **config** changed order of output scripts. Some functions in rds_report require gridded outputs.
- **config** input data revision to rev4.81 for trade margin bugfix
- **config** scenario_fsec.csv updated input data tgz
- **config** scenario_fsec.csv updated to new biodiversity scenario
- **scripts** fsec.R and project_FSEC_Scenarios.R include capitalSubst and landscapeElements scenarios
- **scripts** highres.R changed default resolution to c1000
- **scripts** recalibrate.R and recalibrate_realization were modified to always use best_calib for the yield calibration.
- **scripts** updated FSEC scenario start and output scripts
- **scripts** when manually running output scripts for multiple runs the lockfile is only created once
- **sticky_labor** changed labor cost share constraint from regional to cellular level
- **sticky_labor** renamed equation `q38_labor_capital_ratio` to `q38_labor_share_target`

### added
- **15_food** half_overweight scenario added
- **21_trade** New Bilateral trade realization selfsuff_reduced_bilat22 for bilateral trade within selffsuff constraints
- **32_forestry** added switch `s32_aff_prot` for protection of afforested areas (0=until end of planning horizon 1=forever)
- **56_ghg_policy** added two scenarios for GHG emission pricing and options for afforestation
- **config** added options for afforestation assumptions and updated additional data to 4.38
- **config** added setting cfg$keep_restarts which controls whether restart files should be kept after a run finished
- **config** changed default for `s_use_gdx` from 2 to 0
- **scripts** added restart points after each time step from which the model can now be restarted if the simulation aborts at some point
- **scripts** added SLURM dayMax submission type for standby QOS
- **sticky_labor** `nl_fix`, `nl_relax` and `nl_release` added

### removed
- **42_water_demand** removed fm_multicropping factor because of fallow inconsistency

### fixed
- **14_yields** nl_fix updated to current equation
- **32_forestry** pm_land_conservation(t,j,"secdforest","restore") now accounts for the rotation length in timber plantations to avoid infeasibilities
- **44_biodiversity** added regional layer `i` in `bii_target` realisation to make it compatible with the high-resolution parallel optimization output script
- **59_som** division by zero prevented by if condition
- **scripts** fixed a bug where renvs for high resolution runs were missing some packages
- **scripts** fixed in the calc_calib.R script the saving of calib_factors used in each iteration to ensure that they correspond to the divergence reported. Changed divergence from zero to NA for those iterations where calib_factors are above the limit. The best_calib selection criterion was changed from selecting the factors of the iteration with the lowest standard deviation to the selection, for each region, of the factor of the iteration with the lowest divergence. Also, factors from the first iteration are now not considered, and if two different factors had the same divergence for a region, the one of the latest iteration is picked.


## [4.6.3] - 2023-01-19

### changed
- **15_food** changed `anthro_iso_jun22` realisation such that results in case of `exo_diet = 1/0` and `exo_waste = 1/0` are identical until 2020
- **30_crop** identical assumptions for bioenergy until 2020
- **38_factor_costs** changed name of set `req` to `factors` (also used in 11_costs, 57_maccs, 70_livestock)
- **38_factos_costs** sticky_labor realization: included option to set a labor share target
- **62_material** Bioplastic demand identical in all scenarios until 2020
- **config** added `s38_target_labor_share`, `s38_targetyear_labor_share` and `s38_target_fulfillment` to define labor share target scnarios
- **config** and **38_factor_costs** changed name of `s38_fix_capital_need` to `s38_startyear_labor_substitution`
- **config** update input data to rev4.79

### added
- **31_past** added additional limitation (single climate scenario input) for **grasslands_apr22**
- **59_som** added new **cellpool_jan23** realization with updated 2019 IPCC guidelines values
- **scripts** added start script which starts an empty model just regenerating a previous run

### fixed
- **scripts** make sure that `c_title` in the GAMS code is not containing dots which otherwise could lead to compilation errors


## [4.6.2] - 2023-01-12

### changed
- **36_employment** include labor costs from MACCs in employment
- **38_factor_cots** renamed `p36_cost_shares` to `pm_cost_share_crops`
- **57_maccs** split costs into labor and capital
- **config** scenario_fsec.csv update
- **config** updated SHAPE SDP scenarios in scenario_config.csv
- **scripts** FSDP_collect FSDP_process fsec.R updates

### added
- **renv** MAgPIE now runs in an isolated, stable, reproducible R package environment
- **scripts** added output script that generates a short mif containing only variables relevant for the REMIND coupling
- **scripts** added output script that generates subnational validation outputs for fable_India projects
- **setup** required R packages are automatically installed


## [4.6.1] - 2022-12-13

### changed
- **42_water_demand** replaced `f42_env_flow_policy` with macro
- **30_crop** replaced `f30_scenario_fader` with macro
- **30_crop/config** changed switch `c30_rotation_scenario_speed` to `s30_rotation_scenario_target`
- **30_crop/config** changed switch `c30_snv_target` to `s30_snv_scenario_target`
- **config** changed default value for `c30_marginal_land` from `'all_marginal'` to `'q33_marginal'` for better spatial cropland patterns

### added
- **10_land** added `vm_lu_transitions` as interface
- **10_land** added interface `fm_land_iso` for consistency
- **30_crop/config** added switch `s30_rotation_scenario_start`
- **30_crop/config** added switch `s30_snv_scenario_start`
- **30_crop/config** added switch for set `land_snv`for defining which land cover types are allowed in the semi-natural vegetation policy in cropland scenarios
- **39_landconversion** scalar `s39_reward_crop_reduction` provides a cropland reduction reward

### removed
- **10_land** removed `feb15` realization
- **10_land** removed the interfaces `vm_croplandexpansion` and `vm_croplandreduction`
- **30_crop** removed `f30_scenario_fader.csv`input
- **39_landconversion** removed `s39_reward_shr`
- **config** validation_short.R output script is no longer run by default after each run
- **scripts** removed remind2::deletePlus in coupling interface of start_function

### fixed
- **59_som** fixed land use change tracking for non-cropland pools in the `cellpool_aug16` realization
- **config** changed default value for s56_limit_ch4_n2o_price from 1000 to 4000 for consistency with c57_macc_version = "PBL_2022"
- **scripts** rewrite of land conversion cost calibration script `landconversion_cost.R`


## [4.6.0] - 2022-11-09

### changed
- **18_residues** bugfix in `q18_cost_prod_res`
- **36_employment** included calculations for minimum wage scenario
- **38_factor_costs** included labor cost scaling in case of wage scenario
- **42_water_demand** account for multiple cropping in water requirements
- **51_nitrogen** moved maccs into emission modules. change of interface from vm_btm_reg to vm_emissions_reg
- **52_carbon** change of interface from vm_btm_reg to vm_emissions_reg
- **52_carbon** Soil C of urban areas set to soil C of natural other land
- **57_maccs** default changed from PBL2007 to PBL2022
- **58_peatland** moved maccs into emission modules. change of interface from vm_btm_reg to vm_emissions_reg
- **59_som** Now calculates soil C for fallow and urban areas
- **62_material** added biomass demand for bioplastic production
- **70_livestock** included labor cost scaling in case of wage scenario
- **config** added `s62_max_dem_bioplastic` and `s62_midpoint_dem_bioplastic` to define bioplastic scenario
- **config** adjusted PR template
- **config** best_calib set to FALSE in default
- **config** new switches `s36_minimum_wage`, `s36_scale_productivity_with_wage`, and `s38_fix_capital_need`
- **config** non-food system emission MAGICC switch
- **config** updated config to new module setup of MACCs
- **config** updated default realization of 15_food from anthropometrics_jan18 to anthro_iso_jun22
- **config** updated SHAPE SDP scenarios in scenario_config.csv
- **documentation** added literature
- **inputs** update of NPi for China (additional data 4.30)
- **inputs** updated f56_emis_policy (additional data 4.29)
- **inputs** updated non-food initial prices, MACCs curves, and removed suitability threshold of 0.1 in all_marginal setting
- **scripts** added single time step run to test runs
- **scripts** fix in start_functions for the calibration setting `ifneeded`
- **scripts** FSDP_collect handles the health impacts data provided by Marco Springmann, distributed it into the scenario's various reports. It performs a similar operation for global nutrient surplus (which must be calculated on the grid-level and then aggregated).- **13_tc** relaxed vm_tau upper limit
- **scripts** log files are now written in a subfolder "logs"
- **scripts** output/extra/disaggregation_BII.R adjusted BII output for primary and secondary other land
- **scripts** quit with exit code = gams status at the end of submit.R
- **scripts** update of rds_report to allow gridded intermediate outputs
- **scripts** updated FSEC start and output scripts
- **scripts** updated FSEC start scripts and related config files to introduce new scenarios
- **scripts/start** cleanup of old start scripts

### added
- **14_yields** added input file containing AQUASTAT yield calibration factors and switch `s14_calib_ir2rf` in default.cfg to activate this yield calibration
- **15_food** added new realization with country level exogenous diets, product-specific intake estimates, new scenarios for exogenous BMI and decomposition switches for EAT Lancet diets. Simplified code and improved iteration procedure.
- **50_nr_soil_budget** new module realization for more consistent MACCs implementation. change of interface from vm_btm_reg to vm_emissions_reg
- **53_methane** moved maccs into emission modules. change of interface from vm_btm_reg to vm_emissions_reg
- **56_ghg_policy** added new ecosystem protection scenarios
- **56_ghg_policy** new module realization for more consistent MACCs implementation
- **57_maccs** added new Marginal Abatement Cost Curve (MACCs) data set from PBL (PBL2022)
- **57_maccs** new more consistent maccs implementation. different mapping of emission sources to maccs.
- **f32_forest** added the option to run generic disturbance scenarios of secondary forest types determined in `f32_forest_shock.csv`
- **f35_natveg** added the option to run generic disturbance scenarios of primary forest determined in `f35_forest_shock.csv`
- **scripts** added output script creating a merged .csv for dietaryIndicators and caloricSupply outputs
- **scripts** added output script creating a merged .csv for dietaryIndicators and caloricSupply outputs
- **scripts** added output script creating a set of outputs for Alessandro Passaro in the FSEC context
- **scripts** added output script creating a set of outputs for Simon Dietz in the FSEC context
- **scripts** added output script for gridded crop diversity indices
- **scripts** added output script running MAGICC7 on a MAgPIE scenario
- **scripts** added output script, FSDP_process creating a merged .csv and .gdx for dietaryIndicators and caloricSupply outputs
- **scripts** added output scripts for FSEC FSDP runs
- **scripts** added water output script for FSEC model runs

### removed
- **15_food** removed read-in of non-needed input file "f15_calib_factor_FAOfsupply_iso"
- **38_factor_costs** removed `mixed_reg_feb17` realization
- **50_nr_soil_budget** old inconsistent module realizations
- **53_methane** old inconsistent module realizations
- **56_ghg_policy** old inconsistent module realizations
- **57_maccs** old inconsistent module realizations

### fixed
- **38_factor_costs** fixed calibration of share parameter in `sticky_labor` realization
- **43_water_availability** added missing years after 2100 in "f43_wat_avail" to avoid infeasibilities in coupled runs with less_ts timesteps
- **59_som** corrected the som pool due to the carbon transfer from other and primary forest to secondary forest before optimization (presolve)
- **scripts** fixed some bugs related to background execution of start/output scripts


## [4.5.0] - 2022-07-07

### changed
- **09_drivers** separation of GDP and population scenarios
- **09_drivers** changed `i09_gdp_pc_mer_iso` to `im_gdp_pc_mer_iso`
- **11_costs** Split of production costs per sector, addded new separated costs to the costs function.
- **13_tc** changed vm_tech_cost upper bound to share of regional GDP PPP (s13_max_gdp_shr)
- **13_tc** Replace endo_jan18 realization by endo_jan22. The new realization adds a new dimension to vm_tau separating crop from managed pastures tau.
- **15_food** added more options to define convergence towards exogenous food intake and waste scenarios accounting for different transition periods
- **18_residues**  The variable that include production costs vm_cost_prod for residues changed to a new independent variable called vm_cost_prod_kres
(specific to residues).
- **30_crop** renamed switch `s30_set_aside_shr`, `s30_set_aside_shr_noselect` and `c30_set_aside_target` to `s30_snv_shr`, `s30_snv_shr_noselect` and `c30_snv_target`.
- **31_past**  The variable that include production costs vm_cost_prod for pasture changed to a new independent variable called vm_cost_prod_past
(specific to past).
- **31_past** added new realization implementing the separation of rangelands and managed pastures for the production of grass biomass.
- **32_forestry** simplification and bugfix of afforestation limit. `c32_max_aff_area_glo` renamed to `s32_max_aff_area_glo` in default.cfg.
- **34_urban** added set urban_scen34 and the switch c34_urban_scenario
- **35_natveg** corrected naming of Frontier Forests (FF) to Intact Forest Landscapes (IFL) and changed input data for BH_IFL implementation.
- **35_natveg** implementation of land protection moved to new module `22_land_conservation`
- **38_factor_costs** Sticky free/dynamic switch was removed and the realization was split into two realizations: the new per_ton_fao_may22 (free) and sticky_feb18 (dynamic). vm_cost_prod(i,kall) is now vm_cost_prod_crop(i,req) for crops factor costs. The results are now given differentiating between capital and labor for all realizations (new set req).
- **42_water_demand** Added new input data on pumping costs for India, equation to calculate water costs and scalars for policy shocks
- **44_biodiversity** Improved documentation, simplification of equations and flexible options for price on biodiversity loss
- **56_ghg_policy** additional scenarios for c56_emis_policy
- **56_ghg_policy** Deactivated GHG emission policies were not accounted for in the MACCs module. This has been corrected by an extension of the interface `im_pollutant_prices`, which now has an additional dimension for emission sources `emis_source`. In this context some equations in `56_ghg_policy` have been simplified (sets: `emis_source_reg`, `emis_source_cell`). Also, GHG emissions from peatlands have been fully integrated into `56_ghg_policy`.
- **70_livestock** vm_cost_prod(i,kall) is now vm_cost_prod_livst(i,req) for livestock factor costs (req indicates differentiation between capital and labor) and vm_cost_prod_fish(i) for fish.
- **80_optimization** Updated solver settings
- **config** Update of regional and grid inputs from 4.68 to rev4.69, and additional files to 4.17. Removed free/dynamic sticky switch, and added scalars used in mixed_regional factor costs realization.
- **config** added s13_max_gdp_shr setting for tech cost upper bound as share of GDP PPP
- **config** included switch for non-agricultural water demand (s42_watdem_nonagr_scenario) in scenario_config.csv
- **config** included SHAPE SDP scenarios in scenario_config.csv
- **config** Update default tau realization from endo_jan18 to endo_jan22
- **config** Added new SSP scenario switch for pasture suitability cfg$gms$c31_past_suit_scen
- **config** Added new switch to limiting calibration to relative or absolute managed pastures yields: cfg$gms$s31_limit_calib.
- **inputs** updated non-agricultural water use scenarios (watdem_nonagr_grper.cs3)
- **modules** Moved interface `vm_carbon_stock` from 52_carbon to 56_ghg_policy
- **scripts** replaced redundant files config.log and config.Rdata with a config.yml
- **scripts** updated FSEC modeling start script and added FSEC calibration scripts
- **scripts** clean up of the recalibrate_realizations.R script, project_LAMACLIMA_WP4.R, and sticky.R to remove sticky dynamic/free switch.
- **scripts** bugfix in disaggregation.R, disaggregation_BII.R with respect to urban scenario
- **scripts** added FSEC modeling start script (global runs)
- **scripts** The disaggregation_LUH2.R was extended to include the changes used to generate ISIMIP3b maps for LUH harmonization. The largest changes are: 1) The convertLUH function now breaks the grid level magpie objects by groups of years, then creates the raster for the groups and aggregates them to create the final map at a quarter of a degree resolution (this speeds up the process). 2) The mapping between LUH and MAgPIE is now defined by country and magpie-LUH types (not 1 to 1 anymore). 3) The split of MAgPIE's pasture land type between pasture and rangeland changed. Rangeland is assumed to stay constant after 2015, and changes in MAgPIE's pasture are due to managed pasture. 4) IFs were added so if a certain map already exists in the output folder, it will not generate it once again. 5) Flooded land now corresponds to a share of rice cropland, based on historical values. 6) To speed calculations, yields are read at the cell level, the crops are aggregated based on the new MAgPIE-LUH mapping, and then disaggregated to grid level.
- **scripts** added new disaggregation script to provide grid cell level BII
- **scripts** removed test script "irrig_dep_test" from "start" folder to "extra" folder
- **scripts** Added script projects/paper_grassland.R
- **scripts** scripts/output/extra/emulator.R Remove dependency on deprecated R package "magpie"

### added
- **core** macros for linear and sigmoidal time interpolation
- **22_land_conservation** added new module and realisation for land conservation. The realisation also includes a new WDPA initialisation data set (from 1995 to 2020) for protected areas under legal protection, meeting IUCN and CBD protected area definitions. The module also adds the interface `pm_land_conservation`.
- **30_crop** new module realizations including crop rotation scenarios by strict constraints (`rotation_apr22`) and by penalties (`penalty_apr22`)
- **36_employment** added new module to calculate agricultural employment. Includes one realization (`exo_may22`) in which employment is calculated based on the total labor costs (for crop and livestock production)
- **38_factor_costs** mixed_reg_feb17 realization added. This realization includes differences in productions costs between irrigated and rainfed crops, with the option of regional differentiation as well. per_ton_fao_may22 realization added. This realization corresponds to the old sticky_feb18 free.
- **38_factor_costs** added switch `c38_fac_req` to choose between global and regional crop factor requirements. The default is "glo" (which corresponds to the previous implementation)
- **44_biodiversity** added new realization `bii_target`, which calculates the BII at the level of 71 biomes and allows to set targets for BII (e.g. no decrease in the future)
- **52_carbon** added land carbon sink adjustment factors, needed in R post-processing
- **70_livestock** added switch `c70_fac_req_regr` to choose between global and regionally calibrated regression to calculate livestock factor requirements. The default is "glo" (which corresponds to the previous implementation)
- **config** added option for CO2 emission pricing `cfg$gms$c56_carbon_stock_pricing`
- **config** added cfg$gms$s70_past_mngmnt_factor_fix with default 2005 (previous default was 2010). The previous setting caused a strong spike in CO2 emissions from pasture expansion in SSA. With 2005, this can be avoided.
- **inputs** New input files added:
    f13_pastr_tau_hist.csv -> historical tau for managed pastures.
    f31_pastr_suitability.cs3 -> Managed pasture suitability
    f31_LUH2v2.cs3 -> LUH2v2 land classes separating rangelands from managed pastures
    f31_grassl_yld.cs3 -> Rangelands and managed pastures grass yields
    f31_grass_bio_hist.cs3 -> Historical grass biomass demand
- **modules** New dimension in `vm_carbon_stock` for different carbon stock types (actual, previousLandPattern, previousCarbonDensity)
- **scripts** output/projects/FSEC_StevenLord.R to create output for Steven Lord in the FSEC context
- **scripts** output/projects/FSEC_costs.R to create costs ouput for the FSEC project
- **scripts** output/projects/FSEC_dietaryIndicators.R to create output datasets for the FSEC project
- **scripts** output/projects/FSEC_nitrogenPollution.R to create output datasets of nitrogen pollutants for the FSEC project
- **scripts** Extended dissagregation.R script to replace single "past" land class by LHU range and pastr classes when grassland_apr22 realization is used.
- **scripts** `start/projects/test_rotations.R` testscript for different rotation scenario settings

### removed
- **38_factor_costs** mixed_feb17 and fixed_per_ton_mar18 realizations removed because they are not being used at the moment.

### fixed
- **09_drivers** bugfix concerning the use of the switch c09_gdp_scenario for defining population assumptions
- **09_drivers**  introduced new sets for PAL and demography scenarios to account for only partial coverage of available socio-economic gdp and population scenarios
- **18_residues** off realization; missing variable declarations
- **34_urban** exo_nov21 realization; bugfix in calculation of biodiversity value
- **41_area_equipped_for_irrigation** static realization. bugfix in presolve.gms: f41_irrig_luh("y1995",j)
- **44_biodiversity** fixed accounting for time step length in realization `bv_btc_mar21`
- **50_nr_soil_budget** off realization; missing variable declarations
- **56_ghg_policy** Some equations in `56_ghg_policy` have been simplified. Also, GHG emissions from peatlands have been fully integrated into `56_ghg_policy`.
- **56_ghg_policy and config** removed switch `s56_reward_neg_emis`
- **59_som** static realization; avoid division by zero
- **62_material** exo_flexreg_apr16 realization; avoid division by zero
- **80_optimization** nlp_par realization; bugfix i2 in submission loop
- **inputs** included data for Sudan
- **scripts** calibration; set NA values to 1
- **scripts** fixed misleading warning in check_config
- **scripts** fixed configuration error in FSEC output scripts, FSEC_dietaryIndicators.R and FSEC_environmentalPollutants.R
- **scripts** scripts/start/extra/emulator.R  Throw an error if no file can be found to take the GHG prices from


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


[Unreleased]: https://github.com/magpiemodel/magpie/compare/v4.8.2...develop
[4.8.2]: https://github.com/magpiemodel/magpie/compare/v4.8.1...v4.8.2
[4.8.1]: https://github.com/magpiemodel/magpie/compare/v4.8.0...v4.8.1
[4.8.0]: https://github.com/magpiemodel/magpie/compare/v4.7.3...v4.8.0
[4.7.3]: https://github.com/magpiemodel/magpie/compare/v4.7.2...v4.7.3
[4.7.2]: https://github.com/magpiemodel/magpie/compare/v4.7.1...v4.7.2
[4.7.1]: https://github.com/magpiemodel/magpie/compare/v4.7.0...v4.7.1
[4.7.0]: https://github.com/magpiemodel/magpie/compare/v4.6.11...v4.7.0
[4.6.11]: https://github.com/magpiemodel/magpie/compare/v4.6.10...v4.6.11
[4.6.10]: https://github.com/magpiemodel/magpie/compare/v4.6.9...v4.6.10
[4.6.9]: https://github.com/magpiemodel/magpie/compare/v4.6.8...v4.6.9
[4.6.8]: https://github.com/magpiemodel/magpie/compare/v4.6.7...v4.6.8
[4.6.7]: https://github.com/magpiemodel/magpie/compare/v4.6.6...v4.6.7
[4.6.6]: https://github.com/magpiemodel/magpie/compare/v4.6.5...v4.6.6
[4.6.5]: https://github.com/magpiemodel/magpie/compare/v4.6.4...v4.6.5
[4.6.4]: https://github.com/magpiemodel/magpie/compare/v4.6.3...v4.6.4
[4.6.3]: https://github.com/magpiemodel/magpie/compare/v4.6.2...v4.6.3
[4.6.2]: https://github.com/magpiemodel/magpie/compare/v4.6.1...v4.6.2
[4.6.1]: https://github.com/magpiemodel/magpie/compare/v4.6.0...v4.6.1
[4.6.0]: https://github.com/magpiemodel/magpie/compare/v4.5.0...v4.6.0
[4.5.0]: https://github.com/magpiemodel/magpie/compare/v4.4.0...v4.5.0
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
