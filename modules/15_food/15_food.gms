*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Food demand
*'
*' @description The main function of the food demand module is to forecast
*' the fooduse of agricultural products, which is used in [16_demand].
*' @authors Benjamin Leon Bodirsky, Jan Philipp Dietrich

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%food%" == "anthropometrics_jan18" $include "./modules/15_food/anthropometrics_jan18.gms"
$Ifi "%food%" == "bmi_share_jul18" $include "./modules/15_food/bmi_share_jul18.gms"
*###################### R SECTION END (MODULETYPES) ############################
