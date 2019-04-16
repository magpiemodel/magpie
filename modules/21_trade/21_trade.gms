*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Agricultural trade
*'
*' @description This module represents agricutlural trade among world regions.
*' It ensures that the regional demand is met by domestic production and imports from other regions.
*' The global trade balance dictates that global production must be larger than or equal to global demand.
*' For non-traded goods, the regional production must be larger than or equal to regional demand.
*'
*'
*' @authors  Xiaoxi Wang, Anne Biewald, Christoph Schmitz, Markus Bonsch
*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%trade%" == "free_apr16" $include "./modules/21_trade/free_apr16.gms"
$Ifi "%trade%" == "off" $include "./modules/21_trade/off.gms"
$Ifi "%trade%" == "selfsuff_reduced" $include "./modules/21_trade/selfsuff_reduced.gms"
*###################### R SECTION END (MODULETYPES) ############################
