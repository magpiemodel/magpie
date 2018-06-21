*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description This module realization calculates methane from different
*' agricultural sources based on the @ipcc_2006_2006.
*' Methane emission sources considered in the module are enteric fermentation,
*' animal waste management, and rice.

*' @limitations CH4 emissions from animal waste management may be
*' inconsistent with CH4 emissions from enteric fermentation.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/53_methane/ipcc2006_flexreg_apr16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/53_methane/ipcc2006_flexreg_apr16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/53_methane/ipcc2006_flexreg_apr16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/53_methane/ipcc2006_flexreg_apr16/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/53_methane/ipcc2006_flexreg_apr16/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/53_methane/ipcc2006_flexreg_apr16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/53_methane/ipcc2006_flexreg_apr16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
