*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



table f45_koeppengeiger(j,clcl) Koeppen-Geiger climate classification on the simulation cluster level (1)
$ondelim
$include "./modules/45_climate/static/input/koeppen_geiger.cs3"
$offdelim;

parameter f45_bcef(ac,clcl) BCEF by Koeppen-Geiger classification mapped to age-classes (-)
/
$ondelim
$include "./modules/45_climate/static/input/45_BCE_kg_ac.csv"
$offdelim
/;

table fm_climate_class(j,clcl) Koeppen-Geiger climate classification on the simulation cluster level (1)
$ondelim
$include "./modules/45_climate/static/input/koeppen_geiger.cs3"
$offdelim;
