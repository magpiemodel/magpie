*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


scalars
  c60_biodem_level  bioenergy demand level (1: regional 0: global)  / 1 /
;

$setglobal c60_2ndgen_biodem  SSP2-Ref-SPA0
*   options:  SSP1-Ref-SPA0, SSP2-Ref-SPA0, SSP5-Ref-SPA0,
*             SSP1-26-SPA0, SSP1-37-SPA0, SSP1-45-SPA0,
*             SSP2-26-SPA0, SSP2-37-SPA0, SSP2-45-SPA0, SSP2-60-SPA0,
*             SSP5-26-SPA0, SSP5-37-SPA0, SSP5-45-SPA0, SSP5-60-SPA0,
*             SSP1-26-SPA1, SSP1-37-SPA1, SSP1-45-SPA1,
*             SSP2-26-SPA2, SSP2-37-SPA2, SSP2-45-SPA2, SSP2-60-SPA2,
*             SSP5-26-SPA5, SSP5-37-SPA5, SSP5-45-SPA5, SSP5-60-SPA5,
*             coupling

$if "%c60_2ndgen_biodem%" == "coupling" table f60_bioenergy_dem_coupling(t_all,i) Bioenergy demand (regional) (10^6 GJ per year)
$if "%c60_2ndgen_biodem%" == "coupling" $ondelim
$if "%c60_2ndgen_biodem%" == "coupling" $include "./modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv"
$if "%c60_2ndgen_biodem%" == "coupling" $offdelim
$if "%c60_2ndgen_biodem%" == "coupling" ;

table f60_bioenergy_dem(t_all,i,scen2nd60) second Bioenergy demand (regional) (10^6 GJ per year)
$ondelim
$include "./modules/60_bioenergy/input/f60_bioenergy_dem.cs3"
$offdelim
;


$setglobal c60_1stgen_biodem  const2020
*   options:  "const2020", "const2030", "phaseout2020"

table f60_dem_1stgen_bioen(t_all,i,scen1st60,bioen1st60) 1st generation bioenergy demand (PJ per year) from IEA
$ondelim
$include "./modules/60_bioenergy/input/f60_dem_1stgen_bioen_new.cs3"
$offdelim
;
