*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization is similar to the dynamic_may18 realization, with the 
*' difference that age classes are not aggregated and instead exist during optimazation
*' @stop


*'
*' @limitations Initialization of both primary ans secondary forest in highest age class
*' and wood harvest in natural forests is not accounted for.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/35_natveg/dynamic_oct19/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/35_natveg/dynamic_oct19/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/35_natveg/dynamic_oct19/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/35_natveg/dynamic_oct19/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/35_natveg/dynamic_oct19/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/35_natveg/dynamic_oct19/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/35_natveg/dynamic_oct19/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/35_natveg/dynamic_oct19/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
