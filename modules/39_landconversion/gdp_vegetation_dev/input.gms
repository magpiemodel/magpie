*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$setglobal c39_cost_scenario  medium
* options: low, medium, high


table f39_landclear_gdp(cost_estimate39,bound39) lower and upper bound for land clearing costs in inital timestep ($US per ha)
$ondelim
$include "./modules/39_landconversion/gdp_vegetation_dev/input/f39_landclear_gdp.csv"
$offdelim;


table f39_establish_gdp(land,cost_estimate39,bound39) lower and upper bound for land establishing costs in inital timestep ($US per ha)
$ondelim
$include "./modules/39_landconversion/gdp_vegetation_dev/input/f39_establish_gdp.cs3"
$offdelim;
