*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In the dynamic_may18 realization, land and carbon stock dynamics of 
*' natural vegetation are modeled endogenously.
*' The initial spatial distribution of the sub-land-types primary forest, 
*' secondary forest and other natural land is based on the 
*' LUH2 data set [@hurtt_harmonization_inprep].
*'
*' @limitations Wood harvest in natural forests is currently not accounted for.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/35_natveg/dynamic_may18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/35_natveg/dynamic_may18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/35_natveg/dynamic_may18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/35_natveg/dynamic_may18/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/35_natveg/dynamic_may18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/35_natveg/dynamic_may18/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/35_natveg/dynamic_may18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
