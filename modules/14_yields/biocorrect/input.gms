*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c14_yields_scenario  nocc
*   options:  cc        (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)

scalars
  s14_yld_past_switch  Spillover parameter for translating technological change in the crop sector into pasture yield increases  (1)     / 0.25 /
;

******* Calibration factor
table f14_yld_calib(i,ltype14) Calibration factor for the LPJ yields (1)
$ondelim
$include "./modules/14_yields/input/f14_yld_calib.csv"
$offdelim;

table f14_yields(t_all,j,kve,w) LPJ potential yields per cell (rainfed and irrigated) (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/lpj_yields.cs3"
$offdelim
;
* set values to 1995 if nocc scenario is used, or to sm_fix_cc after sm_fix_cc if nocc_hist is used
$if "%c14_yields_scenario%" == "nocc" f14_yields(t_all,j,kve,w) = f14_yields("y1995",j,kve,w);
$if "%c14_yields_scenario%" == "nocc_hist" f14_yields(t_all,j,kve,w)$(m_year(t_all) > sm_fix_cc) = f14_yields(t_all,j,kve,w)$(m_year(t_all) = sm_fix_cc);
m_fillmissingyears(f14_yields,"j,kve,w");
