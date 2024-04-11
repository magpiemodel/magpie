*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization applies pollutant prices to different
*' emission types in Agriculture, Forestry and Other Land Use (AFOLU), 
*' depending on the GHG emission pricing policy defined in `c56_emis_policy`.
*' CO2 emissions from Land Use, Land-Use Change and Forestry (LULUCF) are calculated 
*' based on carbon stock changes between timesteps in the interface `vm_carbon_stock`. 
*' Note that the CO2 emissions subject to pricing can differ from the actual CO2 emissions, 
*' depending on the choice of `c56_carbon_stock_pricing`. 
*' In addition, the average annual reward for carbon dioxide removal (CDR)
*' and the reward or penalty of local biophysical effects
*' from afforestation [32_forestry] is calculated as the present value (PV) of all
*' future cash flows multiplied with an annuity factor. The PV is obtained by
*' multiplication of `vm_cdr_aff` with the corresponding carbon price and subsequent
*' discouting based on the given discount rate `pm_interest`.
*' Technically, the reward for CDR and bph effects from afforestation is a negative cash flow
*' lowering the costs in the objective function of the model.
*' If pollutant prices are zero, which is the default for reference scenarios without
*' mitigation, total emission costs entering the objective function are zero.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/56_ghg_policy/price_aug22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/56_ghg_policy/price_aug22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/56_ghg_policy/price_aug22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/56_ghg_policy/price_aug22/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/56_ghg_policy/price_aug22/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/56_ghg_policy/price_aug22/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/56_ghg_policy/price_aug22/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
