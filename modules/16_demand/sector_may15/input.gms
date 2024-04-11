*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



table f16_seed_shr(t_all,i,kcr) Seed share relative to production from FAO-FBS (1)
$ondelim
$include "./modules/16_demand/sector_may15/input/f16_seed_shr.csv"
$offdelim;

table f16_waste_shr(t_all,i,kall) Waste share relative to domestic supply from FAO-FBS (1)
$ondelim
$include "./modules/16_demand/sector_may15/input/f16_waste_shr.csv"
$offdelim;

table fm_attributes(attributes,kall) Conversion factors - where X is ton N P K C DM WM or PJ GE (X per tDM)
$ondelim
$include "./modules/16_demand/sector_may15/input/fm_attributes.cs3"
$offdelim;

table f16_domestic_balanceflow(t_all,i,kall) Balance flow for inconsistencies between domestic supply and use in FAO (mio. tDM per yr)
$ondelim
$include "./modules/16_demand/sector_may15/input/f16_domestic_balanceflow.csv"
$offdelim;
