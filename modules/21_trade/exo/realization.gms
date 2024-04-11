*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization, agricultural trade is fully prescribed
*' exogenously. This also means that there is no interaction between regions
*' as amounts of exports and imports are fix.


*' @limitations regions are completely separated and do not interact with
*' each other

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/21_trade/exo/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/21_trade/exo/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/21_trade/exo/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/21_trade/exo/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/21_trade/exo/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/21_trade/exo/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
