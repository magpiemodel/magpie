*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the dynamic_may20 realization, all the dynamics from dynamic_may18
*' realization are accounted for with an additional ability to harvest natural vegetation
*' for timber. Both wood and woodfuel can be produceed from primary and secondary forest
*' but other land is only allowed to be harvested for woodfuel.
*' @stop


*'
*' @limitations Initialization of both primary ans secondary forest in highest age class
*' and harvested secondary forest stays secondary forest.

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
