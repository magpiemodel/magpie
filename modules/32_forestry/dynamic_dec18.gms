*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description The main feature of the dynamic_dec18 realization is that a dynamic
*' forestry sector can be modelled with existing MAgPIE version 4.

*' @limitations WIP

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/32_forestry/dynamic_dec18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/32_forestry/dynamic_dec18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/32_forestry/dynamic_dec18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/32_forestry/dynamic_dec18/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/32_forestry/dynamic_dec18/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/32_forestry/dynamic_dec18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/32_forestry/dynamic_dec18/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/32_forestry/dynamic_dec18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
