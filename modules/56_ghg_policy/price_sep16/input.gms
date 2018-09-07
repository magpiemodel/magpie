*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalars
  s56_reward_neg_emis "reward negative co2 emissions (-Inf) or not (0)" / 0 /
;

$setglobal c56_pollutant_prices  SSP2-Ref-SPA0-V15-REMIND-MAGPIE
$setglobal c56_emis_policy  ssp
$setglobal c56_aff_policy  vegc50

table f56_pollutant_prices(t_all,i,pollutants,ghgscen56) ghg certificate prices for N2O-N CH4 CO2-C (USD2004 per Mg)
$ondelim
$include "./modules/56_ghg_policy/input/f56_pollutant_prices.cs3"
$offdelim
;

$if "%c56_pollutant_prices%" == "coupling" table f56_pollutant_prices_coupling(t_all,i,pollutants) regional ghg certificate prices for N2O-N CH4 CO2-C (USD2004 per Mg)
$if "%c56_pollutant_prices%" == "coupling" $ondelim
$if "%c56_pollutant_prices%" == "coupling" $include "./modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3"
$if "%c56_pollutant_prices%" == "coupling" $offdelim
$if "%c56_pollutant_prices%" == "coupling" ;

$if "%c56_pollutant_prices%" == "emulator" table f56_pollutant_prices_emulator(t_all,pollutants) global ghg certificate prices for N2O-N CH4 CO2-C (USD2004 per Mg)
$if "%c56_pollutant_prices%" == "emulator" $ondelim
$if "%c56_pollutant_prices%" == "emulator" $include "./modules/56_ghg_policy/input/f56_pollutant_prices_emulator.cs3"
$if "%c56_pollutant_prices%" == "emulator" $offdelim
$if "%c56_pollutant_prices%" == "emulator" ;

*' `f56_emis_policy` contains scenarios determining for each gas and source whether it is priced or not.

table f56_emis_policy(scen56,pollutants_all,emis_source) emission policy scenarios
$ondelim
$include "./modules/56_ghg_policy/input/f56_emis_policy.csv"
$offdelim
;

*' `f56_aff_policy` contains scenarios determining for the three sources (vegetation, litter, soil) the share of co2 that will be priced.

table f56_aff_policy(co2_forestry,aff56) afforestation policy scenarios
$ondelim
$include "./modules/56_ghg_policy/input/f56_aff_policy.csv"
$offdelim
;
