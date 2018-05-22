*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In the dynamic_mai18 realization, land and carbon stock dynamics of 
*' natural vegetation are modeled endogenously.
*' The initial spatial distribution of the sub-land-types primary forest, 
*' secondary forest and other natural land is based on the 
*' LUH2 data set [@hurtt_harmonization_inprep].

*' General rules
*' Within the optimization, primary and secondary forests can only decrease 
*' (e.g. for cropland expansion).
*' In contrast, other natural land can decrease and increase within the optimization. 
*' For instance, other natural land increases if agricultural land is abandoned.
*' An increase of other natural land is associated with natural succession,
*' modelled by age-class growth, which results in increasing carbon stocks.
*' Interaction with other land modules.

*' carbon threshold other land -> secondary forest
*' ndc/npi forest and carbon stock
*' biodiv protection



*' @limitations Wood harvest in natural forests is currently not accounted for.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/35_natveg/dynamic_mai18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/35_natveg/dynamic_mai18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/35_natveg/dynamic_mai18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/35_natveg/dynamic_mai18/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/35_natveg/dynamic_mai18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/35_natveg/dynamic_mai18/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/35_natveg/dynamic_mai18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
