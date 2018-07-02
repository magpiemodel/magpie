*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



table f38_fac_req(kcr,w) factor requirement costs (USD per tDM)
$ondelim
$include "./modules/38_factor_costs/input/f38_fac_req.csv"
$offdelim;

table f38_region_yield(i,kcr) regional crop yields (tDM per ha)
$ondelim
$include "./modules/38_factor_costs/mixed_feb17/input/f38_region_yield.csv"
$offdelim;
