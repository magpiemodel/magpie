*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the dynamic_feb21 realization, land and carbon stock dynamics
*' of natural vegetation are modeled endogenously.
*' The initial spatial distribution of the sub-land-types primary forest,
*' secondary forest and other natural land is based on the
*' LUH2 data set [@hurtt2018luh2].
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
$Ifi "%phase%" == "sets" $include "./modules/35_natveg/dynamic_feb21/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/35_natveg/dynamic_feb21/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/35_natveg/dynamic_feb21/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/35_natveg/dynamic_feb21/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/35_natveg/dynamic_feb21/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/35_natveg/dynamic_feb21/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/35_natveg/dynamic_feb21/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/35_natveg/dynamic_feb21/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
