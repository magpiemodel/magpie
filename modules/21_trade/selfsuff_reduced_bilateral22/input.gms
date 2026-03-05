*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c21_trade_liberalization  l909090r808080
*   options are "regionalized" and "globalized" and "fragmented"

$setglobal c21_trade_scenario  off
*   options: off, USAex, CHAdom, EURex

sets
  k_import21(k_trade) Commodities that can have additional imports to maintain feasibility
                    / wood, woodfuel /
;

scalars
  s21_trade_tariff            Switch to enable bilateral tariffs (1=on 0=off)  (1)                           / 1 /
  s21_trade_tariff_fadeout    Switch to linearly fade out tariffs between start and target year (1)  / 0 / 
  s21_trade_tariff_startyear  Year at which tariff fadeout begins                / 2025 /
  s21_trade_tariff_targetyear Year at which tariffs reach zero                  / 2050 /
  s21_tariff_factor           Post-calibration multiplicative factor on tariff rates (1)         / 1 /
  s21_import_supply_scenario  Target value for import supply ratio scalar at target year (1)    / 1 /
  s21_import_supply_scenario_targetyear Year at which import supply scenario factor reaches target (year) / 2050 /
  s21_stddev_lib_factor       Post-calibration multiplicative factor on the flexibility window width (1) / 1 /
  s21_cost_import             Penalty cost for additional forestry imports to maintain feasibility (USD17MER per tDM) / 1500 /
  s21_min_trade_margin_forestry Minimum transport margin for forestry products to prevent unrealistic trade (USD17MER per tDM) / 62 /
;

table f21_trade_bal_reduction(t_all,trade_groups21,trade_regime21) Share of inelastic trade pool (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_bal_reduction.cs3"
$offdelim;

table f21_self_suff(t_all,h,kall) Superregional self-sufficiency rates (1)
$ondelim
$include "./modules/21_trade/input/f21_trade_self_suff.cs3"
$offdelim;

table f21_trade_regional_balanceflow(t_all,i,kall) Domestic balance flows (mio. tDM per yr)
$ondelim
$include "./modules/21_trade/selfsuff_reduced_bilateral22/input/f21_trade_regional_balanceflow.cs3"
$offdelim;

table f21_trade_export_balanceflow(t_all,i,k_trade) Regional export balance flows (mio. tDM per yr)
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

parameter f21_trade_bilat_stddev(i_ex,i_im,k_trade,trade_stddev21)  Standard deviation of import supply ratios over rolling windows of 5 10 and 15 years (1)
/
$ondelim
$include "./modules/21_trade/selfsuff_reduced_bilateral22/input/f21_trade_bilat_stddev.cs5"
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
