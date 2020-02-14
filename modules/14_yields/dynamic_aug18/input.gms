*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c14_yields_scenario  nocc
*   options:   cc  (climate change)
*             nocc (no climate change)

******* Calibration factor
table f14_yld_calib(i,ltype14) Calibration factor for the LPJmL yields (1)
$ondelim
$include "./modules/14_yields/input/f14_yld_calib.csv"
$offdelim;

table f14_yields(t_all,j,kve,w) LPJmL potential yields per cell (rainfed and irrigated) (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/lpj_yields.cs3"
$offdelim
;
* set values to 1995 if nocc scenario is used
$if "%c14_yields_scenario%" == "nocc" f14_yields(t_all,j,kve,w) = f14_yields("y1995",j,kve,w);
m_fillmissingyears(f14_yields,"j,kve,w");

table f14_pyld_hist(t_all,i) Modelled regional pasture yields in the past (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/f14_pasture_yields_hist.csv"
$offdelim;

table f14_ipcc_bce(clcl,forest_type,ac_sub) npi+indc afforestation policy (Mha new forest wrt to 2010)
$ondelim
$include "./modules/14_yields/input/f14_ipcc_bce.cs3"
$offdelim
;

$if "%c14_bef%" == "ipccBEF" f14_ipcc_bce(clcl,forest_type,ac_sub) = f14_ipcc_bce(clcl,forest_type,ac_sub);
$if "%c14_bef%" == "BEF0p25" f14_ipcc_bce(clcl,forest_type,ac_sub) = 0.25;
$if "%c14_bef%" == "BEF0p5" f14_ipcc_bce(clcl,forest_type,ac_sub) = 0.5;
$if "%c14_bef%" == "BEF0p75" f14_ipcc_bce(clcl,forest_type,ac_sub) = 0.75;
$if "%c14_bef%" == "BEF1p0" f14_ipcc_bce(clcl,forest_type,ac_sub) = 1;
$if "%c14_bef%" == "BEF2p0" f14_ipcc_bce(clcl,forest_type,ac_sub) = 2;
