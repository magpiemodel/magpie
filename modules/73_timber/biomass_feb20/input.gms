*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
  s73_timber_demand Switch for timber demand / 1 /
;

table f73_observed_timber_demand_pc(t_all,iso,total_wood_products)  FAO data for observed timber demand (mio. m3 per capita per year)
$ondelim
$include "./modules/73_timber/input/f73_observed_timber_demand_pc.csv"
$offdelim
;
m_fillmissingyears(f73_observed_timber_demand_pc,"iso,total_wood_products");

table f73_prod_specific_timber(t_all,iso,total_wood_products) demand
$ondelim
$include "./modules/73_timber/input/f73_prod_specific_timber.csv"
$offdelim
;
