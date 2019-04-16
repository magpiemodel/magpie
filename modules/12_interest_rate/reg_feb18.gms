*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description The reg_feb18 realization is the default setting,
*' in which the interest rate depends on the development state `im_development_state`,
*' which is calculated based on GDP per capita.
*' Thus, interest rates are regionally specific and dynamic over time.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/12_interest_rate/reg_feb18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/12_interest_rate/reg_feb18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/12_interest_rate/reg_feb18/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/12_interest_rate/reg_feb18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/12_interest_rate/reg_feb18/presolve.gms"
*######################## R SECTION END (PHASES) ###############################
