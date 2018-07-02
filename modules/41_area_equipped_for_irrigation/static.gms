*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' This realization assures that irrigated crop production can only take place where
*' irrigation infrastructure is present.
*'
*' i.e. the sum of irrigated cropland `vm_area(j,kcr,"irrigated")` over all crops in each grid
*' cell has to be less than or equal to the area in this grid cell that is equipped with irrigation
*' infrastructure `v41_AEI(j)`.
*'
*' Area equipped for irrigation is fixed to input data (around the year 2000) for all time steps.
*' Source of the input data is @siebert_FAO_2007:
*'
*' @limitations No irrigation possible on areas that have not been equipped for irrigation in the past.
*'

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/41_area_equipped_for_irrigation/static/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/41_area_equipped_for_irrigation/static/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/41_area_equipped_for_irrigation/static/equations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/41_area_equipped_for_irrigation/static/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/41_area_equipped_for_irrigation/static/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
