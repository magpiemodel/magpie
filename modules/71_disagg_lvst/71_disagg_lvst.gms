*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%disagg_lvst%" == "foragebased_aug18" $include "./modules/71_disagg_lvst/foragebased_aug18.gms"
$Ifi "%disagg_lvst%" == "off" $include "./modules/71_disagg_lvst/off.gms"
$Ifi "%disagg_lvst%" == "simple_oct17" $include "./modules/71_disagg_lvst/simple_oct17.gms"
*###################### R SECTION END (MODULETYPES) ############################
