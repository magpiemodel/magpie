*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' The realization substitution_may21 excludes the calibration factors that are used in substitution_dec18 in order to reduce the substitution of oils by other oils.
*'
*' @authors Benjamin Leon Bodirsky, Florian Humpenöder, Edna Molina Bacca

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/20_processing/substitution_may21/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/20_processing/substitution_may21/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/20_processing/substitution_may21/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/20_processing/substitution_may21/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/20_processing/substitution_may21/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/20_processing/substitution_may21/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/20_processing/substitution_may21/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/20_processing/substitution_may21/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
