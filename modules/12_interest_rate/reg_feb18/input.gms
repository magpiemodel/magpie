*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

$setglobal c12_interest_rate  medium

scalars
  sm_invest_horizon investment time horizon (years)                 / 30 /
;

table f12_interest(scen12) real interest rate scenarios
$ondelim
$include "./modules/12_interest_rate/input/f12_interest_rate_bound.cs3"
$offdelim
;


$if "%c12_interest_rate%" == "coupling" parameter f12_interest_coupling(t_all) interest rate (% per year)
$if "%c12_interest_rate%" == "coupling" /
$if "%c12_interest_rate%" == "coupling" $ondelim
$if "%c12_interest_rate%" == "coupling" $include "./modules/12_interest_rate/input/f12_interest_rate_coupling.csv"
$if "%c12_interest_rate%" == "coupling" $offdelim
$if "%c12_interest_rate%" == "coupling" /
$if "%c12_interest_rate%" == "coupling" ;