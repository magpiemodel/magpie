*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The price_sep16 realization applies pollutant prices to different 
*' emission types depending on the emission pricing policy defined in `f56_emis_policy`. 
*' In addition, carbon dioxide removal (CDR) from afforestation [32_forestry] is 
*' rewarded depending on the afforestation incentive policy defined in `f56_aff_policy`.
*' For CO2 emissions from land-use change and CDR from afforestation, the growth rate 
*' of the CO2 price is used to annuitize associated emission costs.
*' If pollutant prices are zero, which is the default for reference scenarios without 
*' mitigation, total emission costs entering the objective function are zero.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/56_ghg_policy/price_jan20/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/56_ghg_policy/price_jan20/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/56_ghg_policy/price_jan20/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/56_ghg_policy/price_jan20/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/56_ghg_policy/price_jan20/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/56_ghg_policy/price_jan20/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/56_ghg_policy/price_jan20/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
