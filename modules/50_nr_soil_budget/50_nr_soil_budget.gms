*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Nitrogen soil budget

*' @description The module 50_nr_soil_budget balances the nitrogen flows for crop land soils and pasture soils 
*' and calculates the resulting demand for inorganic fertilizer and associated costs.
 
*' @authors Benjamin Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%nr_soil_budget%" == "exoeff_aug16" $include "./modules/50_nr_soil_budget/exoeff_aug16.gms"
$Ifi "%nr_soil_budget%" == "off" $include "./modules/50_nr_soil_budget/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
