*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


scalars
  c60_biodem_level  bioenergy demand level indicator 1 for regional and 0 for global demand   (1)   / 1 /
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

$if "%c60_2ndgen_biodem%" == "coupling" table f60_bioenergy_dem_coupling(t_all,i) Bioenergy demand (regional) (mio. GJ per yr)
$if "%c60_2ndgen_biodem%" == "coupling" $ondelim
$if "%c60_2ndgen_biodem%" == "coupling" $include "./modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv"
$if "%c60_2ndgen_biodem%" == "coupling" $offdelim
$if "%c60_2ndgen_biodem%" == "coupling" ;

$if "%c60_2ndgen_biodem%" == "emulator" parameter f60_bioenergy_dem_emulator(t_all) Bioenergy demand (global) (mio. GJ per yr)
$if "%c60_2ndgen_biodem%" == "emulator" /
$if "%c60_2ndgen_biodem%" == "emulator" $ondelim
$if "%c60_2ndgen_biodem%" == "emulator" $include "./modules/60_bioenergy/input/glo.2ndgen_bioenergy_demand.csv"
$if "%c60_2ndgen_biodem%" == "emulator" $offdelim
$if "%c60_2ndgen_biodem%" == "emulator" /
$if "%c60_2ndgen_biodem%" == "emulator" ;

table f60_bioenergy_dem(t_all,i,scen2nd60) annual bioenergy demand (regional) (mio. GJ per yr)
$ondelim
$include "./modules/60_bioenergy/input/f60_bioenergy_dem.cs3"
$offdelim
;

$setglobal c60_res_2ndgenBE_dem  ssp2
*   options:    ssp1,ssp2,ssp3,ssp4,ssp5,off

table f60_res_2ndgenBE_dem(t_all,i,scen2ndres60) annual residue demand for 2nd generation bioenergy(regional) (mio. GJ per yr)
$ondelim
$include "./modules/60_bioenergy/input/f60_2ndgenBE_residue_dem.cs3"
$offdelim
;


$setglobal c60_1stgen_biodem  const2020
*   options:  "const2020", "const2030", "phaseout2020"

table f60_1stgen_bioenergy_dem(t_all,i,scen1st60,kall) annual 1st generation bioenergy demand (mio. GJ per yr)
$ondelim
$include "./modules/60_bioenergy/input/f60_1stgen_bioenergy_dem.cs3"
$offdelim
;
