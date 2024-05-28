*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Timber
*'
*' @description This module provides demand for forestry products via the interface `pm_demand_forestry` 
*' to the modules [32_forestry] and [62_material], and merges production of timber from 
*' different sources into the interface `vm_prod`, which is used in the [17_production] and
*' [21_trade] modules. 
*'
*' @authors Abhijeet Mishra, Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%timber%" == "default" $include "./modules/73_timber/default/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
