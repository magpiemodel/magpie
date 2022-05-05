*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalar
s38_factor_irrigation      Factor to increase irrigation costs / 1 /
s38_shock_year  Year from which policy shock will be implemented / 1995 /
;


table f38_fac_req(i,kcr,w) Factor requirement costs (USD05MER per tDM)
$ondelim
$include "./modules/38_factor_costs/mixed_reg_feb17/input/f38_fac_req_reg.csv"
$offdelim;


table f38_region_yield(i,kcr) Regional crop yields (tDM per ha)
$ondelim
$include "./modules/38_factor_costs/mixed_reg_feb17/input/f38_region_yield.csv"
$offdelim;

parameter f38_reg_parameters(reg) Parameters for capital share regression
/
$ondelim
$include "./modules/38_factor_costs/input/f38_regression_cap_share.csv"
$offdelim
/
;

table f38_historical_share(t_all,i) Historical capital share
$ondelim
$include "./modules/38_factor_costs/input/f38_historical_share.csv"
$offdelim
;
