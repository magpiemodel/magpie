*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%water_demand%" == "agr_sector_aug13" $include "./modules/42_water_demand/agr_sector_aug13.gms"
$Ifi "%water_demand%" == "all_sectors_aug13" $include "./modules/42_water_demand/all_sectors_aug13.gms"
*###################### R SECTION END (MODULETYPES) ############################
