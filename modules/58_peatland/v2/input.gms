*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
  s58_cost_rewet_recur           Recurring costs for rewetted peatland (USD17MER per ha) / 37 /
  s58_cost_rewet_onetime         One-time costs for peatland rewetting (USD17MER per ha) / 1230 /
  s58_cost_drain_recur           Recurring costs for drained and managed peatlands (USD17MER per ha) / 0 /
  s58_cost_drain_intact_onetime  One-time costs for drainage of intact peatland (USD17MER per ha) / 0 /
  s58_cost_drain_rewet_onetime   One-time costs for drainage of rewetted peatland (USD17MER per ha) / 0 /
  s58_rewetting_switch           Peatland rewetting on (Inf) or off (0) / Inf /
  s58_fix_peatland               Year indicating until when peatland area should be fixed (year) / 2020 /
  s58_balance_penalty            Penalty for technical peatland balance term (USD17MER) / 1e+06 /
  s58_rewetting_exo              Switch for exogenous peatland rewetting (1) / 0 /
  s58_rewet_exo_start_year       Start year for exogenous peatland rewetting / 2030 /
  s58_rewet_exo_target_year      Target year for exogenous peatland rewetting / 2050 /
  s58_rewet_exo_start_value      Start value for exogenous peatland rewetting as share of drained peatland in reference period (1) / 0.3 /
  s58_rewet_exo_target_value     Target value for exogenous peatland rewetting as share of drained peatland in reference period (1) / 0.5 /
;

*Peatland area based on Global Peatland Map 2.0 and Global Peatland Database
table f58_peatland_area(j,land58) Peatland area (mio. ha)
$ondelim
$include "./modules/58_peatland/input/f58_peatland_area.cs3"
$offdelim
;

*Wetland GHG emission factors based on IPCC Wetlands 2014 and Tiemeyer et al. 2020 
table f58_ipcc_wetland_ef(clcl58,land58,emis58) Wetland emission factors (Tg per yr)
$ondelim
$include "./modules/58_peatland/input/f58_ipcc_wetland_ef2.cs3"
$offdelim
;
