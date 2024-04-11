*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' Emissions are set to zero.
*'
*' @authors Benjamin Leon Bodirsky

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/51_nitrogen/off/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/51_nitrogen/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/51_nitrogen/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
