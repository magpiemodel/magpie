*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/20_processing/substitution_dec18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/20_processing/substitution_dec18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/20_processing/substitution_dec18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/20_processing/substitution_dec18/equations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/20_processing/substitution_dec18/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/20_processing/substitution_dec18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
