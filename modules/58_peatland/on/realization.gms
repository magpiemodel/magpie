*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization GHG emissions from degrading/drained peatlands
*' are calculated based on GHG emission factors from the 
*' "2013 Supplement to the 2006 IPCC Guidelines for National Greenhouse Gas Inventories: Wetlands".
*' Also rewetting of drained peatlands as mitigation option is available. 
*' @stop


*'
*' @limitations Organic carbon stocks in peatlands are not accounted for. 

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/58_peatland/on/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/58_peatland/on/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/58_peatland/on/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/58_peatland/on/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/58_peatland/on/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/58_peatland/on/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/58_peatland/on/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/58_peatland/on/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
