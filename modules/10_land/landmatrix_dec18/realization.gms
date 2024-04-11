*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The landmatrix_dec18 realization tracks land use transitions by
*' directly counting sources and targets of conversions.

*' @limitations This realization only accounts for net land use transitions.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/10_land/landmatrix_dec18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/10_land/landmatrix_dec18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/10_land/landmatrix_dec18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/10_land/landmatrix_dec18/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/10_land/landmatrix_dec18/scaling.gms"
$Ifi "%phase%" == "start" $include "./modules/10_land/landmatrix_dec18/start.gms"
$Ifi "%phase%" == "preloop" $include "./modules/10_land/landmatrix_dec18/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/10_land/landmatrix_dec18/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/10_land/landmatrix_dec18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
