*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The main feature of the this realization is afforestation for CDR
*' and timber production. Afforestation can be modelled exogenously (prescribed
*' by NPI/NDC policies) and/or endogenously (incentivized by a reward for CDR).
*' National policies implemented (NPI) and nationally determined contributions to
*' the Paris agreement (NDC) for afforestation are based on country reports. The
*' interface `vm_cdr_aff` includes the expected CDR and local bph effects from
*' afforestation depending on the planning horizon `s32_planing_horizon`. The
*' reward for CDR and local bph effects from afforestation is calculated in the
*' [56_ghg_policy] module. In this realization, afforestation is modeled by default
*' as regrowth of natural vegetation (see @humpenoder_investigating_2014 for details on the implemenation).
*' The regrowth of natural vegetation follows S-shaped growth curves, which are
*' parametrized based on @braakhekke_modelling_2019. Additionally this module
*' handles the production of two timber products i.e., wood and woodfuel from
*' plantation forests while still accounting for afforestation policies. New plantations
*' are also established in the simulation step to account for future timber demand.
*' This module also calculates the rotation lengths before the solve loop by equating
*' Instantaneous Growth Rates (IGR) and interest rate `pm_interest` based on
*' @amacher2009economics. We have to make assumptions regarding the rotation lengths
*' to be used for establishment and harvesting decisions. For establishment we just
*' use the calculated rotations either based on a Single Rotation-Period Model or
*' based on Faustamnn rotations according to the switch `s32_faustmann_rotation`.
*' For harvesting we assume that land owners stick to their establishment decision,
*' e.g. if a plantation has been established with a rotation length of 30 years
*' it will be harvested after 30 years, even so the rotation length in the prevailing
*' time step, used for establishment, is shorter or longer.

*' @limitations Rotation lengths for timber plantations are not endogenous.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/32_forestry/dynamic_may20/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/32_forestry/dynamic_may20/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/32_forestry/dynamic_may20/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/32_forestry/dynamic_may20/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/32_forestry/dynamic_may20/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/32_forestry/dynamic_may20/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/32_forestry/dynamic_may20/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/32_forestry/dynamic_may20/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
