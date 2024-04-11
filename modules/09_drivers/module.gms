*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Drivers
*'
*' @description The Drivers module provides data on drivers
*' that are used by several other modules. It mainly aggregates inputs related 
*' to population and GDP. If an input is required in one module or realization only, 
*' the input driver is provided directly by the module that demands it, 
*' rather than by the [09_drivers] module. 
*'
*' @authors Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%drivers%" == "aug17" $include "./modules/09_drivers/aug17/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
