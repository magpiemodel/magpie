*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization applies pollutant prices to different 
*' emission types depending on the emission pricing policy defined in `f56_emis_policy`. 
*' In addition, the average annual reward for carbon dioxide removal (CDR) 
*' from afforestation [32_forestry] is calculated as the present value (PV) of all 
*' future cash flows multiplied with an annuity factor. The PV is obtained by 
*' multiplication of `vm_cdr_aff` with the corresponding carbon price and subsequent 
*' discouting based on the given discount rate `pm_interest`. 
*' Technically, the reward for CDR from afforestation is a negative cash flow 
*' lowering the costs in the objective function of the model. 
*' If pollutant prices are zero, which is the default for reference scenarios without 
*' mitigation, total emission costs entering the objective function are zero.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/56_ghg_policy/price_jan20/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/56_ghg_policy/price_jan20/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/56_ghg_policy/price_jan20/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/56_ghg_policy/price_jan20/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/56_ghg_policy/price_jan20/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/56_ghg_policy/price_jan20/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/56_ghg_policy/price_jan20/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/56_ghg_policy/price_jan20/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
