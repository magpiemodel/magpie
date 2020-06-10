*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description With the off realization, the model does not see any timber demand.
*' Correspondingly, there is no production of timber.

*' @limitations Timber production not simulated in the model

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/73_timber/off/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/73_timber/off/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/73_timber/off/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/73_timber/off/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/73_timber/off/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/73_timber/off/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/73_timber/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
