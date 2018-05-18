*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' @description This realization assures that irrigated crop production can only take place where
*' irrigation infrastructure is present. The difference to the static realization is that it allows
*' the model to endogenously decide on investments to deploy additional irrigation infrastructure,
*' i.e. to increase the area equipped for irrigation (AEI).Initial values for AEI in 1995 are taken from
*' @siebert_FAO_2007. Contraction of AEI is not possible.
*'
*' Investment costs in the current timestep for each region are calculated as the AEI expansion in each
*' cluster of the region times the regional unit cost per hectare.
*' MAgPIE has a common planning horizon to which all one time investments are distributed using an annuity
*' approach. Due to this distribution, part of the costs from previous investments in AEI still entail costs
*' in the current timestep.
*'
*' Unit costs per hectare for AEI expansion are derived from a World Bank study @worldbank_irrigation_1995.
*' The region mapping is as follows:
*'
*' ![Mapping between MAgPIE regions and the regions in 
*' @worldbank_irrigation_1995](regions.PNG){ width=60% }
*'
*' These costs converge linearly towards Europe until 2050.
*'
*' ![Unit costs for AEI expansion in MAgPIE
*' ](Unitcosts.PNG){ width=60% }
*'
*' @limitations This realization increases model complexity.



*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
