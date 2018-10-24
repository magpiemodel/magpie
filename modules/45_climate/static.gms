*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization climate classification information remains
*' static over the whole simulation based on data for 1976-2000 taken from
*' <http://koeppen-geiger.vu-wien.ac.at/shifts.htm> (@rubel_observed_2010).
*'
*' @limitations Temporal variations in climate classification are not considered.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/45_climate/static/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/45_climate/static/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/45_climate/static/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/45_climate/static/preloop.gms"
*######################## R SECTION END (PHASES) ###############################
