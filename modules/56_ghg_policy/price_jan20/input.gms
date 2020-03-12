*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Set-switch for countries affected by regional ghg policy
* Default: all iso countries selected
sets
  ghg_policy_countries(iso) countries to be affected by ghg policy / DEU, FRA /
;

scalars
  s56_reward_neg_emis reward CDR from all sources (-Inf) or only from afforestation (0) (1) / 0 /
  s56_limit_ch4_n2o_price upper limit for CH4 and N2O GHG prices (USD05MER per tC) / 1000 /
  s56_cprice_red_factor reduction factor for CO2 price (-) / 1 /
  s56_ghgprice_start start year for ghg price phase-in (year) / 2025 /
  s56_ghgprice_phase_in  Switch for phasing-in GHG price over a 20 year period  (1=on 0=off) / 0 /
  s56_ghgprice_devstate_scaling Switch for scaling GHG price with development state (1=on 0=off) / 0 /
  s56_c_price_induced_aff Switch for C price driven afforestation (1=on 0=off) / 1 /
  s56_c_price_exp_aff c price expectation for afforestation (years) / 50 /
  s56_buffer_aff share of carbon credits for afforestation projects pooled in a buffer (1) / 0.2 /
  s56_counter counter for C price interpolation (1) / 0 /
  s56_timesteps number of time steps for C price interpolation (1) / 0 /
  s56_offset helper for C price interpolation (1) / 0 /
;

$setglobal c56_pollutant_prices  R2M41-SSP2-NPi
$setglobal c56_emis_policy  redd+_nosoil

table f56_pollutant_prices(t_all,i,pollutants,ghgscen56) GHG certificate prices for N2O-N CH4 CO2-C (USD05MER per t)
$ondelim
$include "./modules/56_ghg_policy/input/f56_pollutant_prices.cs3"
$offdelim
;

$if "%c56_pollutant_prices%" == "coupling" table f56_pollutant_prices_coupling(t_all,i,pollutants) Regional ghg certificate prices for N2O-N CH4 CO2-C (USD05MER per t)
$if "%c56_pollutant_prices%" == "coupling" $ondelim
$if "%c56_pollutant_prices%" == "coupling" $include "./modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3"
$if "%c56_pollutant_prices%" == "coupling" $offdelim
$if "%c56_pollutant_prices%" == "coupling" ;

$if "%c56_pollutant_prices%" == "emulator" table f56_pollutant_prices_emulator(t_all,pollutants) Global ghg certificate prices for N2O-N CH4 CO2-C (USD05MER per t)
$if "%c56_pollutant_prices%" == "emulator" $ondelim
$if "%c56_pollutant_prices%" == "emulator" $include "./modules/56_ghg_policy/input/f56_pollutant_prices_emulator.cs3"
$if "%c56_pollutant_prices%" == "emulator" $offdelim
$if "%c56_pollutant_prices%" == "emulator" ;

*' `f56_emis_policy` contains scenarios determining for each gas and source whether it is priced or not.

table f56_emis_policy(scen56,pollutants_all,emis_source) GHG emission policy scenarios (1)
$ondelim
$include "./modules/56_ghg_policy/input/f56_emis_policy.csv"
$offdelim
;
