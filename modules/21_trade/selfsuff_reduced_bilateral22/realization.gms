*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization implements bilateral trade between world regions
*' based on historically observed import supply ratios. The import supply ratio
*' expresses the share of an importing region's domestic supply that is sourced
*' from a specific exporting region, i.e. x% of region i's supply of product k
*' must be imported from exporter j. These ratios are derived from FAOSTAT
*' bilateral trade data and held forward from the last observed historical period.
*'
*' Trade volumes are constrained by upper and lower bounds around the historical
*' import supply ratio, with a relaxation window defined by the observed standard
*' deviation of these ratios over recent history. Formally, for each
*' exporter-importer-product combination:
*'
*'   supply(im,k) * [ratio(ex,im,k) * scenarioFactor - libFactor * stddev(ex,im,k)]
*'     <= trade(ex,im,k) <=
*'   supply(im,k) * [ratio(ex,im,k) * scenarioFactor + libFactor * stddev(ex,im,k)]
*'
*' The `scenarioFactor` (`i21_import_supply_scenario`) allows scaling the
*' historical ratios up or down over time (e.g. to simulate trade liberalization
*' or protectionism). The `libFactor` (`i21_stddev_lib_factor`) widens or
*' narrows the flexibility window around the historical pattern.
*'
*' Within these bounds, the optimizer allocates trade to minimize total costs,
*' which include bilateral transport margins and bilateral tariffs. Margins
*' represent freight and insurance costs between specific region pairs. Tariffs
*' are specific duty rates (USD per tDM) that can be faded out over a
*' configurable time horizon. Margins and tariffs are applied to the traded volume
*' and assigned to the exporting region.
*'
*' Scenario-specific adjustments to individual bilateral ratios can be applied
*' via `f21_trade_scenario_adjustments` (controlled by `c21_trade_scenario`),
*' selecting a named geopolitical scenario (USAex, CHAdom, EURex) or "off".
*' When a scenario is selected, hardcoded additive perturbations are written
*' into the zero-initialized adjustment table and applied to the historical
*' ratios from sm_fix_SSP2 onward, enabling targeted policy experiments such
*' as reducing a country's import dependence on a specific trading partner.
*'
*' The standard deviation bounds open from the simulation year (sm_fix_SSP2) onwards,
*' with the level opening based on historically observed standard deviations, with
*' the first 5 year time step at the max std observed over the all 5 years moving windows 
*' of the historical period for the exporter-importer and product combination. 
*' 10 years into the simulation period, the std dev window opens to the max std dev observed
*' over all 10 year moving windows over the historical period, and the same happens at 15 years,
*' after which the window remains fixed at the maximum observed historical standard deviation,
*' allowing the flexibility window to evolve over time.
*'
*' Non-tradable commodities (fodder, pasture, residues, bioenergy crops) are
*' constrained to be produced within the super-region where they are consumed.
*' A regional production constraint including trade flows ensures that 
*' world production covers total world supply plus any balance flows.

*' @limitations Trade patterns are anchored to historically observed bilateral
*' import supply ratios, so structural shifts in trade partnerships beyond
*' the scenario adjustments are not endogenously modeled. The standard deviation
*' window provides some flexibility but does not capture potential new trade
*' corridors with no historical precedent. Bilateral margins and tariffs are
*' static inputs (with optional tariff fadeout) and do not respond endogenously
*' to price changes. The realization operates at the MAgPIE world-region level
*' rather than country level.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/21_trade/selfsuff_reduced_bilateral22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/selfsuff_reduced_bilateral22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/21_trade/selfsuff_reduced_bilateral22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/selfsuff_reduced_bilateral22/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/21_trade/selfsuff_reduced_bilateral22/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/selfsuff_reduced_bilateral22/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/21_trade/selfsuff_reduced_bilateral22/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/selfsuff_reduced_bilateral22/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
