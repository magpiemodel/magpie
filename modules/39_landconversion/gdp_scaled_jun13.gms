*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description
*'In the gdp_scaled_jun13 realisation per hectare land conversion costs depend on GDP. At first, a minimum ($s39\_low\_lndcon$) and maxium ($s39\_high\_lndcon$) inital value of per hectare land conversion costs is defined in the GAMS code. Second, $s39\_low\_lndcon$ is assigend to the region with the lowest inital GDP, while $s39\_high\_lndcon$ is assigned to the region with the highest inital GDP. The inital per hectare land conversion costs of all other regions are distributed, within the range of $s39\_low\_lndcon$ and $s39\_high\_lndcon$, according the inital GDP values. In future time steps inital per hectare land conversion costs are scaled with GDP:

*' @limitations Land clearing costs are not accounted for.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/39_landconversion/gdp_scaled_jun13/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/39_landconversion/gdp_scaled_jun13/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/39_landconversion/gdp_scaled_jun13/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/39_landconversion/gdp_scaled_jun13/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/39_landconversion/gdp_scaled_jun13/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/39_landconversion/gdp_scaled_jun13/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/39_landconversion/gdp_scaled_jun13/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
