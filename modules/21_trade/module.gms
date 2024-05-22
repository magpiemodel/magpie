*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Agricultural trade
*'
*' @description This module represents agricultural trade among world regions.
*' It ensures that the regional demand is met by domestic production and imports from other regions.
*' The global trade balance dictates that global production must be larger than or equal to global demand.
*' For non-traded goods, the regional production must be larger than or equal to regional demand.
*'
*'
*' @authors  Xiaoxi Wang, Anne Biewald, Christoph Schmitz, Markus Bonsch
*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%trade%" == "exo" $include "./modules/21_trade/exo/realization.gms"
$Ifi "%trade%" == "free_apr16" $include "./modules/21_trade/free_apr16/realization.gms"
$Ifi "%trade%" == "off" $include "./modules/21_trade/off/realization.gms"
$Ifi "%trade%" == "selfsuff_reduced" $include "./modules/21_trade/selfsuff_reduced/realization.gms"
$Ifi "%trade%" == "selfsuff_reduced_bilateral22" $include "./modules/21_trade/selfsuff_reduced_bilateral22/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
