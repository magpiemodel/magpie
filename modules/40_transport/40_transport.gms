*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%transport%" == "gtap_nov12" $include "./modules/40_transport/gtap_nov12.gms"
$Ifi "%transport%" == "off" $include "./modules/40_transport/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
