*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalars
  c60_biodem_level  bioenergy demand level indicator 1 for regional and 0 for global demand   (1)   / 1 /
  c60_bioenergy_subsidy first generation bioenergy subsidy (USD05MER per ton) / 300 /
;

$setglobal c60_2ndgen_biodem  R2M41-SSP2-NPi

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

$setglobal c60_res_2ndgenBE_dem  ssp5
*   options:    ssp1,ssp2,ssp3,ssp4,ssp5,off

table f60_res_2ndgenBE_dem(t_all,i,scen2ndres60) annual residue demand for 2nd generation bioenergy(regional) (mio. GJ per yr)
$ondelim
$include "./modules/60_bioenergy/input/f60_2ndgenBE_residue_dem.cs3"
$offdelim
;


$setglobal c60_1stgen_biodem  phaseout2020
*   options:  "const2020", "const2030", "phaseout2020"

table f60_1stgen_bioenergy_dem(t_all,i,scen1st60,kall) annual 1st generation bioenergy demand (mio. GJ per yr)
$ondelim
$include "./modules/60_bioenergy/input/f60_1stgen_bioenergy_dem.cs3"
$offdelim
;
