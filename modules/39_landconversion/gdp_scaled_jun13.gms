*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/39_landconversion/gdp_scaled_jun13/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/39_landconversion/gdp_scaled_jun13/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/39_landconversion/gdp_scaled_jun13/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/39_landconversion/gdp_scaled_jun13/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/39_landconversion/gdp_scaled_jun13/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/39_landconversion/gdp_scaled_jun13/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/39_landconversion/gdp_scaled_jun13/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
