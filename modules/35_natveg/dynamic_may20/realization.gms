*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the dynamic_may18 realization, land and carbon stock dynamics
*' of natural vegetation are modeled endogenously.
*' The initial spatial distribution of the sub-land-types primary forest,
*' secondary forest and other natural land is based on the
*' LUH2 data set [@hurtt_harmonization_inprep].
*' The realization includes 2 different kinds of land protection.
*' a) Land protection based on the World Database on Protected Areas (WDPA)
*' maintained by the International Union for Conservation of Nature (IUCN) and
*' b) land protection based on national policies implemented (NPI) and nationally
*' determined contributions to the Paris agreement (NDC) taken from individual country reports.
*' Land protection based on WDPA is static over time, while the NPI/NDC polices
*' ramp up until 2030 and are assumed constant thereafter. For WDPA the level of
*' land protection is based on IUCN catI+II, which reflect areas currently under
*' protection (e.g. strict nature reserves and national parks), and distributed
*' equally across all sub-land-types (primary forest, secondary forest and other natural land).
*' On top of the IUCN catI+II land protection, there are options to protect different
*' conservation priority areas such as biodiversity hotspots (BH), centers of plant
*' diversity (CBD), frontier forests (FF) and last of the wild (LW).
*' NPI/NDC land protection polices are be applied on forest and other land, depending
*' on individual country reports. Additionally, this module provides the ability to
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
*' Additionally, in this module realizatuion, harvested secondary forest stays
*' secondary forest and harvested primary forest is reclassified as secondary forest.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/35_natveg/dynamic_may20/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/35_natveg/dynamic_may20/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/35_natveg/dynamic_may20/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/35_natveg/dynamic_may20/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/35_natveg/dynamic_may20/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/35_natveg/dynamic_may20/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/35_natveg/dynamic_may20/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/35_natveg/dynamic_may20/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
