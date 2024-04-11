*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @title Employment

*' @description This module is used to calculate hourly labor costs in agriculutre
*' and the number of people employed in crop and livestock production. 
*' Hourly labor costs are calculated based on a regression with GDP pc from [09_drivers].
*' They can be increased by an externally set global minimum wage. Wages as well as 
*' productivity gain from higher wages are provided to [38_factor_costs], [70_livestock], 
*' and [57_maccs] to scale total labor costs accordingly.
*' The calculation of employment then uses labor costs for crop and livestock production
*' and mitigation coming from [38_factor_costs], [70_livestock], and [57_maccs].

*' @authors Debbora Leip

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%employment%" == "exo_may22" $include "./modules/36_employment/exo_may22/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
