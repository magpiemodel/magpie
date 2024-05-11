*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Disaggregation of livestock distribution
*'
*' @description The module 71_disagg_lvst calculates the livestock distribution within a region onto
*' cellular level. Without constrains in this module cellular livestock production is determined by
*' the modules 40_transport accounting for transport costs and module 42_water_demand connecting
*' livestock production to water demand and thus to water availability.
*'
*' @authors Kristine Karstens, Benjamin Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%disagg_lvst%" == "foragebased_aug18" $include "./modules/71_disagg_lvst/foragebased_aug18/realization.gms"
$Ifi "%disagg_lvst%" == "foragebased_jul23" $include "./modules/71_disagg_lvst/foragebased_jul23/realization.gms"
$Ifi "%disagg_lvst%" == "off" $include "./modules/71_disagg_lvst/off/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
