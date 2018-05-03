*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalars
  s56_reward_neg_emis reward negative co2 emissions / 0 /
;

$setglobal c56_pollutant_prices  SSP2-26-SPA0
$setglobal c56_emis_policy  ssp
$setglobal c56_aff_policy  vegc33

table f56_pollutant_prices(t_all,i,pollutants,ghgscen56) ghg certificate prices (US$ 2004 per Mg N2O-N CH4 and CO2-C)
$ondelim
$include "./modules/56_ghg_policy/input/f56_pollutant_prices.cs3"
$offdelim
;

$if "%c56_pollutant_prices%" == "coupling" table f56_pollutant_prices_coupling(t_all,i,pollutants) regional ghg certificate prices (US$ 2004 per Mg N2O-N CH4 and CO2-C)
$if "%c56_pollutant_prices%" == "coupling" $ondelim
$if "%c56_pollutant_prices%" == "coupling" $include "./modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3"
$if "%c56_pollutant_prices%" == "coupling" $offdelim
$if "%c56_pollutant_prices%" == "coupling" ;

$if "%c56_pollutant_prices%" == "emulator" table f56_pollutant_prices_emulator(t_all,pollutants) global ghg certificate prices (US$ 2004 per Mg N2O-N CH4 and CO2-C)
$if "%c56_pollutant_prices%" == "emulator" $ondelim
$if "%c56_pollutant_prices%" == "emulator" $include "./modules/56_ghg_policy/input/f56_pollutant_prices_emulator.cs3"
$if "%c56_pollutant_prices%" == "emulator" $offdelim
$if "%c56_pollutant_prices%" == "emulator" ;

table f56_emis_policy(scen56,pollutants_all,emis_source) emission policy scenarios
$ondelim
$include "./modules/56_ghg_policy/input/f56_emis_policy.csv"
$offdelim
;

table f56_aff_policy(emis_source_co2_forestry,aff56) afforestation policy scenarios
$ondelim
$include "./modules/56_ghg_policy/input/f56_aff_policy.csv"
$offdelim
;
