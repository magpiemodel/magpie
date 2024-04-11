*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Water availability 
*'
*' @description The water availability module determines the water that is available 
*' in MAgPIE. The following water sources are currently implemented: surface water, 
*' groundwater, technical (like desalination etc.). Additionally, 
*' this module includes the main water constraint that requires water withdrawals 
*' to be smaller or equal to available water. Information is passed to and received 
*' from the [42_water_demand] module.
*'
*' @authors Anne Biewald, Markus Bonsch

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%water_availability%" == "total_water_aug13" $include "./modules/43_water_availability/total_water_aug13/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
