*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @title Cropland

*' @description The cropland module simulates the dynamics of cropland area and
*' agricultural crop production and calculates corresponding carbon contents and
*' the biodiversity value of the existing cropland.

*' @authors Jan Philipp Dietrich, Florian Humpenöder, Benjamin Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%croparea%" == "detail_apr24" $include "./modules/30_croparea/detail_apr24/realization.gms"
$Ifi "%croparea%" == "simple_apr24" $include "./modules/30_croparea/simple_apr24/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
