*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The main feature of the affore_vegc_dec16 realization is afforestation
*' for CDR. Afforestation can be modelled
*' exogenously (prescribed by NPI/NDC policies) and/or endogenously
*' (incentivized by a reward for CDR). National policies implemented (NPI) and
*' nationally determined contributions to the Paris agreement (NDC) for afforestation
*' are based on country reports. The reward for CDR from afforestation `vm_cdr_aff`
*' consists of the projected CDR within a planing horizon of 30 years
*' `s32_planing_horizon` multiplied
*' with the carbon price and annuity factor in the [56_ghg_policy] module.
*' Technically, the reward for CDR from afforestation is a negative cash flow
*' lowering the costs in the objective function of the model.
*' In this realization, afforestation is modeled as managed/assisted regrowth
*' of natural vegetation (@humpenoder_investigating_2014). The regrowth of natural
*' vegetation follows S-shaped growth curves.
*' Note that existing forestry plantations in 1995 dedicated to wood production are assumed constant throughout time.

*' @limitations Forestry activities such as establishment or
*' harvest of plantations for wood production are not modeled. 

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/32_forestry/dynamic_oct19/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/32_forestry/dynamic_oct19/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/32_forestry/dynamic_oct19/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/32_forestry/dynamic_oct19/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/32_forestry/dynamic_oct19/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/32_forestry/dynamic_oct19/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/32_forestry/dynamic_oct19/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/32_forestry/dynamic_oct19/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
