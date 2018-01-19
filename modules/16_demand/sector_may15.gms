*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/16_demand/sector_may15/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/16_demand/sector_may15/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/16_demand/sector_may15/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/16_demand/sector_may15/equations.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/16_demand/sector_may15/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
