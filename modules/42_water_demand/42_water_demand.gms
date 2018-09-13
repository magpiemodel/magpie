*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Water demand
*'
*' @description The water demand module determines the water demand in the following
*' sectors: agriculture, industry, electricity, domestic and ecosystem. 
*' Different scenarios for different water demand and environmental flow protection are
*' possible. The module receives information from the [17_production], [30_crop], [09_drivers]
*' and [43_water_availability] modules. It passes information to the module [43_water_availability]
*' and [11_costs].
*'
*' 
*' 
*' @authors Anne Biewald, Markus Bonsch

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%water_demand%" == "agr_sector_aug13" $include "./modules/42_water_demand/agr_sector_aug13.gms"
$Ifi "%water_demand%" == "all_sectors_aug13" $include "./modules/42_water_demand/all_sectors_aug13.gms"
*###################### R SECTION END (MODULETYPES) ############################
