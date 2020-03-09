
# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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


[Unreleased]: https://github.com/magpiemodel/magpie/compare/v4.1.0...develop
[4.1.0]: https://github.com/magpiemodel/magpie/compare/v4.0.1...v4.1.0
[4.0.1]: https://github.com/magpiemodel/magpie/compare/v4.0...v4.0.1
[4.0.0]: https://github.com/magpiemodel/magpie/releases/tag/v4.0

[REMIND model]: https://www.pik-potsdam.de/research/transformation-pathways/models/remind
