*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The main feature of the this realization is afforestation
*' for CDR. Afforestation can be modelled
*' exogenously (prescribed by NPI/NDC policies) and/or endogenously
*' (incentivized by a reward for CDR). National policies implemented (NPI) and
*' nationally determined contributions to the Paris agreement (NDC) for afforestation
*' are based on country reports. The interface `vm_cdr_aff` includes the expected CDR
*' and local bph effects from afforestation depending on the planning horizon `s32_planing_horizon`.
*' The reward for CDR and local bph effects from afforestation is calculated in the [56_ghg_policy] module.
*' In this realization, afforestation is modeled by default as regrowth
*' of natural vegetation (see @humpenoder_investigating_2014 for details on the implemenation).
*' The regrowth of natural vegetation follows S-shaped growth curves, which are  parametrized
*' based on @braakhekke_modelling_2019.
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
