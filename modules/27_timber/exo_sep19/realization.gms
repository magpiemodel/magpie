*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the exo_sep19 realization, The productin of timber from
*' [32_forestry] and [35_natveg] is brought together. The model is free to
*' choose between the source of production of timber which can come from either
*' heavily managed plantation forests or natural forests.

*' @limitations wip

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/27_timber/exo_sep19/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/27_timber/exo_sep19/declarations.gms"
$Ifi "%phase%" == "equations" $include "./modules/27_timber/exo_sep19/equations.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/27_timber/exo_sep19/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/27_timber/exo_sep19/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
