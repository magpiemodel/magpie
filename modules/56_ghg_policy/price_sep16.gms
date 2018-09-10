*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description The price_sep16 realization applies pollutant prices to different 
*' emission types depending on the emission pricing policy defined in `f56_emis_policy`. 
*' In addition, carbon dioxide removal (CDR) from afforestation [32_forestry] is 
*' rewarded depending on the afforestation incentive policy defined in `f56_aff_policy`.
*' For CO2 emissions from land-use change and CDR from afforestation, the growth rate 
*' of the CO2 price is used to annuitize associated emission costs.
*' If pollutant prices are zero, which is the default for referene scenarios without 
*' mitigation, total emission costs entering the objective function are zero.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/56_ghg_policy/price_sep16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/56_ghg_policy/price_sep16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/56_ghg_policy/price_sep16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/56_ghg_policy/price_sep16/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/56_ghg_policy/price_sep16/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/56_ghg_policy/price_sep16/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/56_ghg_policy/price_sep16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
