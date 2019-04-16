*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*' @description This realization
*' calculates annual land-related CO2 emissions as
*' difference of carbon stocks between the current and the previous time step.
*' Land-related CO2 emissions include CO2 emissions from land-use change as well as
*' changes in carbon stocks in the terrestrial biosphere due to climate change
*' (the later is only included if `c52_carbon_scenario = "cc"`).
*' The realization provides carbon density information on cellular level to all
*' land modules ([30_crop], [31_past], [32_forestry], [34_urban] and [35_natveg]),
*' which return land type specific carbon stocks to the carbon module. The realization
*' also provides carbon density for different age-classes, based on a
*' chapman-richards volume growth model, to the land modules [32_forestry] and [35_natveg]
*' [@humpenoder_investigating_2014].

*' @limitations CO2 emissions in the 1st time step (1995) are not meaningful because
*' carbon stock information prior to 1995 is not available

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/52_carbon/normal_dec17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/52_carbon/normal_dec17/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/52_carbon/normal_dec17/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/52_carbon/normal_dec17/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/52_carbon/normal_dec17/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/52_carbon/normal_dec17/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
