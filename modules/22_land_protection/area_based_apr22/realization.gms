*** |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The realization initialises 2 different kinds of land protection.
*' a) Area-based protection as derived from the World Database on Protected Areas (WDPA)
*' maintained by the International Union for Conservation of Nature (IUCN) and
*' b) land protection based on national policies implemented (NPI) and nationally
*' determined contributions to the Paris agreement (NDC) taken from individual country reports.
*' Area-based protection as derived from WDPA is based on observed land protection trends.
*' In 1995, the total area under land protection (across all land types) in the input data set
*' is 871.5 Mha and increases to 1672.8 Mha in 2020, by 5-year time steps. After 2020
*' land protection is held constant at 2020 values. The protected area based on WDPA includes
*' all areas under legal protection meeting the IUCN and CBD protected area definitions
*' (including IUCN categories Ia, Ib, III, IV, V, VI and 'not assigned' but legally designated
*' areas). Natural vegetation (natveg) and grassland ('past') within protected areas cannot be
*' converted to other land types. On top of the WDPA baseline protection, there are future options
*' to protect different conservation priority areas such as biodiversity hotspots (BH),
*' centers of plant diversity (CBD), Intact Forest Landscapes (IFL) and last of the wild (LW).
*' Future land protection is distributed proportionally across natural vegetation types
*' (primary forest, secondary forest and other natural land).
*' The NPI/NDC polices ramp up until 2030 and are assumed constant thereafter.
*' NPI/NDC land protection polices are be applied on forest and other land, depending
*' on individual country reports.
*' @stop

*'
*' @limitations Initialization of both primary and secondary forest in highest
*' age class or equal distrivution of such areas in all age classes. Data exists
*' on a more emperically obtained distribution in different age classes based
*' on satellite data but this results is highly negative land-use change emissions.
*' Inclusion of this data in MAgPIE remains work in progess and is not available for release yet.
*' Additionally, in this module realizatuion, harvested secondary forest stays
*' secondary forest and harvested primary forest is reclassified as secondary forest.
*' Moreover, this realisation does not include land protection for areas in categories III-VI of the
*' IUCN Protected Area Categories System and ‘Other effective area-based conservation measures’ (OECMs),
*' which, in reality, make up the bulk of current land protection, but largely cover (sustainably)
*' managed land area.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/22_land_protection/area_based_apr22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/22_land_protection/area_based_apr22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/22_land_protection/area_based_apr22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/22_land_protection/area_based_apr22/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/22_land_protection/area_based_apr22/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/22_land_protection/area_based_apr22/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/22_land_protection/area_based_apr22/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
