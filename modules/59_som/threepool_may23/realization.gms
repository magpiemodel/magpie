*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' The threepool_may23 realization is based on the Tier 2 approach of the revised IPCC 
*' Guidelines for National Greenhouse Gas Inventories 2019 (@calvo_buendia_ipcc_2019). 
*' It calculates the stock of soil carbon for all land-use types based on a reduced complexity 
*' soil model driven by carbon inputs and decay rates depending on management decisions. 

*' @limitations tba

*' @authors Kristine Karstens

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/59_som/threepool_may23/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/59_som/threepool_may23/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/59_som/threepool_may23/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/59_som/threepool_may23/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/59_som/threepool_may23/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/59_som/threepool_may23/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/59_som/threepool_may23/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
