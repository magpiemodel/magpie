*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Water demand
*'
*' @description The water demand module determines the water demand in the following
*' sectors: agriculture, manufacturing, electricity, domestic and ecosystem. 
*' Different scenarios for different water demand and environmental flow protection are
*' possible. The module receives information from the [17_production], [30_crop], [09_drivers]
*' and [43_water_availability] modules. It passes information to the module [43_water_availability]
*' and [11_costs].
*'
*'
*'
*' @authors Anne Biewald, Markus Bonsch

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%water_demand%" == "agr_sector_aug13" $include "./modules/42_water_demand/agr_sector_aug13/realization.gms"
$Ifi "%water_demand%" == "all_sectors_aug13" $include "./modules/42_water_demand/all_sectors_aug13/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
