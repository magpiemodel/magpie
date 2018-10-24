*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' In this realization, area equipped for irrigation is fixed to input data (around the year 2000)
*' for all time steps. The source of the input data is @siebert_FAO_2007.
*'
*' @limitations No irrigation is possible on areas that have not been equipped for irrigation in the past.
*'

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/41_area_equipped_for_irrigation/static/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/41_area_equipped_for_irrigation/static/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/41_area_equipped_for_irrigation/static/equations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/41_area_equipped_for_irrigation/static/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/41_area_equipped_for_irrigation/static/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
