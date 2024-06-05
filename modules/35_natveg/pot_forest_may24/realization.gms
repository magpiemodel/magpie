*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the pot_forest_may24 realization, land and carbon stock dynamics
*' of natural vegetation are modeled endogenously.
*' The initial spatial distribution of the sub-land-types primary forest,
*' secondary forest and other natural land is based on the
*' LUH2 data set [@hurtt2018luh2].
*' Forest establishment is constrained by the potential forest area, which is defined by
*' areas with a potential carbon density of >20 tC/ha. The remaining forest establishment
*' area in the current time step is provided to the [32_forestry] module via the
*' interface parameter `pm_max_forest_est`.
*' This realization also includes national policies implemented (NPI) and nationally
*' determined contributions to the Paris agreement (NDC) with regard to forest and other
*' land protection. The NPI/NDC polices ramp up until 2030 and are assumed constant
*' thereafter. NPI/NDC land conservation polices are applied on forest and other land,
*' depending on individual country reports. The NPI/NDC policies are treated as minimum
*' constraints and therefore are non-additive, if the land protection targets as provided by
*' the module `22_land_conservation` and the interface `pm_land_conservation` are larger.
*' Additionally, this module includes forest damage and provides the ability to
*' harvest natural vegetation for timber. Both wood and woodfuel can be produceed
*' from primary and secondary forest but other land is only allowed to be harvested
*' for woodfuel.
*' @stop

*'
*' @limitations Initialization of both primary and secondary forest in highest
*' age class or equal distrivution of such areas in all age classes. Data exists
*' on a more emperically obtained distribution in different age classes based
*' on satellite data but this results is highly negative land-use change emissions.
*' Inclusion of this data in MAgPIE remains work in progess and is not available for release yet.
*' Additionally, in this module realization, harvested secondary forest stays
*' secondary forest and harvested primary forest is reclassified as secondary forest.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/35_natveg/pot_forest_may24/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/35_natveg/pot_forest_may24/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/35_natveg/pot_forest_may24/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/35_natveg/pot_forest_may24/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/35_natveg/pot_forest_may24/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/35_natveg/pot_forest_may24/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/35_natveg/pot_forest_may24/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/35_natveg/pot_forest_may24/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
