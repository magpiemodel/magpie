*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Cropland

*' @description Cropland is defined as the sum of croparea, fallow land and tree cover on cropland. 
*' Croparea and corresponding carbon stocks are provided from [30_crop].
*' Area and carbon stocks for fallow land and tree cover are defined in this module.


*' @authors Florian Humpenöder, Benjamin Bodirsky, Patrick v. Jeetze

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%cropland%" == "detail_apr24" $include "./modules/29_cropland/detail_apr24/realization.gms"
$Ifi "%cropland%" == "simple_apr24" $include "./modules/29_cropland/simple_apr24/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
