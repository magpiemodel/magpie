*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' In this realization, area equipped for irrigation is fixed to input data (around the year 2000)
*' for all time steps. The sources of the input data are @siebert_FAO_2013 and @mehta_half_2024.
*'
*' @limitations No irrigation is possible on areas that have not been equipped for irrigation in the past.
*'

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/41_area_equipped_for_irrigation/static/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/41_area_equipped_for_irrigation/static/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/41_area_equipped_for_irrigation/static/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/41_area_equipped_for_irrigation/static/equations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/41_area_equipped_for_irrigation/static/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/41_area_equipped_for_irrigation/static/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
