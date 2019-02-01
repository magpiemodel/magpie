*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalars
  s56_reward_neg_emis reward CDR from all sources (-Inf) or only from afforestation (0) (1) / 0 /
  s56_limit_ch4_n2o_price upper limit for CH4 and N2O GHG prices (USD05MER per tC) / 1000 /
  s56_cprice_red_factor reduction factor for CO2 price (-) / 0.5 /
  s56_ghgprice_start start year for ghg price phase in / 2025 /
;

$setglobal c56_pollutant_prices  SSP2-26-SPA2-V15-REMIND-MAGPIE
$setglobal c56_emis_policy  ssp
$setglobal c56_aff_policy  vegc50

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
