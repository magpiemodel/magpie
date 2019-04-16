*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In the dynamic_may18 realization, land and carbon stock dynamics of 
*' natural vegetation are modeled endogenously.
*' The initial spatial distribution of the sub-land-types primary forest, 
*' secondary forest and other natural land is based on the 
*' LUH2 data set [@hurtt_harmonization_inprep].
*' The realization includes 2 different kinds of land protection. a) Land protection based on 
*' the World Database on Protected Areas (WDPA) maintained by the International 
*' Union for Conservation of Nature (IUCN) and b) land protection based on national 
*' policies implemented (NPI) and nationally determined contributions to the Paris agreement (NDC) 
*' taken from individual country reports.
*' Land protection based on WDPA is static over time, 
*' while the NPI/NDC polices ramp up until 2030 and are assumed constant thereafter.
*' For WDPA the level of land protection is based on IUCN catI+II, which reflect areas currently
*' under protection (e.g. strict nature reserves and national parks), 
*' and distributed equally across all sub-land-types (primary forest, secondary forest and other natural land).
*' On top of the IUCN catI+II land protection, there are options to protect different conservation priority areas
*' such as biodiversity hotspots (BH), centers of plant diversity (CBD), frontier forests (FF) and last of the wild (LW).
*' NPI/NDC land protection polices are be applied on forest and other land, depending on individual country reports.
*' @stop


*'
*' @limitations Wood harvest in natural forests is not accounted for.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/35_natveg/dynamic_may18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/35_natveg/dynamic_may18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/35_natveg/dynamic_may18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/35_natveg/dynamic_may18/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/35_natveg/dynamic_may18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/35_natveg/dynamic_may18/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/35_natveg/dynamic_may18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
