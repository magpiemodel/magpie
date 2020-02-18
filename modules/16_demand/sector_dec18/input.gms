*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



table f16_seed_shr(t_all,i,kcr) Seed share relative to production from FAO-FBS (1)
$ondelim
$include "./modules/16_demand/sector_dec18/input/f16_seed_shr.csv"
$offdelim;

table f16_waste_shr(t_all,i,kall) Waste share relative to domestic supply from FAO-FBS (1)
$ondelim
$include "./modules/16_demand/sector_dec18/input/f16_waste_shr.csv"
$offdelim;

table fm_attributes(attributes,kall) Conversion factors - where X is ton N P K C DM WM or PJ GE (X per tDM)
$ondelim
$include "./modules/16_demand/sector_dec18/input/fm_attributes.cs3"
$offdelim;

table f16_domestic_balanceflow(t_all,i,kall) Balance flow for inconsistencies between domestic supply and use in FAO (mio. tDM per yr)
$ondelim
$include "./modules/16_demand/sector_dec18/input/f16_domestic_balanceflow.csv"
$offdelim;

table f16_forestry_demand(t_all,i,kforestry) demand
$ondelim
$include "./modules/16_demand/sector_dec18/input/f16_forestry_demand_20200212.csv"
$offdelim
;
f16_forestry_demand(t_all,"MEA","woodfuel") = f16_forestry_demand(t_all,"MEA","wood")*5;
