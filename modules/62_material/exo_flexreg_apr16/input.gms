*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


table f62_dem_material(t_all,i,kall)  Historical material demand (mio. tDM)
$ondelim
$include "./modules/62_material/input/f62_dem_material.cs3"
$offdelim;

parameter f62_biomass2bioplastic_conversion_ratio(kall)  Biomass demand for one unit of bioplastics (tDM biomass per tDM bioplastic)
/
$ondelim
$include "./modules/62_material/input/f62_bioplastic2biomass.csv"
$offdelim
/
;

parameter f62_hist_dem_bioplastic(t_all)  Historic demand for bioplastics (mio. tDM)
/
$ondelim
$include "./modules/62_material/input/f62_hist_dem_bioplastic.csv"
$offdelim
/
;

scalar s62_max_dem_bioplastic maximum demand for bioplastics (mio. tDM per yr) / 0 /;
scalar s62_midpoint_dem_bioplastic midpoint of logistic function for bioplastic demand (yr) / 2050 /;
