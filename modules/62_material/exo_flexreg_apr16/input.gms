*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


table f62_dem_material(t_all,i,kall)  Historical material demand (mio. tDM)
$ondelim
$include "./modules/62_material/input/f62_dem_material.cs3"
$offdelim;

table f62_bioplastic2biomass(kall)  Biomass demand for one unit of bioplastics (mio. tDM)
$ondelim
$include "./modules/62_material/input/f62_bioplastic2biomass.cs3"
$offdelim;

table f62_hist_bioplastic_demand(t_all)  Historic demand for bioplastics (mio. t)
$ondelim
$include "./modules/62_material/input/f62_hist_bioplastic_demand.cs3"
$offdelim;

scalar s62_max_demand_bioplastics maximum demand for bioplastics / 0 /;