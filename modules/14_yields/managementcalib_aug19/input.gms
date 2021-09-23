*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c14_yields_scenario  cc
*   options:  cc        (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)

scalar s14_limit_calib   Relative managament calibration switch (1=limited 0=pure relative) / 1 /;

scalars
  s14_yld_past_switch  Spillover parameter for translating technological change in the crop sector into pasture yield increases  (1)     / 0.25 /
;

scalars
  s14_timber_plantation_yield Plantation yield switch (0=natveg yields 1=plantation yields) (1) / 1 /
  s14_carbon_fraction Carbon fraction for conversion of biomass to dry matter (1) / 0.5/
;


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
* set values to 1995 if nocc scenario is used, or to sm_fix_cc after sm_fix_cc if nocc_hist is used
$if "%c14_yields_scenario%" == "nocc" f14_yields(t_all,j,kve,w) = f14_yields("y1995",j,kve,w);
$if "%c14_yields_scenario%" == "nocc_hist" f14_yields(t_all,j,kve,w)$(m_year(t_all) > sm_fix_cc) = f14_yields(t_all,j,kve,w)$(m_year(t_all) = sm_fix_cc);
m_fillmissingyears(f14_yields,"j,kve,w");

table f14_pyld_hist(t_all,i) Modelled regional pasture yields in the past (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/f14_pasture_yields_hist.csv"
$offdelim;


table f14_fao_yields_hist(t_all,i,kcr) FAO yields per region (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/managementcalib_aug19/input/f14_region_yields.cs3"
$offdelim
;
m_fillmissingyears(f14_fao_yields_hist,"i,kcr");

table f14_ipcc_bce(clcl,forest_type) IPCC Biomass Conversion and Expansion factors (1)
$ondelim
$include "./modules/14_yields/input/f14_ipcc_bce.cs3"
$offdelim
;

parameter f14_aboveground_fraction(forest_land) Root to shoot ratio (1)
/
$ondelim
$include "./modules/14_yields/input/f14_aboveground_fraction.csv"
$offdelim
/
;
