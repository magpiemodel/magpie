*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In the sector_may15 realization, demand is calculated as the sum of
*' demand for all products coming from the modules material, bioenergy, livestock,
*' food and production. It also delivers data to the modules bioenergy, trade, processing, 
*' residues, awms, nr_soil_budget, forestry, and methane.
*'
*' @limitations Food demand projections enter the model as exogenous scenarios. Such an 
*' inelastic representation cannot capture impacts of i.e. bioenergy production or policies 
*' on food demand via price signals.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/16_demand/sector_may15/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/16_demand/sector_may15/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/16_demand/sector_may15/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/16_demand/sector_may15/equations.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/16_demand/sector_may15/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
