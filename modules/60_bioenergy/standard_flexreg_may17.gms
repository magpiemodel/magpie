*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' Calculation of first and second generation bioenergy demand on the regional
*' level.
*'
*' @limitations

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/60_bioenergy/standard_flexreg_may17/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/60_bioenergy/standard_flexreg_may17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/60_bioenergy/standard_flexreg_may17/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/60_bioenergy/standard_flexreg_may17/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/60_bioenergy/standard_flexreg_may17/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/60_bioenergy/standard_flexreg_may17/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/60_bioenergy/standard_flexreg_may17/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
