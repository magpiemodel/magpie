*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


table f70_feed_baskets(t_all,i,kap,kall) feed baskets (t DM per t DM livestock product)
$ondelim
$include "./modules/70_livestock/fbask_jan16/input/f70_feed_baskets.cs3"
$offdelim;

table f70_feed_balanceflow(t_all,i,kap,kall) Balanceflow in mio ton DM to balance difference between estimated feed baskets and FAO
$ondelim
$include "./modules/70_livestock/fbask_jan16/input/f70_feed_balanceflow.cs3"
$offdelim;

table f70_livestock_productivity(t_all,i,kli,scen) Productivity indicator for livestock production (t FM per animal)
$ondelim
$include "./modules/70_livestock/fbask_jan16/input/f70_livestock_productivity.cs3"
$offdelim;

table f70_cost_regr(kli,cost_regr) factor requirements livestock (US$04 per ton DM (A) and US$ (B))
$ondelim
$include "./modules/70_livestock/fbask_jan16/input/f70_capit_liv_regr.csv"
$offdelim
;