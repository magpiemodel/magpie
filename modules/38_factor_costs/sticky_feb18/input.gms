*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalar
  s38_annual_depreciation_rate annual depreciation rate of farm capital (percent) /0.07/
;

parameter f38_fac_req_per_ton(kcr) Factor requirements (US$04 per ton DM)
/
$ondelim
$include "./modules/38_factor_costs/input/f38_fac_req_per_ton.csv"
$offdelim
/
;


table f38_croparea_initialisation(t_all,j,kcr) Initial croparea (Mha)
$ondelim
$include "./modules/38_factor_costs/sticky_feb18/input/f38_croparea_initialisation.cs3"
$offdelim;
