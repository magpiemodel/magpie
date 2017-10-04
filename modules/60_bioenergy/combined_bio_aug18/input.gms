*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


scalars
  c60_biodem_level  bioenergy demand level (1: regional 0: global)  / 1 /
;

$setglobal c60_combined_biodem  const2030.SSP2-Ref-SPA0

*   options:  const2030.SSP1-Ref-SPA0,    const2030.SSP2-Ref-SPA0,    const2030.SSP5-Ref-SPA0,    const2030.SSP1-20-SPA0,
*  const2030.SSP1-26-SPA0,     const2030.SSP1-37-SPA0,     const2030.SSP1-45-SPA0,     const2030.SSP2-20-SPA0,
*  const2030.SSP2-26-SPA0,     const2030.SSP2-37-SPA0,     const2030.SSP2-45-SPA0,     const2030.SSP2-60-SPA0,
*  const2030.SSP5-20-SPA0,     const2030.SSP5-26-SPA0,     const2030.SSP5-37-SPA0,     const2030.SSP5-45-SPA0,
*  const2030.SSP5-60-SPA0,     const2030.SSP1-20-SPA1,     const2030.SSP1-26-SPA1,     const2030.SSP1-37-SPA1,
*  const2030.SSP1-45-SPA1,     const2030.SSP2-20-SPA2,     const2030.SSP2-26-SPA2,     const2030.SSP2-37-SPA2,
*  const2030.SSP2-45-SPA2,     const2030.SSP2-60-SPA2,     const2030.SSP2-OS-SPA2,     const2030.SSP5-20-SPA5,
*  const2030.SSP5-26-SPA5,     const2030.SSP5-37-SPA5,     const2030.SSP5-45-SPA5,     const2030.SSP5-60-SPA5,
*  const2030.SSP5-OS-SPA5,     const2020.SSP1-Ref-SPA0,    const2020.SSP2-Ref-SPA0,    const2020.SSP5-Ref-SPA0,
*  const2020.SSP1-20-SPA0,     const2020.SSP1-26-SPA0,     const2020.SSP1-37-SPA0,     const2020.SSP1-45-SPA0,
*  const2020.SSP2-20-SPA0,     const2020.SSP2-26-SPA0,     const2020.SSP2-37-SPA0,     const2020.SSP2-45-SPA0,
*  const2020.SSP2-60-SPA0,     const2020.SSP5-20-SPA0,     const2020.SSP5-26-SPA0,     const2020.SSP5-37-SPA0,
*  const2020.SSP1-37-SPA1,     const2020.SSP1-45-SPA1,     const2020.SSP2-20-SPA2,     const2020.SSP2-26-SPA2,
*  const2020.SSP2-37-SPA2,     const2020.SSP2-45-SPA2,     const2020.SSP2-60-SPA2,     const2020.SSP2-OS-SPA2,
*  const2020.SSP5-20-SPA5,     const2020.SSP5-26-SPA5,     const2020.SSP5-37-SPA5,     const2020.SSP5-45-SPA5,
*  const2020.SSP5-60-SPA5,     const2020.SSP5-OS-SPA5,     phaseout2020.SSP1-Ref-SPA0, phaseout2020.SSP2-Ref-SPA0,
*  phaseout2020.SSP5-Ref-SPA0, phaseout2020.SSP1-20-SPA0,  phaseout2020.SSP1-26-SPA0,  phaseout2020.SSP1-37-SPA0,
*  phaseout2020.SSP1-45-SPA0,  phaseout2020.SSP2-20-SPA0,  phaseout2020.SSP2-26-SPA0,  phaseout2020.SSP2-37-SPA0,
*  phaseout2020.SSP2-45-SPA0,  phaseout2020.SSP2-60-SPA0,  phaseout2020.SSP5-20-SPA0,  phaseout2020.SSP5-26-SPA0,
*  phaseout2020.SSP5-37-SPA0,  phaseout2020.SSP5-45-SPA0,  phaseout2020.SSP5-60-SPA0,  phaseout2020.SSP1-20-SPA1,
*  phaseout2020.SSP1-26-SPA1,  phaseout2020.SSP1-37-SPA1,  phaseout2020.SSP1-45-SPA1,  phaseout2020.SSP2-20-SPA2,
*  phaseout2020.SSP2-26-SPA2,  phaseout2020.SSP2-37-SPA2,  phaseout2020.SSP2-45-SPA2,  phaseout2020.SSP2-60-SPA2,
*  phaseout2020.SSP5-45-SPA5,  phaseout2020.SSP5-60-SPA5,  phaseout2020.SSP5-OS-SPA5,  coupling

#Still needs to be changed. How does coupling work?
$if "%c60_combined_biodem%" == "coupling" table f60_bioenergy_combined_coupling(t_all,i) Bioenergy demand (regional) (10^6 GJ per year)
$if "%c60_combined_biodem%" == "coupling" $ondelim
$if "%c60_combined_biodem%" == "coupling" $include "./modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv"
$if "%c60_combined_biodem%" == "coupling" $offdelim
$if "%c60_combined_biodem%" == "coupling" ;

table f60_bioenergy_combined(t_all,i,scenCombBio60) Combined Bioenergy demand (regional) (10^6 GJ per year)
$ondelim
$include "./modules/60_bioenergy/input/f60_bioenergy_combined.cs3"
$offdelim
;

#Can be deleted?
table f60_bioenergy_dem(t_all,i,scen2nd60) Bioenergy demand (regional) (10^6 GJ per year)
$ondelim
$include "./modules/60_bioenergy/input/f60_bioenergy_dem.cs3"
$offdelim
;

$setglobal c60_1stgen_biodem  const2020
*   options:  "const2020", "const2030", "phaseout2020"

table f60_1stgen_bioenergy_dem(t_all,i,scen1st60,kall) 1st generation bioenergy demand (10^6 GJ per year) [Lotze Campen (2014)]
$ondelim
$include "./modules/60_bioenergy/input/f60_1stgen_bioenergy_dem.cs3"
$offdelim
;
