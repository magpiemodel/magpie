*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The landmatrix_dec18 realization tracks land use transitions by
*' directly counting sources and targets of conversions.

*' @limitations There are currently no known limitations of this realization.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/10_land/landmatrix_jan20/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/10_land/landmatrix_jan20/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/10_land/landmatrix_jan20/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/10_land/landmatrix_jan20/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/10_land/landmatrix_jan20/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/10_land/landmatrix_jan20/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/10_land/landmatrix_jan20/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/10_land/landmatrix_jan20/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
