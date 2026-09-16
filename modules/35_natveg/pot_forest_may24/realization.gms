*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the pot_forest_may24 realization, land and carbon stock dynamics
*' of natural vegetation are modeled endogenously.
*' The initial spatial distribution of the sub-land-types primary forest,
*' secondary forest and other natural land is based on the LUH3 data set [@chini_luh3_2026].
*' Forest establishment is constrained by the potential forest area, which is defined by
*' areas with a potential carbon density of >20 tC/ha and, by default, corrected for grassland
*' ecoregions [@dinerstein_ecoregion_2017], where forest expansion is ecologically inappropriate
*' [@veldman_tree_2015] and LPJmL overestimates forest cover (`c35_pot_forest_correction`). The remaining
*' forest establishment area in the current time step is provided to the [32_forestry] module via
*' the interface parameter `pm_max_forest_est`.
*' This realization also includes national policies implemented (NPI) and nationally
*' determined contributions to the Paris agreement (NDC) with regard to forest and other
*' land protection. The NPI/NDC polices ramp up until 2030 and are assumed constant
*' thereafter. NPI/NDC land conservation polices are applied on forest and other land,
*' depending on individual country reports. The NPI/NDC policies are treated as minimum
*' constraints and therefore are non-additive, if the land protection targets as provided by
*' the module `22_land_conservation` and the interface `pm_land_conservation` are larger.
*' Additionally, this module includes forest damage and provides the ability to
*' harvest natural vegetation for timber. Wood and woodfuel can be produced from
*' primary forest, secondary forest and other land.

*'
*' @limitations The satellite age-class data (module [28_ageclass]) contain a large share of very
*' young secondary forest whose regrowth MAgPIE would over-credit, because disturbances that keep this
*' forest young in reality (shifting cultivation, fire, small-scale clearing) are not represented
*' explicitly. To avoid this, the youngest secondary-forest age classes are initialised with the area
*' of the ~35-year class. Additionally, in this module realization, harvested secondary forest stays
*' secondary forest and harvested primary forest is reclassified as secondary forest.
*' Secondary-forest harvest is not age-differentiated, so cost-minimising harvest draws first on the
*' oldest, highest-carbon stands (the planted-forest pools are instead harvested at their rotation age).
*' The resulting concentration in old secondary forest is stronger than managed-rotation forestry
*' practice in some regions; an age-dependent or regionally differentiated harvest preference for
*' secondary forest is left to future work.
*' The correction of the potential forest area for grassland ecoregions uses a static ecoregion
*' map, so the grassland/forest boundary does not shift with climate over the scenario horizon.

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
