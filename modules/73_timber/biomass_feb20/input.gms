*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

table f73_observed_timber_demand_pc(t_all,iso,total_wood_products)  FAO data for observed timber demand (mio. m3 per capita per year)
$ondelim
$include "./modules/73_timber/input/f73_observed_timber_demand_pc.csv"
$offdelim
;
m_fillmissingyears(f73_observed_timber_demand_pc,"iso,total_wood_products");

table f73_forestry_demand(t_all,iso,kforestry) demand
$ondelim
$include "./modules/73_timber/input/f16_forestry_demand_iso.csv"
$offdelim
;
f73_forestry_demand(t_past_ff,iso,kforestry) = f73_forestry_demand("y1995",iso,kforestry);
