*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
$Ifi "%climate%" == "static" $include "./modules/45_climate/static/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
