*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Nitrogen soil budget

*' @description The module 50_nr_soil_budget balances the nitrogen flows for crop land soils and pasture soils 
*' and calculates the resulting demand for inorganic fertilizer and associated costs.
 
*' @authors Benjamin Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%nr_soil_budget%" == "exoeff_aug16" $include "./modules/50_nr_soil_budget/exoeff_aug16.gms"
$Ifi "%nr_soil_budget%" == "off" $include "./modules/50_nr_soil_budget/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
