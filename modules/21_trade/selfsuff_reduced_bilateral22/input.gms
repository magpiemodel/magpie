*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c21_trade_liberalization  l909090r808080
*   options are "regionalized" and "globalized" and "fragmented"

sets
  k_import21(k_trade) Commodities that can have additional imports to maintain feasibility
                    / wood, woodfuel /
;

scalars
  s21_trade_tariff                        Trade tariff switch (1=on 0=off)  (1)                                  / 1 /
  s21_trade_tariff_factor                 Target multiplier for trade tariff fade (1=no change 0=fade to zero)   / 1 /
  s21_trade_tariff_startyear              Year to start fading trade tariffs towards target multiplier           / 2025 /
  s21_trade_tariff_targetyear             Year to finish fading trade tariffs towards target multiplier          / 2050 /
  s21_import_supply_scenario              Multiplicative factor on the line                                      / 1 /
  s21_import_supply_scenario_targetyear   Target year for fade in                                                / 2050 /
  s21_flexBand_lib_factor                   Multiplicative factor on the window                                    / 1 /
  s21_cost_import                         Cost for additional imports to maintain feasibility (USD17MER per tDM) / 1500 /
  s21_min_trade_margin_forestry           Minimum trade margin for forestry products (USD17MER per tDM)          / 62 /
  s21_trade_scenario_adjustments          Switch to apply scenario adjustments to import supply (0=off 1=on)     / 0 /
;

table f21_self_suff(t_all,h,kall) Superregional self-sufficiency rates (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_self_suff.cs3"
$offdelim;

table f21_trade_regional_balanceflow(t_all,i,kall) Balanceflow to match historic inconsistencies between supply and demand (mio. tDM per yr)
$ondelim
$include "./modules/21_trade/selfsuff_reduced_bilateral22/input/f21_trade_regional_balanceflow.cs3"
$offdelim;

table f21_trade_export_balanceflow(t_all,i,k_trade) Balanceflow to match historic inconsistencies between trade matrix exports and FAO massbalance  (mio. tDM per yr)
$ondelim
$include "./modules/21_trade/selfsuff_reduced_bilateral22/input/f21_trade_export_balanceflow.cs3"
$offdelim;

parameter f21_trade_scenario_adjustments(i_ex,i_im,t_all,k_trade) Exogenous additive adjustments to bilateral import supply ratios for policy scenarios (1)
/
$ondelim
$include "./modules/21_trade/selfsuff_reduced_bilateral22/input/f21_trade_scenario_adjustments.cs5"
$offdelim
/;

parameter f21_import_supply_historical(i_ex,i_im,t_all,k_trade)  Share of importer domestic supply sourced from each exporter derived from FAOSTAT (1)
/
$ondelim
$include "./modules/21_trade/selfsuff_reduced_bilateral22/input/f21_import_supply_historical.cs5"
$offdelim
/;

** The flexibility band is calculated from the historic trade matrix by taking the rolling RANGE (max - min) of the
** import supply ratios over all 5-year, 10-year, and 15-year windows from 1990 onwards, then the min, mean and max
** of those rolling ranges for each window length. The model uses the MEAN variant (selected in the preloop): a
** data-driven, widening flexibility window - 5 years into the simulation the model may deviate by the mean range
** observed over 5-year windows in history, and so on for 10 and 15 years. The band is capped at 1 in preprocessing
** (a window wider than the importer's whole domestic supply is meaningless). The max variant (peak observed
** variability, wider, provably monotone) and the min variant are also provided and can be selected in the preloop.

parameter f21_trade_bilat_flexBand(i_ex,i_im,k_trade,trade_flexBand21)  Historical flexibility band (rolling range of import supply ratios) over 5 10 and 15 year windows (1)
/
$ondelim
$include "./modules/21_trade/selfsuff_reduced_bilateral22/input/f21_trade_bilat_flexBand.cs5"
$offdelim
/;

parameter f21_trade_margin(i_ex,i_im,kall) Bilateral freight and insurance costs between region pairs (USD05MER per tDM)
/
$ondelim
$include "./modules/21_trade/selfsuff_reduced_bilateral22/input/f21_trade_margin_bilat.cs5"
$offdelim
/;

parameter f21_trade_tariff(i_ex,i_im,kall) Bilateral specific duty tariff rates by region pair (USD17MER per tDM)
/
$ondelim
$include "./modules/21_trade/selfsuff_reduced_bilateral22/input/f21_trade_tariff_bilat.cs5"
$offdelim
/;
