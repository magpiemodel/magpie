*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



table f16_seed_shr(t_all,i,kcr) seed share relative to production (1) [FAO - FBS]
$ondelim
$include "./modules/16_demand/sector_may15/input/f16_seed_shr.csv"
$offdelim;

table f16_waste_shr(t_all,i,kall) waste share relative to domestic supply(1) [FAO - FBS]
$ondelim
$include "./modules/16_demand/sector_may15/input/f16_waste_shr.csv"
$offdelim;

table fm_attributes(attributes,kall) ton X per ton DM except gross energy where it is PJ per Mt DM
$ondelim
$include "./modules/16_demand/sector_may15/input/fm_attributes.cs3"
$offdelim;

table f16_domestic_balanceflow(t_all,i,kall) balance flow fo inconsistencies between domestic supply and use in FAO in Mt DM
$ondelim
$include "./modules/16_demand/sector_may15/input/f16_domestic_balanceflow.csv"
$offdelim;
