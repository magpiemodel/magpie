*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*' @title Disaggregation of livestock distribution
*'
*' @description The module 71_disagg_lvst calculates the livestock distribution within a region onto 
*' cellular level. Without constrains in this module cellular livestock production is determined by 
*' the modules 40_transport accounting for transport costs and module 42_water_demand connecting 
*' livestock production to water demand and thus to water availability.
*'
*' @authors Kristine Karstens, Benjamin Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%disagg_lvst%" == "foragebased_aug18" $include "./modules/71_disagg_lvst/foragebased_aug18.gms"
$Ifi "%disagg_lvst%" == "off" $include "./modules/71_disagg_lvst/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
