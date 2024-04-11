*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Land

*' @description The land module coordinates and analyzes all land related activities
*' by summing up all land types and calculating the gross changes in land use
*' between two time steps of optimization given the recursive dynamic structure of
*' MAgPIE model. The land module tracks land use transitions by directly counting 
*' sources and targets of conversions.

*' @authors Jan Philipp Dietrich, Florian Humpenoeder, Kristine Karstens

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%land%" == "landmatrix_dec18" $include "./modules/10_land/landmatrix_dec18/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
