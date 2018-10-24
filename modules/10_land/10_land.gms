*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Land

*' @description The land module coordinates and analyzes all land related activities
*' by summing up all land types and calculating the gross changes in land use
*' between two time steps of optimization given the recursive dynamic structure of
*' MAgPIE model.

*' @authors Jan Philipp Dietrich

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%land%" == "feb15" $include "./modules/10_land/feb15.gms"
*###################### R SECTION END (MODULETYPES) ############################
