*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c09_pop_scenario  SSP2
*   options:   SSP: "SSP1", "SSP2", "SP3", "SSP4", "SSP5", "SSP2EU"
*              SDP: "SDP", SDP_EI", "SDP_MC", "SDP_RC"

$setglobal c09_gdp_scenario  SSP2
*   options:   SSP: "SSP1", "SSP2", "SSP3", "SSP4", "SSP5",  "SSP2EU"
*              SDP: "SDP", "SDP_EI",  "SDP_MC", "SDP_RC"

$setglobal c09_pal_scenario  SSP2
*   options:   SSP: "SSP1", "SSP2", "SSP3", "SSP4", "SSP5",  "SSP2EU"
*              SDP: "SDP", "SDP_EI",  "SDP_MC", "SDP_RC"

parameters
* Years where SSPs and nocc/cc scenarios diverge
  sm_fix_SSP2               year until which all parameters are fixed to SSP2 values (year) / 2025 /
  sm_fix_cc                 year until which all parameters affected by cc are fixed to historical values (year) / 2025 /
;

table f09_gdp_ppp_iso(t_all,iso,pop_gdp_scen09) Income in purchasing power parity (mio. USD05PPP per yr)
$ondelim
$include "./modules/09_drivers/input/f09_gdp_ppp_iso.csv"
$offdelim;

table f09_gdp_mer_iso(t_all,iso,pop_gdp_scen09)  Income in market exchange rates (mio. USD05MER per yr)
$ondelim
$include "./modules/09_drivers/input/f09_gdp_mer_iso.csv"
$offdelim;

table f09_pop_iso(t_all,iso,pop_gdp_scen09) Population (mio. capita per yr)
$ondelim
$include "./modules/09_drivers/input/f09_pop_iso.csv"
$offdelim;

table f09_development_state(t_all,i,pop_gdp_scen09) Development state according to the World Bank definition where 0=low income country 1=high income country in high income level (1)
$ondelim
$include "./modules/09_drivers/input/f09_development_state.cs3"
$offdelim;

table f09_demography(t_all,iso,pop_gdp_scen09,sex,age) Population (mio. capita per yr)
$ondelim
$include "./modules/09_drivers/input/f09_demography.cs3"
$offdelim;

table f09_physical_inactivity(t_all,iso,pop_gdp_scen09,sex,age) Share of population which is physically inactive (1)
$ondelim
$include "./modules/09_drivers/input/f09_physical_inactivity.cs3"
$offdelim;
