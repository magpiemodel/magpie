*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
  s58_cost_rewet_recur Recurring costs for rewetted peatland (USD05MER per ha) / 200 /
  s58_cost_rewet_onetime One-time costs for peatland restoration (USD05MER per ha) / 7000 /
  s58_cost_degrad_recur Recurring costs for degraded peatland (USD05MER per ha) / 0 /
  s58_cost_degrad_onetime One-time costs for peatland degradation (USD05MER per ha) / 0 /
  s58_rewetting_switch Peatland rewetting on (Inf) or off (0) / Inf /
  s58_fix_peatland Year indicating until when peatland area should be fixed to 2015 levels (year) / 2015 /
  s58_cost_balance Artificial cost for balance variable (USD05MER per ha) / 1e+06 /
;

parameters
f58_peatland_degrad(j) Degrading peatland area (mio. ha)
/
$ondelim
$include "./modules/58_peatland/input/f58_peatland_degrad.cs2"
$offdelim
/
;

parameters
f58_peatland_intact(j) Intact peatland area (mio. ha)
/
$ondelim
$include "./modules/58_peatland/input/f58_peatland_intact.cs2"
$offdelim
/
;

table f58_ipcc_wetland_ef(clcl58,land58,emis58,ef58) Wetland GWP100 emission factors (t CO2eq per ha)
$ondelim
$include "./modules/58_peatland/input/f58_ipcc_wetland_ef.cs3"
$offdelim
;
