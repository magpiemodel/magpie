*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Food demand
*'
*' @description The main function of the food demand module is to forecast
*' the food demand from agricultural products, which is used in the module [16_demand].
*' @authors Benjamin Leon Bodirsky, Jan Philipp Dietrich

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%food%" == "anthropometrics_jan18" $include "./modules/15_food/anthropometrics_jan18/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
