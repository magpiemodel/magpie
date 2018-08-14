*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

$setglobal c39_cost_scenario_establish  magpie3
* options: off, low, medium, high, veryhigh, magpie3, pure_estab
$setglobal c39_cost_scenario_clearing  corrected
* options: off, verylow, low, medium, high, corrected


table f39_landclear_gdp(cost_estimate39,bound39) global range of land clearing costs in inital timestep (US$ per ton C)
$ondelim
$include "./modules/39_landconversion/gdp_vegc_may18/input/f39_landclear_gdp.cs3"
$offdelim;


table f39_establish_gdp(land,cost_estimate39,bound39) global range of land establishment costs in inital timestep (US$ per hectare)
$ondelim
$include "./modules/39_landconversion/gdp_vegc_may18/input/f39_establish_gdp.cs3"
$offdelim;
