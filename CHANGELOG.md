
# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### added
 - **modules** added endogenous implementation of local biophysical (bph) impacts of afforestation to existing realizations in modules 32_forestry (dynamic_oct19) and 56_ghg_policy (price_jan20). default = off
 - **73_timber** Added timber module which brings the ability of producing woody biomass for timber plantations and natural vegetation. Default = off.
 - **32_forestry** New realization for timber production from timber plantations. This builds up on previous forestry realization for afforestation.
 - **35_natveg** New realization for timber production from natural vegetation.
 - **57_maccs** Added MACCs from Harmsen PBL 2019
 - **scripts** added start script for making timber production runs (forestry.R)

### changed
 - **scripts** updated selection routine for start and output scripts
 - **scripts** replaced lucode dependency with newer packages lucode2 and gms

### fixed

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


[Unreleased]: https://github.com/magpiemodel/magpie/compare/v4.2.1...develop
[4.2.1]: https://github.com/magpiemodel/magpie/compare/v4.2.0...v4.2.1
[4.2.0]: https://github.com/magpiemodel/magpie/compare/v4.1.1...v4.2.0
[4.1.1]: https://github.com/magpiemodel/magpie/compare/v4.1.0...v4.1.1
[4.1.0]: https://github.com/magpiemodel/magpie/compare/v4.0.1...v4.1.0
[4.0.1]: https://github.com/magpiemodel/magpie/compare/v4.0...v4.0.1
[4.0.0]: https://github.com/magpiemodel/magpie/releases/tag/v4.0

[REMIND model]: https://www.pik-potsdam.de/research/transformation-pathways/models/remind
