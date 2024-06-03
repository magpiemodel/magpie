*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Bioenergy
*'
*' @description The bioenergy module provides a regional and crop-specific
*' bioenergy demand $vm\_dem\_bioen$ to the model (to the [16_demand] module).
*' For this calculation it requires
*' information on gross energy content (provided by [16_demand] module).
*' 
*' In addition to calculation of bioenergy quantities, the costs associated with 
*' the production are provided to the objective function in the [11_costs] module.
*'
*' @authors Jan Philipp Dietrich


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%bioenergy%" == "1st2ndgen_priced_feb24" $include "./modules/60_bioenergy/1st2ndgen_priced_feb24/realization.gms"
$Ifi "%bioenergy%" == "1stgen_priced_dec18" $include "./modules/60_bioenergy/1stgen_priced_dec18/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
