*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

$setglobal c14_yields_scenario  nocc
*   options:   cc  (climate change)
*             nocc (no climate change)

scalars
  s14_pyld_intercept intercept of linear relationship determining pasture intensification (1)  / 0.24 /
  s14_pyld_slope     slope of linear relationship determining pasture intensification (1)      / 0.78 /
;

******* Calibration factor
table f14_yld_calib(i,ltype14) Calibration factor for the LPJ yields (1)
$ondelim
$include "./modules/14_yields/input/f14_yld_calib.csv"
$offdelim;

table f14_yields(t_all,j,kve,w) LPJ potential yields per cell (rainfed and irrigated) (tDM per ha)
$ondelim
$include "./modules/14_yields/input/lpj_yields.cs3"
$offdelim
;
* set values to 1995 if nocc scenario is used
$if "%c14_yields_scenario%" == "nocc" f14_yields(t_all,j,kve,w) = f14_yields("y1995",j,kve,w);
m_fillmissingyears(f14_yields,"j,kve,w");


parameter f14_pyld_slope_reg(i) regional slope of linear relationship determining pasture intensification (1)
/
$ondelim
$include "./modules/14_yields/input/f14_pyld_slope_reg.cs4"
$offdelim
/;
