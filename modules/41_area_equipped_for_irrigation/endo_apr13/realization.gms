*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @description This realization allows the model to endogenously decide on investments to deploy additional
*' irrigation infrastructure, i.e. to increase the area equipped for irrigation (AEI).
*' Initial values for AEI are areas that are irrigated in the initial time step in LUH2v2.
*' Depreciation of AEI can be set via `s41_AEI_depreciation`.
*' Irrigated crop production can only take place where irrigation infrastructure is present.
*'
*' Unit costs per hectare for AEI expansion are derived from a World Bank study (@worldbank_irrigation_1995)
*' and adjusted for the regions used in MAgPIE. The region mapping is as follows:
*'
*' ![Mapping between MAgPIE regions and the regions in 
*' [@worldbank_irrigation_1995]](regions.png){ width=60% }
*'
*' The regional unit costs converge linearly towards the European level until 2050.
*'
*' ![Unit costs for AEI expansion in MAgPIE
*' ](unitcosts.png){ width=60% }
*'
*' @limitations This realization increases model complexity.



*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
