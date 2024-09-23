*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization, the state of peatlands is modelled based on the 
*' methodology described in @humpenoder_peatland_2020.  
*' The initial map for intact, degraded and rewetted peatland is based on the 
*' [Global Peatland Map 2.0](https://globalpeatlands.org/resource-library/global-peatland-map-20) 
*' and the [Global Peatland Database](https://greifswaldmoor.de/global-peatland-database-en.html), both for the year 2022. 
*' Therefore, it is advised to set `s58_fix_peatland` to `2020` when using this realisation (2022 is not available as time step in MAgPIE). 
*' Future peatland dynamics are estimated by multiplying changes in managed land with a peatland scaling factor. 
*' GHG emissions from drained and rewetted peatlands as well as from peat extraction are calculated based on GHG emission factors.
*' In this realisation, peatland GHG emission factors for boreal and tropical climates are based on @IPCC_wetland_2013 and @wilson_2016.
*' Peatland GHG emission factors for temperate climates are based on more recent estimates from @tiemeyer_peatland_2020. 
*' 
*' Assumed rules for changes in peatland area: 
*' 
*'   * Sum over total peatland area (degraded, intact, rewetted) is assumed constant. 
*'   * Intact peatland area can only decrease. 
*'   * Degraded peatland area (crop, past, forestry and unused) depends on managed land. 
*'   * Area for peat extraction (peatExtract) is fixed. 
*'   * Rewetted and intact peatland have the same GHG emission factors, which avoids that intact is converted to rewetted peatland area.
*'
*' @stop


*'
*' @limitations Peatland area and GHG emissions are fixed to 2022 levels for the historic period, 
*' depending on `s58_fix_peatland`. Organic carbon stocks in peatlands are not accounted for. 

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/58_peatland/v2/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/58_peatland/v2/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/58_peatland/v2/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/58_peatland/v2/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/58_peatland/v2/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/58_peatland/v2/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/58_peatland/v2/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/58_peatland/v2/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
