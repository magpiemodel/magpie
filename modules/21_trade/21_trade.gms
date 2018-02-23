*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%trade%" == "free_apr16" $include "./modules/21_trade/free_apr16.gms"
$Ifi "%trade%" == "off" $include "./modules/21_trade/off.gms"
$Ifi "%trade%" == "selfsuff_flexreg" $include "./modules/21_trade/selfsuff_flexreg.gms"
$Ifi "%trade%" == "selfsuff_flexreg_cost" $include "./modules/21_trade/selfsuff_flexreg_cost.gms"  
*###################### R SECTION END (MODULETYPES) ############################