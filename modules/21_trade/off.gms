*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/off/declarations.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/off/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
