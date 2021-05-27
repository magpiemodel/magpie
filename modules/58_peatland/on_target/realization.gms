*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization, the state of peatlands is modelled as described in @humpenoder_peatland_2020.
*' The initial map of peatland area consists of intact and degraded peatland area for 2015. 
*' Future peatland dynamics depend on the ratio of total peatland area and total land area. 
*' GHG emissions from degraded and rewetted peatlands as are calculated based on GHG emission factors from the 
*' "2013 Supplement to the 2006 IPCC Guidelines for National Greenhouse Gas Inventories: Wetlands". 
*' @stop


*'
*' @limitations Peatland area and GHG emissions are fixed at 2015 levels, depending on sm_fix_SSP2.
*' Organic carbon stocks in peatlands are not accounted for. 

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/58_peatland/on_target/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/58_peatland/on_target/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/58_peatland/on_target/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/58_peatland/on_target/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/58_peatland/on_target/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/58_peatland/on_target/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/58_peatland/on_target/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/58_peatland/on_target/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
