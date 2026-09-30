*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The main features of this realization are re/afforestation for CDR
*' and timber production. Re/afforestation can be modelled exogenously (prescribed
*' by NPI/NDC policies) and/or endogenously (incentivized by a reward for CDR).
*' National policies implemented (NPI) and nationally determined contributions to
*' the Paris agreement (NDC) for re/afforestation are based on country reports. The
*' interface `vm_cdr_aff` includes the expected CDR and local bph effects from
*' re/afforestation depending on the planning horizon `s32_planning_horizon`. The
*' reward for CDR and local bph effects from re/afforestation is calculated in the
*' [56_ghg_policy] module. In this realization, re/afforestation is modeled by default
*' as regrowth of natural vegetation (see @humpenoder_investigating_2014 for details on the implemenation).
*' The regrowth of natural vegetation follows S-shaped growth curves parametrized via
*' module [52_carbon], which provides three forest growth curves along the FRA continuum: naturally
*' regenerating forest [@robinson_protect_2025], other planted forest (a natveg-derived curve), and
*' plantations [@bukoski_rates_2022]. Additionally this module handles the production of two timber
*' products i.e., wood and woodfuel from the harvestable managed-forestry pools (timber plantations and
*' other planted forest) while still accounting for afforestation
*' policies. New plantations are also established in the simulation step to account for future timber
*' demand. Plantation rotation lengths are an external per-biome input (`f32_plant_rotation`,
*' area-weighted over Koeppen classes and converted to 5-yr age classes) and are the single source of
*' truth for both the cellular (establishment/harvest) rotation and the regional (economic) rotation.
*' For harvesting decisions we assume that land owners stick to their establishment decision,
*' e.g. if a plantation has been established with a rotation length of 30 years
*' it will be harvested after 30 years, even so the rotation length in the prevailing
*' time step, used for establishment, is shorter or longer. See @mishra_forestry_2021 for more details.
*' Replanted plantations receive a reduced establishment cost (`s32_est_cost_plant_reest`)
*' reflecting lower costs for re-establishment on recently harvested plantation land.

*' @limitations Rotation lengths for timber plantations are not endogenous.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/32_forestry/dynamic_may24/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/32_forestry/dynamic_may24/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/32_forestry/dynamic_may24/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/32_forestry/dynamic_may24/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/32_forestry/dynamic_may24/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/32_forestry/dynamic_may24/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/32_forestry/dynamic_may24/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/32_forestry/dynamic_may24/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
