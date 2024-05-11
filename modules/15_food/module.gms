*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Food demand
*'
*' @description The food demand module forecasts the food demand vm_dem_food for
*' various agricultural products, which is used in the module [16_demand].
*' Drivers of food demand are population, income, and demographic structure from
*' module [09_drivers], as well as module-specific scenario assumptions.
*' In the case of elastic demand, the model uses the shadow price of
*' agricultural commodities q15_food_demand.m to change food demand and iterates
*' with MAgPIE until a common solution is found. Outputs include next to food
*' demand also projections of anthropometric parameters such as body height and
*' weight distribution, as well as phyiscal activity levels. In addition, this
*' module also provides information about nutrition attributes of foods that can
*' be used in other modules via the interface fm_nutrition_attributes.
*' @authors Benjamin Leon Bodirsky, Isabelle Weindl, Jan Philipp Dietrich

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%food%" == "anthro_iso_jun22" $include "./modules/15_food/anthro_iso_jun22/realization.gms"
$Ifi "%food%" == "anthropometrics_jan18" $include "./modules/15_food/anthropometrics_jan18/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
