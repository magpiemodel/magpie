*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the off realization, Timber production is set to 0.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/27_timber/off/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/27_timber/off/declarations.gms"
$Ifi "%phase%" == "equations" $include "./modules/27_timber/off/equations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/27_timber/off/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/27_timber/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
