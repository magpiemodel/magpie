*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Cropland

*' @description Cropland is the sum of croparea, fallow land and tree cover. Croparea is provided from [30_crop].
*' Fallow land and tree cover are defined in this module, either exogenous via prescribed rules or endognous via monetary incentives. 


*' @authors Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%cropland%" == "rulebased_apr24" $include "./modules/29_cropland/rulebased_apr24/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
