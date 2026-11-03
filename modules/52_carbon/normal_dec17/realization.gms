*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' This realization provides carbon density information on cellular level to all
*' land modules ([30_crop], [31_past], [32_forestry], [34_urban] and [35_natveg]).
*' The realization provides carbon density for different age-classes, based on a
*' Chapman-Richards growth model, to the land modules [32_forestry] and [35_natveg]
*' [@humpenoder_investigating_2014 and @braakhekke_modelling_2019].
*'
*' The Chapman-Richards growth parameters are read from the three-curve growth-parameter file
*' (natveg, other_planted, plantations); the carbon curve is never bent to a timber
*' target. Instead, when `s52_growingstock_calib = 1`, harvestable wood is matched to
*' FAO FRA 2025 growing stock by a per-region wood multiplier `lambda`, applied to
*' `im_growing_stock` in [14_yields] and leaving carbon density untouched:
*' `lambda = FRA target / area-weighted growing stock of the observation-based carbon curve`
*' (naturally regenerating forest weighted by the age-class distribution -> `pm_lambda_nrf`;
*' plantations sampled at the cellular rotation age -> `pm_lambda_pla`).
*' By default the naturally regenerating growth rate is leaned to the lower quartile of the observed
*' cell-rate distribution (`s52_natveg_growth_scalar`), the plantation carbon asymptote is anchored to the
*' observed managed plateau (`s52_plant_asymp_anchor`), and `lambda` is capped at the biomass expansion
*' factor (`s52_lambda_bef_cap`). The legacy Braakhekke curves remain selectable via `c52_growth_par_source`.

*' @limitations The carbon density asymptote (C_max) comes from LPJmL potential vegetation. For
*' plantations it is re-levelled to the observed managed plateau in the tropics by default
*' (`s52_plant_asymp_anchor`); naturally regenerating forest keeps the LPJmL potential, so undisturbed
*' regrowth is assumed to recover to natural old-growth carbon and chronically degraded forest that never
*' reaches its potential is not represented.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/52_carbon/normal_dec17/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/52_carbon/normal_dec17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/52_carbon/normal_dec17/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/52_carbon/normal_dec17/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/52_carbon/normal_dec17/scaling.gms"
$Ifi "%phase%" == "start" $include "./modules/52_carbon/normal_dec17/start.gms"
$Ifi "%phase%" == "preloop" $include "./modules/52_carbon/normal_dec17/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/52_carbon/normal_dec17/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
