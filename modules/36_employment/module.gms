*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @title Employment

*' @description This module is used to calculate hourly labor costs in agriculutre
*' and the number of people employed in crop and livestock production. 
*' The calculation is based on labor costs in crop and livestock production
*' coming from [38_factor_costs] and [70_livestock], as well as GDP pc from
*' [09_drivers]. 

*' @authors Debbora Leip

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%employment%" == "exo_may22" $include "./modules/36_employment/exo_may22/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
