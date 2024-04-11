*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization climate classification information remains
*' static over the whole simulation based on data for 1976-2000 taken from
*' <http://koeppen-geiger.vu-wien.ac.at/shifts.htm> (@rubel_observed_2010).
*'
*' @limitations Temporal variations in climate classification are not considered.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/45_climate/static/sets.gms"
$Ifi "%phase%" == "input" $include "./modules/45_climate/static/input.gms"
*######################## R SECTION END (PHASES) ###############################
