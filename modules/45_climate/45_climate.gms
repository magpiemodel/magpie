*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Climate
*'
*' @description The climate module provides information about the present
*' climate classes in the different cells (as shares of the total cell).
*' This information is used by other modules to choose climate class dependent
*' factors such as growth parameters correctly (e.g. used in [35_natveg]).
*'
*' @authors Jan Philipp Dietrich

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%climate%" == "static" $include "./modules/45_climate/static.gms"
*###################### R SECTION END (MODULETYPES) ############################
