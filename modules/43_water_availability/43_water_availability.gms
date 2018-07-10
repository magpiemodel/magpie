*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Water availability 
*'
*' @description The water availability module determines the water that is available 
*' in MAgPIE. The following water sources are currently implemented: surface water, 
*' groundwater, technical (like desalination etc) and ren_ground. Additionally, 
*' this module hosts the main water constraint that requires water withdrawals 
*' to be smaller or equal to available water. Information is passed to and received 
*' from the [42_water_demand] module.
*'
*' @authors Anne Biewald, Markus Bonsch

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%water_availability%" == "total_water_aug13" $include "./modules/43_water_availability/total_water_aug13.gms"
*###################### R SECTION END (MODULETYPES) ############################
