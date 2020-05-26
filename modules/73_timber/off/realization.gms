*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description With the off realization, there is no timber production in the
*' model

*' @limitations Timber production not simulated in the model

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/73_timber/off/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/73_timber/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/73_timber/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
