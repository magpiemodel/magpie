*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c14_yields_scenario  nocc
*   options:   cc  (climate change)
*             nocc (no climate change)

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
* set values to 1995 if nocc scenario is used
$if "%c14_yields_scenario%" == "nocc" f14_yields(t_all,j,kve,w) = f14_yields("y1995",j,kve,w);
m_fillmissingyears(f14_yields,"j,kve,w");

table f14_pyld_hist(t_all,i) Modelled regional pasture yields in the past (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/f14_pasture_yields_hist.csv"
$offdelim;

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
