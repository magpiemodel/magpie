*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$setglobal c62_material_scenario  SSP2
*   options:   SSP: "SSP1", "SSP2", "SSP3", "SSP4", "SSP5"
*             SRES: "A1", "A2", "B1", "B2"
*            OTHER: "SSP1_boundary", "SSP2_boundary", "SSP3_boundary", "SSP4_boundary", "SSP5_boundary"


table f62_dem_material_total(t_all,i,material_scen62)  Demand for material products (Mt DM)
$ondelim
$include "./modules/62_material/input/f62_dem_material_total.cs3"
$offdelim;


table f62_dem_material_structure(t_all,i,kall)  Composition of material demand (share)
$ondelim
$include "./modules/62_material/input/f62_dem_material_structure.cs3"
$offdelim;
