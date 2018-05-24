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
*' General land dynamics
*' Within the optimization, primary and secondary forests can only decrease 
*' (e.g. for cropland expansion).
*' In contrast, other natural land can decrease and increase within the optimization. 
*' For instance, other natural land increases if agricultural land is abandoned.
*'
*' General carbon stock dynamics
*' We calculate carbon stocks as product of area and carbon density, 
*' for primary forest, secondary forest or other natural land.
*' Therefore, carbon stocks decline if the area decreases 
*' (e.g. due to cropland expansion into forests).
*' In case of abandoned agricultural land (increase of other natural land), 
*' we model natural succession by age-class growth, which results in increasing carbon stocks.
*'
*' Interaction of other natural land and secondary forest
*' In case of natural secession on abandoned agricultural land, 
*' if the vegetation carbon density in a simulation unit
*' exceeds a threshold of 20 tC/ha we shift the respective area from other natural land 
*' to secondary forest. This shift of land happens outside the optimization,
*' i.e. after the end and before the start of the next time step optimization.
*'
*' Land protection policies
*' By default, we protect areas in primary forest, secondary forest or other natural land
*' based on WDPA IUCN catI+II, which reflect areas currently under protection (e.g. national parks).
*'
*' NPI/NDC policies
*' NPI/NDC policies are ramped up until 2030, and are assumed constant thereafter.
*' The natveg module accounts for two types of NPI/NDC polices: 
*' Avoided deforestation and CO2 emission reduction. Afforestation is accounted for in the 
*' [32_forestry] module. 
*' If a country has plans for afforestation, we assume a stop of deforestation. 
*' CO2 emission reduction targets apply on CO2 emissions from the conversion of 
*' primary forest, secondary forest and other natural land.

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
