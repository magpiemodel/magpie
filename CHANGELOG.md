
# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### added


### changed
 - **modules** modular structure updated from version 1 to version 2


 ### fixed



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
