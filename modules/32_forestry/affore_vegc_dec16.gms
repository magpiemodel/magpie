*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In the affore_vegc_dec16 realisation, the forestry sector is static as 
*' described in the static realisation. But on top of the existing forestry land in 1995, 
*' forestry land can increase in size due to afforestation. Afforestation can be modelled
*' exogenously (prescribed by NPI/NDC policies) and/or endogenously 
*' (incentivized by a reward for CDR). National policies implemented (NPI) and 
*' nationally determined contributions to the Paris agreement (NDC) for afforestation 
*' are based on country reports. The reward for CDR from afforestation `vm_cdr_aff` 
*' consists of the projected CDR within a planing horizon of 30 years 
*' `s32_planing_horizon` multiplied 
*' with the carbon price and annuity factor in the [56_ghg_policy] module.
*' Technically, the reward for CDR from afforestation is a negative cash flow 
*' lowering the costs in the objective function of the model. 
*' In this realisation, afforestation is modeled as managed/assisted regrowth 
*' of natural vegetation (@humpenoder_investigating_2014). The regrowth of natural
*' vegetation follows S-shaped growth curves. 

*' @limitations static forestry sector

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/32_forestry/affore_vegc_dec16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/32_forestry/affore_vegc_dec16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/32_forestry/affore_vegc_dec16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/32_forestry/affore_vegc_dec16/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/32_forestry/affore_vegc_dec16/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/32_forestry/affore_vegc_dec16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/32_forestry/affore_vegc_dec16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
