*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the static realization natural vegetation is constant over time 
*' with the spatial distribution of 1995 from the LUH2 data set [@hurtt_harmonization_inprep].
*' Due to static land patterns also carbon stocks are static over time.

*' @limitations Land and carbon stocks of natural vegetation are static over time.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/35_natveg/static/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/35_natveg/static/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/35_natveg/static/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/35_natveg/static/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/35_natveg/static/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
